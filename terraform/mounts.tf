resource "null_resource" "jellyfin_mount" {
  depends_on = [proxmox_virtual_environment_container.jellyfin]

  triggers = {
    container_id = proxmox_virtual_environment_container.jellyfin.vm_id
  }

  connection {
    type        = "ssh"
    user        = "root"
    host        = "192.168.1.50"  # Proxmox-hostin IP
    password    = var.proxmox_ssh_password
  }

  provisioner "remote-exec" {
    inline = [
      "pct set ${proxmox_virtual_environment_container.jellyfin.vm_id} -mp0 /Mirrorpool/media,mp=/media",
      "pct exec ${proxmox_virtual_environment_container.jellyfin.vm_id} -- apt-get install -y openssh-server",
      "pct exec ${proxmox_virtual_environment_container.jellyfin.vm_id} -- mkdir -p /root/.ssh",
      "pct exec ${proxmox_virtual_environment_container.jellyfin.vm_id} -- bash -c 'echo \"${var.ansible_ssh_public_key}\" > /root/.ssh/authorized_keys'",
      "pct exec ${proxmox_virtual_environment_container.jellyfin.vm_id} -- chmod 700 /root/.ssh",
      "pct exec ${proxmox_virtual_environment_container.jellyfin.vm_id} -- chmod 600 /root/.ssh/authorized_keys",
      "pct exec ${proxmox_virtual_environment_container.jellyfin.vm_id} -- systemctl disable --now ssh.socket || true",
      "pct exec ${proxmox_virtual_environment_container.jellyfin.vm_id} -- systemctl enable --now ssh"
    ]
  }
}