lang en_US
keyboard --xlayouts='us'
timezone America/New_York --utc
rootpw $2b$10$x6oAEJWARGocQHSyRjBPeea3F5EHBxazKejSU2ZixWJyJnwKM3uIq --iscrypted

reboot
text
cdrom

ignoredisk --only-use=sda
bootloader --location=boot --append="rhgb quiet crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M"
zerombr
clearpart --all --initlabel
part pv.0 --fstype=lvmpv --ondisk=sda --size=1024 --grow
part /boot --fstype=xfs --ondisk=sda --size=1024
part /boot/efi --fstype=vfat --ondisk=sda --size=1024
volgroup systemvg --pesize=4096 pv.0
logvol / --vgname=systemvg --name=sysroot --fstype=xfs --size=10240
logvol /home --vgname=systemvg --name=home --fstype=xfs --size=4096
logvol /opt --vgname=systemvg --name=opt --fstype=xfs --size=4096
logvol /var --vgname=systemvg --name=var --fstype=xfs --size=10240
logvol /var/log --vgname=systemvg --name=varlog --fstype=xfs --size=5120
logvol /var/log/audit --vgname=systemvg --name=varlogaudit --fstype=xfs --size=4096
logvol /var/tmp --vgname=systemvg --name=vartmp --fstype=xfs --size=4096

auth --passalgo=sha512 --useshadow
network --bootproto=dhcp --ipv6=auto --activate
network  --hostname=localhost.localdomain
skipx
firstboot --disable
selinux --enforcing
services --disabled="kdump" --enabled="sshd,rsyslog,chronyd"
firewall --enabled --ssh

%packages
@^minimal-environment
@standard
cifs-utils
# cloud-init
# cloud-utils-growpart
dnf-utils
nfs-utils
%end

%post
echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/01-permitrootlogin.conf
dnf clean all
%end
