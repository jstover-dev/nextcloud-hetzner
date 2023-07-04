output "ipv4_address" {
  value = hcloud_server.main.ipv4_address
}

output "ipv6_address" {
  value = hcloud_server.main.ipv6_address
}

output "hostname" {
  value = "${var.hostname}.${var.cloudflare_zone}"
}

output "aio_setup" {
  value = "https://${var.hostname}.${var.cloudflare_zone}:8443"
}

output "aio_self_signed" {
  value = "https://${var.hostname}.${var.cloudflare_zone}:8080"
}
