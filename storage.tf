resource "hcloud_volume" "data" {
  name     = "${var.hostname}-data"
  location = var.instance_location
  size     = var.storage_size_gb
  format   = "ext4"
  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_volume_attachment" "data" {
  volume_id = hcloud_volume.data.id
  server_id = hcloud_server.main.id
  automount = true
}
