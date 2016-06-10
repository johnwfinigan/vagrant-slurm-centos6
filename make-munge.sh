#!/bin/bash

#initial setup
mkdir /vagrant/source
cd /vagrant/source

#get munge

if [ ! -d /vagrant/source/munge ]; then 
    git clone https://github.com/dun/munge
    cd munge
else 
    cd munge
    git pull
fi

#build and install munge

git checkout munge-0.5.12

make clean
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
make
sudo make install
