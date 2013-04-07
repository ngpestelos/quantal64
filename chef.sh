#!/bin/sh
# Based on http://goo.gl/gzilp

RUBY_VERSION="1.9.3-p392"
RUBY=/opt/ruby/bin/ruby
GEM=/opt/ruby/bin/gem
RUBYGEMS_VERSION="1.8.25"

cd /tmp

wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-$RUBY_VERSION.tar.gz
tar xvzf ruby-$RUBY_VERSION
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
