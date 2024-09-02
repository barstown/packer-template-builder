# see */packer.pkr.hcl for a full list of possible variable values to override here
boot_command                = [
    "<wait5>",
    "<down>",
    "e",
    "<wait2><down><wait><down><wait><down><wait><end><wait2>",
    " preseed/file=/mnt/cdrom2/preseed.cfg<wait5>",
    "<leftCtrlOn><wait>x<wait><leftCtrlOff><wait10>",
    "<leftAltOn><wait><f2><wait><leftAltOff><wait2>",
    "<enter><wait>",
    "mkdir -p /mnt/cdrom2",
    "<enter><wait>",
    "mount -t iso9660 /dev/sr1 /mnt/cdrom2",
    "<enter><wait>",
    "<leftAltOn><f1><leftAltOff><wait2>",
    "<enter><wait2>",
    "<enter><wait2>",
    "<enter>",
    ]
cd_files                    = ["./packer/platforms/ubuntu2404/preseed.cfg"]
cd_label                    = "cidata"
extra_args                  = ["--scp-extra-args", "'-O'"]
iso_name                    = "ubuntu-24.04.1-live-server-amd64.iso"
platform                    = "ubuntu2404"
playbook_file               = "ubuntu-playbook.yml"
proxmox_disk_size           = "50G"
proxmox_iso_path            = "truenas_lab:iso"
proxmox_vm_id               = 202
ssh_password                = "packer"
ssh_user                    = "root"
template_description        = "Ubuntu 24.04 Template"
template_name               = "Ubuntu2404-Template"
