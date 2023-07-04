# Hetzner config
# ----------------------------------------------------------------------------
variable "hetzner_cloud_token" {
  sensitive = true
  type      = string
}


# Cloudflare config
# ----------------------------------------------------------------------------
variable "cloudflare_api_token" {
  type = string
}

variable "cloudflare_zone" {
  type = string
}


# ZeroTier config
# ----------------------------------------------------------------------------
variable "zerotier_central_api_token" {
  sensitive = true
  type      = string
}

variable "zerotier_network_id" {
  type = string
}


# Host config
# ----------------------------------------------------------------------------
variable "instance_type" {
  type    = string
  default = "cx11"
  validation {
    condition = contains(
      [
        "cx11", "cx21", "cx31", "cx41", "cx51",
        "ccx11", "ccx21", "ccx31", "ccx41", "ccx51",
        "cpx11", "cpx21", "cpx31", "cpx41", "cpx51",
        "ccx12", "ccx22", "ccx32", "ccx42", "ccx52", "ccx62",
        "cax11", "cax21", "cax31", "cax41",
      ],
      var.instance_type
    )
    error_message = "Valid values for 'instance_type': (cx11, cx21, cx31, cx41, cx51, ccx11, ccx21, ccx31, ccx41, ccx51, cpx11, cpx21, cpx31, cpx41, cpx51, ccx12, ccx22, ccx32, ccx42, ccx52, ccx62, cax11, cax21, cax31, cax41)."
  }
}

variable "instance_location" {
  type    = string
  default = "fsn1"
  validation {
    condition     = contains(["fsn1", "nbg1", "hel1", "ash", "hil"], var.instance_location)
    error_message = "Valid values for 'instance_location': (fsn1, nbg1, hel1, ash, hil)"
  }
}

variable "hostname" {
  type    = string
  default = "nc"
}

variable "image_name" {
  type    = string
  default = "debian-11"
}

variable "cpu_arch" {
  type    = string
  default = "x86"
  validation {
    condition     = contains(["x86", "arm"], var.cpu_arch)
    error_message = "Valid values for 'cpu_arch': (x86, arm)"
  }
}

variable "storage_size_gb" {
  type    = number
  default = 25
}


# User config
# ----------------------------------------------------------------------------
variable "authorized_hosts" {
  type = map(string)
}

variable "deployer_ssh_key" {
  type = object({
    private_base64 = string
    public         = string
  })
}

# Backup to a remote CIFS share
variable "borg_backup_cifs" {
  type = object({
    path         = string
    smb_username = string
    smb_password = string
  })
  sensitive = true
}