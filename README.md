# Nextcloud deployment to Hetzner Cloud

Terraform configuration for deploying a Nextcloud AIO instance to an existing Hetzner Cloud project.


## Setup

### Configure local environment


```shell
# .envrc

# Hetzner Cloud API token for the target project
export HETZNER_CLOUD_TOKEN=

# Terraform Cloud organisation
export TF_CLOUD_ORGANIZATION=

# Terraform Cloud workspace name
export TF_WORKSPACE=

# Terraform Cloud API Token
export TERRAFORM_CLOUD_TOKEN=
```

If you are not using Terraform Cloud:
- Only `HETZNER_CLOUD_TOKEN` environment variable is required
- Edit `main.tf` and remove line 5 containing: `cloud {}`

### Generate SSH key for deployment

This key is only used for the initial deployment.
Copy the resulting public and (base64-encoded) private strings into the `deployer_ssh_key` Terraform variable.

```shell
# 1. Generate key file
$ ssh-keygen -N "" -t ed25519 -C nextcloud-deploy-key -f nextcloud-deploy-key

# 2. Obtain base64-encoded private key:
$ base64 -w0 nextcloud-deploy-key

# 3. Obtain public key
$ cat nextcloud-deploy-key

# 4. (copy the resulting strings to Terraform config)

# 5. Remove the key files as they are no longer useful
rm nextcloud-deploy-key nextcloud-deploy-key.pub
```

### Configure Infrastructure

```terraform
# Hetzner config
# ----------------------------------------------------------------------------
hetzner_cloud_token = "..."


# Cloudflare config
# ----------------------------------------------------------------------------
cloudflare_api_token = "..."
cloudflare_zone      = "example.com"


# ZeroTier config
# ----------------------------------------------------------------------------
zerotier_central_api_token = "..."
zerotier_network_id        = "..."


# Host config
# ----------------------------------------------------------------------------
hostname          = "nc"
image_name        = "debian-11"
cpu_arch          = "x86"
instance_type     = "cx11"
instance_location = "fsn1"
storage_size_gb   = 50

# User config
# ----------------------------------------------------------------------------
authorized_hosts = {
  mumen : "ssh-ed25519 AAAA..."
}

deployer_ssh_key = {
  private_base64 = "..."
  public         = "ssh-ed25519 AAAA..."
}

# Backup config
# ----------------------------------------------------------------------------
borg_backup_cifs = {
  path         = "//example.com/aio-backup"
  smb_username = "fred"
  smb_password = "pa55w0rd"
}
```


## Deploy


```shell
$ terraform apply
```

After deployment, the Nextcloud AIO master container will be running but the administration ports will still be firewalled.

When you are ready to configure the new instance, log in to Hetzner cloud and apply the `allow-nextcloud-admin` firewall to the newly created server.

Navigate to `https://nc.example.com:8080` to perform the initial setup.

Navigate to `https://nc.example.com:8443` to automatically provision an SSL certificate.
