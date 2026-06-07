resource "proxmox_virtual_environment_container" "jellyfin" {
  vm_id = 101
  description  = "Jellyfin media server"
  node_name    = var.proxmox_node
  start_on_boot = true

  # TODO: muuta false kun NVIDIA Quadro P1000 asennetaan
  unprivileged = true

  tags = ["media", "terraform", "ansible-managed"]

  features {
    nesting = true
  }

  initialization {
    hostname = "jellyfin"

    ip_config {
      ipv4 {
        address = "192.168.1.71/24"
        gateway = var.gateway
      }
    }

    user_account {
      password = var.jellyfin_password
      keys = [var.ansible_ssh_public_key]
    }
  }

  cpu {
    cores = 4
  }

  memory {
    dedicated = 2048
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }

 operating_system {
    template_file_id = var.debian_lxc_template
    type = "debian"
  }
}