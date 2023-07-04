locals {
  enabled_firewall_rules = [
    hcloud_firewall.allow_ssh.id,
    hcloud_firewall.allow_https.id,
    hcloud_firewall.allow_zerotier.id,
  ]
}


resource "hcloud_firewall" "allow_ssh" {
  name = "allow-ssh"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "allow_https" {
  name = "allow-https"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "allow_zerotier" {
  name = "allow-zerotier"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "9993"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "allow_nextcloud_admin" {
  name = "allow-nextcloud-admin"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "8080"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "8443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}
