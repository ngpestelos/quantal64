#!/bin/sh

# Based on http://goo.gl/gzilp

cd /tmp

# Install Ruby 1.9.3 from source in /opt
$RUBY_VERSION="1.9.3-p392"
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-$RUBY_VERSION.tar.gz
tar xvzf $RUBY_VERSION
cd $RUBY_VERSION
./configure CFLAGS="-O3 -Wall" --prefix=/opt/ruby
make
make install
cd ..
rm -rf $RUBY_VERSION
rm $RUBY_VERSION.tar.gz

RUBY=/opt/ruby/bin/ruby
GEM=/opt/ruby/bin/gem
RUBYGEMS_VERSION="1.8.25"

wget http://production.cf.rubygems.org/rubygems/rubygems-$RUBYGEMS_VERSION.tgz
tar xzf rubygems-$RUBYGEMS_VERSION.tgz
cd rubygems-$RUBYGEMS_VERSION
$RUBY setup.rb
cd ..
rm -rf rubygems-$RUBYGEMS_VERSION
rm rubygems-$RUBYGEMS_VERSION.tgz

# Install chef
$GEM install chef --no-ri --no-rdoc
mkdir -p /etc/chef
