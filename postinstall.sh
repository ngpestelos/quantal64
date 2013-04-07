#!/bin/sh

date > /etc/vagrant_box_build_time

dpkg-reconfigure locales
echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale

apt-get -y update
apt-get -y upgrade
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

usermod -a -G sudo vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e 's/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

exit
