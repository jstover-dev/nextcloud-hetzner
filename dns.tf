data "cloudflare_zone" "domain" {
  name = var.cloudflare_zone
}

resource "cloudflare_record" "nextcloud" {
  zone_id = data.cloudflare_zone.domain.id
  name    = var.hostname
  value   = hcloud_server.main.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = false
}
