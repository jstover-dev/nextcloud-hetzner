resource "hcloud_ssh_key" "nextcloud" {
  for_each   = var.authorized_hosts
  name       = "${var.hostname}-${each.key}"
  public_key = each.value
}

data "hcloud_image" "latest" {
  name              = var.image_name
  most_recent       = true
  with_status       = ["available"]
  with_architecture = var.cpu_arch
}

resource "hcloud_server" "main" {
  name         = var.hostname
  server_type  = var.instance_type
  image        = data.hcloud_image.latest.id
  location     = var.instance_location
  ssh_keys     = [for key in hcloud_ssh_key.nextcloud : key.id]
  firewall_ids = local.enabled_firewall_rules
  user_data    = data.template_file.cloud-init.rendered
}

data "template_file" "cloud-init" {
  template = file("cloud-init.tpl.yml")
  vars = {
    deployer_public_key = trimspace(var.deployer_ssh_key.public)
    admin_public_key    = var.authorized_hosts[keys(var.authorized_hosts)[0]]
    storage_device      = hcloud_volume.data.linux_device
    storage_format      = hcloud_volume.data.format
    storage_mountpoint  = "/mnt/HC_Volume_${hcloud_volume.data.id}"
    borg_cifs_location  = var.borg_backup_cifs.path
    borg_cifs_username  = var.borg_backup_cifs.smb_username
    borg_cifs_password  = var.borg_backup_cifs.smb_password
  }
}

resource "terraform_data" "bootstrap" {
  depends_on = [
    hcloud_server.main,
    hcloud_volume_attachment.data,
  ]
  triggers_replace = [
    hcloud_server.main.id
  ]
  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "cloud-init status --wait --long",
      "docker-compose pull -q",
      "docker-compose up -d",
      "sed -i '1d' ~/.ssh/authorized_keys"
    ]
    connection {
      host        = hcloud_server.main.ipv4_address
      user        = "nextcloud"
      private_key = base64decode(var.deployer_ssh_key.private_base64)
    }
  }
}
