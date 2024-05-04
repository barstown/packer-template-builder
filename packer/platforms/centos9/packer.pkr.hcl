packer {
    required_plugins {
      proxmox = {
        version = ">= 1.1.7"
        source  = "github.com/hashicorp/proxmox"
      }
      ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
      }
    }
  }

  variable "iso_name" {
    type    = string
    default = ""
  }

  variable "iso_path" {
    type    = string
    default = ""
  }

  variable "proxmox_node" {
    type    = string
    default = ""
  }

  variable "source_username" {
    type    = string
    default = ""
  }

  variable "source_password" {
    type    = string
    default = ""
  }

  variable "proxmox_storage_format" {
    type    = string
    default = "raw"
  }

  variable "proxmox_storage_pool" {
    type    = string
    default = "local-lvm"
  }

  variable "proxmox_storage_pool_type" {
    type    = string
    default = "lvm-thin"
  }

  variable "host_url" {
    type    = string
    default = ""
  }

  variable "template_description" {
    type    = string
    default = ""
  }

  variable "template_name" {
    type    = string
    default = ""
  }

  variable "version" {
    type    = string
    default = ""
  }

  source "proxmox-iso" "proxmox-iso" {
    boot_command = [
      "<up>",
      "e",
      "<down><down><end><wait>",
      # " text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/inst.ks",
      " text inst.ks=cdrom:/dev/cdrom/inst.ks",
      "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
      ]
    boot_wait    = "10s"
    bios         = "ovmf"
    cd_files     = ["./inst.ks"]
    cd_label     = "KICKSTART"
    # cloud_init           = true
    # cloud_init_storage_pool = "${var.proxmox_storage_pool}"
    cores        = "2"
    cpu_type     = "host"
    disks {
      discard           = true
      disk_size         = "50G"
      format            = "${var.proxmox_storage_format}"
      io_thread         = true
      ssd               = true
      storage_pool      = "${var.proxmox_storage_pool}"
      type              = "scsi"
    }
    efi_config {
      efi_storage_pool  = "${var.proxmox_storage_pool}"
      efi_type          = "4m"
      pre_enrolled_keys = true
    }
    # http_directory           = "centos9"
    insecure_skip_tls_verify = true
    iso_file                 = "${var.iso_path}/${var.iso_name}"
    machine                  = "q35"
    memory                   = "2048"
    network_adapters {
      bridge            = "vmbr1"
      model             = "virtio"
      firewall          = true
    }
    node                 = "${var.proxmox_node}"
    os                   = "l26"
    username             = "${var.source_username}" # also accepts PROXMOX_USERNAME env variable
    password             = "${var.source_password}" # also accepts PROXMOX_PASSWORD env variable
    proxmox_url          = "${var.host_url}"
    qemu_agent           = true
    scsi_controller      = "virtio-scsi-single"
    ssh_password         = "packer"
    ssh_port             = 22
    ssh_timeout          = "30m"
    ssh_username         = "root"
    template_description = "${var.template_description}"
    template_name        = "${var.template_name}"
    unmount_iso          = true
    vm_id                = 200
  }

  build {
    sources = ["source.proxmox-iso.proxmox-iso"]

    name = "proxmox-centos9"

    provisioner "ansible" {
      playbook_file        = "ansible/rhel-playbook.yml"
      user                 = "root"
      extra_arguments      = [ "--scp-extra-args", "'-O'" ]
    }

  }
