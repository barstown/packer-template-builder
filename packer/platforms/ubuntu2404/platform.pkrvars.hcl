# see */packer.pkr.hcl for a full list of possible variable values to override here
boot_command                = [
    "<wait5>",
    "e",
    "<wait2><down><wait><down><wait><down><wait><end><wait2>",
    " autoinstall ds="nocloud-net",
    <wait5>",
    "<wait><f10><wait5>",
    ]
cd_files                    = ["./packer/platforms/ubuntu2404/meta-data", "./packer/platforms/ubuntu2404/user-data"]
cd_label                    = "cidata"
extra_args                  = ["--scp-extra-args", "'-O'"]
iso_checksum                = "sha256:d6dab0c3a657988501b4bd76f1297c053df710e06e0c3aece60dead24f270b4d"
iso_name                    = "ubuntu-24.04.2-live-server-amd64.iso"
platform                    = "ubuntu2404"
playbook_file               = "ubuntu-playbook.yml"
proxmox_disk_size           = "50G"
proxmox_iso_path            = "truenas_lab:iso"
proxmox_vm_id               = 204
ssh_password                = "packer"
ssh_user                    = "root"
template_description        = "Ubuntu 24.04 Template"
template_name               = "Ubuntu2404-Template"
