resource "proxmox_virtual_environment_vm" "docker" {
  description   = "Docker VM - arr-stack ja monitoring"
  node_name     = var.proxmox_node
  vm_id         = 102
  on_boot       = true
  tags          = ["docker", "terraform", "ansible-managed"]

  cpu {
    cores = 4
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
  }

  vga {
    type = "std"
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.72/24"
        gateway = var.gateway
      }
    }

    user_account {
      username = "root"
      password = var.docker_vm_password
      keys     = [var.ansible_ssh_public_key]
    }
  }

  agent {
    enabled = false
    timeout = "1s"
  }

  operating_system {
    type = "l26"
  }

  clone {
    vm_id   = var.debian_vm_template_id
    full    = true
  }

}