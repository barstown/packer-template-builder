# see */packer.pkr.hcl for a full list of possible variable values to override here
boot_command                = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    # " text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/inst.ks",
    " text inst.ks=cdrom:/inst.ks",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
    ]
cd_files                    = ["./packer/platforms/opensusemicroos20241209/combustion", "./packer/platforms/opensusemicroos20241209/ignition"]
cd_label                    = "ignition"
extra_args                  = ["--scp-extra-args", "'-O'"]
iso_name                    = "openSUSE-MicroOS-DVD-x86_64-Snapshot20241209-Media.iso"
platform                    = "opensusemicroos20241209"
playbook_file               = "opensusemicroos-playbook.yml"
proxmox_disk_size           = "100G"
proxmox_iso_path            = "truenas_lab:iso"
proxmox_vm_id               = 205
ssh_password                = "packer"
ssh_user                    = "root"
template_description        = "OpenSUSE-MicroOS Template"
template_name               = "OpenSUSE-MicroOS-Template"
