resource "null_resource" "jellyfin_mount" {
  depends_on = [proxmox_virtual_environment_container.jellyfin]

  connection {
    type        = "ssh"
    user        = "root"
    host        = "192.168.1.50"  # Proxmox-hostin IP
    password    = var.proxmox_ssh_password
  }

  provisioner "remote-exec" {
    inline = [
      "pct set ${proxmox_virtual_environment_container.jellyfin.vm_id} -mp0 /Mirrorpool/media,mp=/media"
    ]
  }
}