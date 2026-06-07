terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.73"
    }
        local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure = true

  ssh {
    agent = false
    username = "root"
    password = var.proxmox_ssh_password
  }
}
