#!/bin/bash

#initial setup
mkdir /vagrant/source
cd /vagrant/source

#get munge

if [ ! -d /vagrant/source/slurm ]; then 
    git clone https://github.com/dun/munge
    cd munge
else 
    cd munge
    git pull
fi

#build and install munge

./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
make
sudo make install
