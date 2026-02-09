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
    "<enter><wait300>",
    "<left><enter>",
    ]
cd_files                    = ["./packer/platforms/debian13/preseed.cfg"]
cd_label                    = "cidata"
extra_args                  = ["--scp-extra-args", "'-O'"]
iso_checksum                = "sha256:7b7837fa2ed64fd45224bff905643bd3ab32157dcc0ab1dc68aad5b9dc2d4d39"
iso_name                    = "debian-13.3.0-amd64-DVD-1.iso"
platform                    = "debian13"
playbook_file               = "debian-playbook.yml"
proxmox_boot                = "order=scsi0;scsi1;scsi2;ide2;ide0;net0"
proxmox_disk_size           = "50G"
proxmox_iso_path            = "truenas_lab:iso"
proxmox_vm_id               = 200
ssh_password                = "packer"
ssh_user                    = "root"
template_description        = "Debian 13 Template"
template_name               = "Debian13-Template"
