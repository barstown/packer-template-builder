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
    "mount -t iso9660 /dev/sr0 /mnt/cdrom2",
    "<enter><wait>",
    "<leftAltOn><f1><leftAltOff><wait2>",
    "<enter><wait2>",
    "<enter><wait2>",
    "<enter>",
    ]
cd_files                    = ["./packer/platforms/debian12/preseed.cfg"]
cd_label                    = "cidata"
extra_args                  = ["--scp-extra-args", "'-O'"]
iso_checksum                = "sha256:013f5b44670d81280b5b1bc02455842b250df2f0c6763398feb69af1a805a14f"
iso_name                    = "debian-12.5.0-amd64-netinst.iso"
platform                    = "debian12"
playbook_file               = "debian-playbook.yml"
proxmox_boot                = "order=scsi0;ide2;net0"
proxmox_disk_size           = "50G"
proxmox_iso_path            = "truenas_lab:iso"
proxmox_vm_id               = 203
ssh_password                = "packer"
ssh_user                    = "root"
template_description        = "Debian 12 Template"
template_name               = "Debian12-Template"
