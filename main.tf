terraform {

  required_version = "~> 1.2"

  cloud {}

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.41.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.9"
    }
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.4.0"
    }
  }

}

# Hetzner Cloud Provider
provider "hcloud" {
  token = var.hetzner_cloud_token
}

# Cloudflare Provider
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "zerotier" {
  zerotier_central_token = var.zerotier_central_api_token
}
