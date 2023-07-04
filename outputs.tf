output "ipv4_address" {
  value = hcloud_server.main.ipv4_address
}

output "ipv6_address" {
  value = hcloud_server.main.ipv6_address
}

output "hostname" {
  value = "${var.hostname}.${var.cloudflare_zone}"
}

output "urls" {
  value = {
    admin = "https://${var.hostname}.${var.cloudflare_zone}:8443"
    admin_self_signed = "https://${var.hostname}.${var.cloudflare_zone}:8080"
  }
}