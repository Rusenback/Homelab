
output "jellyfin_ip" {
  description = "Jellyfin LXC-kontin IP-osoite"
  value       = "192.168.1.71"
}

output "jellyfin_vm_id" {
  description = "Jellyfin LXC-kontin VM ID"
  value       = proxmox_virtual_environment_container.jellyfin.vm_id
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl", {
    jellyfin_ip    = "192.168.1.71"
    jellyfin_vm_id = proxmox_virtual_environment_container.jellyfin.vm_id
    proxmox_ip     = "192.168.1.50"
  })
  filename = "${path.module}/../ansible/inventory.ini"
}