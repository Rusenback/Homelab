# Proxmox
variable "proxmox_endpoint" {
  description = "Proxmox API endpoint, esim. https://192.168.1.50:8006/"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token muodossa user@pam!tokenid=secret"
  type        = string
  sensitive   = true
}

variable "proxmox_ssh_password" {
  description = "Proxmox root SSH-salasana"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox-noden nimi"
  type        = string
  default     = "teferi"
}

# Verkko
variable "gateway" {
  description = "Verkon oletusgateway"
  type        = string
  default     = "192.168.1.1"
}

variable "debian_lxc_template" {
  description = "Debian LXC-template"
  type        = string
  default     = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
}

variable "debian_template" {
  description = "Debian VM-image"
  type        = string
  default     = "local:iso/debian-12-generic-amd64.img"
}

variable "debian_vm_template_id" {
  description = "Debian 12 cloud-init VM template ID Proxmoxissa"
  type        = number
}

# Salasanat
variable "jellyfin_password" {
  description = "Jellyfin LXC-kontin root-salasana"
  type        = string
  sensitive   = true
}

variable "docker_vm_password" {
  description = "Docker VM:n root-salasana"
  type        = string
  sensitive   = true
}

variable "ansible_ssh_public_key" {
  description = "Ansible SSH julkinen avain"
  type        = string
}