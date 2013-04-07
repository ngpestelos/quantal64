#!/bin/sh
 
apt-get -y update
apt-get -y upgrade

apt-get -y install linux-headers-$(uname -r) 
apt-get -y install build-essential
apt-get -y install zlib1g-dev
apt-get -y install libssl-dev
apt-get -y install libreadline-gplv2-dev
apt-get -y install libyaml-dev
apt-get -y install libcurl4-openssl-dev
apt-get -y install libpcre3-dev
apt-get -y install libsqlite3-dev
apt-get -y install libv8-dev
apt-get -y install libpq-dev
apt-get -y install libxslt-dev
apt-get -y install vim
apt-get -y install tmux
apt-get -y install git-core
apt-get -y install curl
apt-get -y install unzip
apt-get -y install autoconf
apt-get -y install ack
apt-get -y install nfs-common

apt-get clean
