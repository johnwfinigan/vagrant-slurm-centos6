#!/bin/bash

#initial setup
mkdir /vagrant/source
cd /vagrant/source

#get slurm

if [ ! -d /vagrant/source/slurm ]; then 
    git clone https://github.com/SchedMD/slurm
    cd slurm
else 
    cd slurm
    git pull
fi

#build and install slurm

./configure
make
sudo make install
