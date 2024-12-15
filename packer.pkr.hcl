packer {
    required_plugins {
      proxmox = {
        version = ">= 1.2.2"
        source  = "github.com/hashicorp/proxmox"
      }
      ansible = {
        version = "~> 1"
        source  = "github.com/hashicorp/ansible"
      }
    }
}


# Common variables
##################
variable "boot_command" {
  type    = list(string)
  default = [""]
}

variable "cd_files" {
  type    = list(string)
  default = [""]
}

variable "cd_label" {
  type    = string
  default = ""
}

variable "extra_args" {
  type    = list(string)
  default = [""]
}

variable "iso_name" {
  type    = string
  default = ""
}

variable "platform" {
  type    = string
  default = ""
}

variable "playbook_file" {
  type    = string
  default = "default-playbook.yml"
}

variable "source_username" {
  type    = string
  default = ""
}

variable "source_password" {
  type    = string
  default = ""
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "ssh_user" {
  type    = string
  default = "root"
}

variable "template_description" {
  type    = string
  default = ""
}

variable "template_name" {
  type    = string
  default = ""
}

# Proxmox variables
###################
variable "proxmox_boot" {
  type    = string
  default = ""
}

variable "proxmox_cpu_type" {
  type    = string
  default = "host"
}

variable "proxmox_disk_size" {
  type    = string
  default = ""
}

variable "proxmox_iso_path" {
  type    = string
  default = ""
}

variable "proxmox_node" {
  type    = string
  default = "proxmox"
}

variable "proxmox_storage_format" {
  type    = string
  default = "raw"
}

variable "proxmox_storage_pool" {
  type    = string
  default = "zfs-storage"
}

variable "proxmox_pre_enrolled_keys" {
  type    = bool
  default = true
}

variable "proxmox_url" {
  type    = string
  default = "https://10.0.10.5:8006/api2/json"
}

variable "proxmox_vm_id" {
  type    = string
  default = ""
}

# vSphere variables
###################
variable "version" {
  type    = string
  default = ""
}


source "proxmox-iso" "proxmox" {
  # Common parameters
  ###################
  boot                 = "${var.proxmox_boot}"
  boot_command         = "${var.boot_command}"
  boot_wait            = "10s"
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "30m"
  ssh_username         = "${var.ssh_user}"
  #Proxmox parameters
  ###################
  additional_iso_files {
    cd_files           = "${var.cd_files}"
    cd_label           = "${var.cd_label}"
    iso_storage_pool   = "local"
    unmount            = true
  }
  bios                 = "ovmf"
  # cloud_init           = true
  # cloud_init_storage_pool = "${var.proxmox_storage_pool}"
  cores                = "2"
  cpu_type             = "${var.proxmox_cpu_type}"
  disks {
    discard            = true
    disk_size          = "${var.proxmox_disk_size}"
    format             = "${var.proxmox_storage_format}"
    io_thread          = true
    ssd                = true
    storage_pool       = "${var.proxmox_storage_pool}"
    type               = "scsi"
  }
  efi_config {
    efi_storage_pool   = "${var.proxmox_storage_pool}"
    efi_type           = "4m"
    pre_enrolled_keys  = "${var.proxmox_pre_enrolled_keys}"
  }
  # http_directory           = "centos9"
  insecure_skip_tls_verify = true
  iso_file                 = "${var.proxmox_iso_path}/${var.iso_name}"
  machine                  = "q35"
  memory                   = "2048"
  network_adapters {
    bridge             = "vmbr1"
    model              = "virtio"
    firewall           = true
  }
  node                 = "${var.proxmox_node}"
  os                   = "l26"
  username             = "${var.source_username}" # also accepts PROXMOX_USERNAME env variable
  password             = "${var.source_password}" # also accepts PROXMOX_PASSWORD env variable
  proxmox_url          = "${var.proxmox_url}"
  qemu_agent           = true
  scsi_controller      = "virtio-scsi-single"
  template_description = "${var.template_description}"
  template_name        = "${var.template_name}"
  unmount_iso          = true
  vm_id                = "${var.proxmox_vm_id}"
}

build {
  sources = ["source.proxmox-iso.proxmox"]

  name = "proxmox-${var.platform}"

  provisioner "ansible" {
    playbook_file      = "ansible/${var.playbook_file}"
    user               = "${var.ssh_user}"
    extra_arguments    = "${var.extra_args}"
  }

}
