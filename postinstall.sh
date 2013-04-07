#!/bin/sh

date > /etc/vagrant_box_build_time

dpkg-reconfigure locales
echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale

apt-get -y install linux-headers-$(uname -r)
apt-get -y install build-essential
apt-get -y install zlib1g-dev
apt-get -y install libssl-dev
apt-get -y install libreadline-gplv2-dev
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
