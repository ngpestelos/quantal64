#!/bin/sh

date > /etc/vagrant_box_build_time

dpkg-reconfigure locales
echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale

apt-get -y update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r)
apt-get -y install build-essential
apt-get -y install zlib1g-dev zlib1g
apt-get -y install libssl-dev openssl
apt-get -y install vim
apt-get -y install nfs-common
apt-get -y install dkms
apt-get -y install ack
apt-get -y install libreadline6 libreadline6-dev
apt-get -y install libyaml-dev
apt-get -y install libsqlite3-dev sqlite3
apt-get -y install libxml2-dev libxslt-dev
apt-get -y install autoconf automake
apt-get -y install libc6-dev
apt-get -y install ncurses-dev
apt-get -y install libtool
apt-get -y install bison
apt-get -y install ssl-cert
apt-get -y install pkg-config
apt-get -y install libgdbm-dev
apt-get -y install libffi-dev
apt-get -y install curl libcurl4-openssl-dev
apt-get -y install git-core
apt-get -y install libevent
apt-get -y install ack
apt-get -y install libgeoip-dev
apt-get -y install tmux
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

RUBY_VERSION="1.9.3-p392"
RUBY=/opt/ruby/bin/ruby
GEM=/opt/ruby/bin/gem
RUBYGEMS_VERSION="1.8.25"

wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-$RUBY_VERSION.tar.gz
tar xvzf ruby-$RUBY_VERSION.tar.gz
cd ruby-$RUBY_VERSION
./configure CFLAGS="-O3 -Wall" --prefix=/opt/ruby
make
make install
cd ..
rm -rf ruby-$RUBY_VERSION
rm ruby-$RUBY_VERSION.tar.gz

wget http://production.cf.rubygems.org/rubygems/rubygems-$RUBYGEMS_VERSION.tgz
tar xzf rubygems-$RUBYGEMS_VERSION.tgz
cd rubygems-$RUBYGEMS_VERSION
$RUBY setup.rb
cd ..
rm -rf rubygems-$RUBYGEMS_VERSION
rm rubygems-$RUBYGEMS_VERSION.tgz

$GEM install chef --no-ri --no-rdoc
mkdir -p /etc/chef
echo 'cookbook_path "/kitchen/cookbooks"' > /etc/chef/solo.rb
mv /etc/environment /etc/environment.bak
echo 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/ruby/bin' > /etc/environment

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

echo "cleaning up udev rules"
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces

exit
