data "zerotier_network" "homelab" {
  id = var.zerotier_network_id
}

resource "zerotier_identity" "nextcloud" {}

resource "zerotier_member" "nextcloud" {
  member_id               = zerotier_identity.nextcloud.id
  network_id              = data.zerotier_network.homelab.id
  description             = "Nextcloud (hetzner) - Managed by Terraform"
  authorized              = true
  hidden                  = false
  allow_ethernet_bridging = false
  no_auto_assign_ips      = false
}
