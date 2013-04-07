#!/bin/sh

date > /etc/vagrant_box_build_time

apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev
apt-get -y install vim
apt-get -y install nfs-common
apt-get -y install dkms
apt-get clean

cd /tmp

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm VBoxGuestAdditions_$VBOX_VERSION.iso
rm /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso

exit
