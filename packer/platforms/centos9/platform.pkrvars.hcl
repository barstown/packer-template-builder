# see */packer.pkr.hcl for a full list of possible variable values to override here
boot_command                = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    # " text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/inst.ks",
    " text inst.ks=cdrom:/inst.ks",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
    ]
cd_files                    = ["./packer/platforms/centos9/inst.ks"]
cd_label                    = "KICKSTART"
extra_args                  = ["--scp-extra-args", "'-O'"]
iso_checksum                = "sha256:ec408b66ee81327749a9b0143b3960ac0e4f715a98f6bd3c198ffe56bd8f25d9"
iso_name                    = "CentOS-Stream-9-latest-x86_64-dvd1.iso"
platform                    = "centos9"
playbook_file               = "centos-playbook.yml"
proxmox_disk_size           = "50G"
proxmox_iso_path            = "truenas_lab:iso"
proxmox_vm_id               = 201
ssh_password                = "packer"
ssh_user                    = "root"
template_description        = "CentOS Stream 9 Template"
template_name               = "CentOS9-Template"
