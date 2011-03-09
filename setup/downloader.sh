#!/bin/sh

set -e
set -u


url='http://www.untar.org/files/downloads'

install=$HOME/install

dl=$install/downloads


rm -rf $dl
mkdir -p $dl

cd $dl

rm -rf toolkit.ben.public
wget ${url}/toolkit.ben.public.tar.gz

cd $install
wget ${url}/installer.sh
chmod 0755 installer.sh
