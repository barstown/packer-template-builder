# see */packer.pkr.hcl for a full list of possible variable values to override here
boot_command                = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    # " text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/inst.ks",
    " text inst.ks=cdrom:/inst.ks",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
    ]
cd_files                    = ["./packer/platforms/centos10/inst.ks"]
cd_label                    = "KICKSTART"
extra_args                  = ["--scp-extra-args", "'-O'"]
iso_checksum                = "sha256:b604a26f164f795071d458c5640c39da55dcb92753b3d436a55aee8945a00fb2"
iso_name                    = "CentOS-Stream-10-latest-x86_64-dvd1.iso"
platform                    = "centos10"
playbook_file               = "centos-playbook.yml"
proxmox_boot                = "order=scsi0;ide2;ide0;net0"
# proxmox_cpu_type            = "Skylake-Server-v5"
proxmox_disk_size           = "50G"
proxmox_iso_path            = "truenas_lab:iso"
proxmox_pre_enrolled_keys   = "false"
proxmox_vm_id               = 210
ssh_password                = "packer"
ssh_user                    = "root"
template_description        = "CentOS Stream 10 Template"
template_name               = "CentOS10-Template"
