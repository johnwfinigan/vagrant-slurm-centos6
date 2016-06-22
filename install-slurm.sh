#!bin/bash

#install process for the nodes

cd /vagrant/source/slurm
sudo make install

#move config file and slurm setup

idconfig -n /usr/lib
cp /vagrant/slurm.conf /usr/local/etc/slurm.conf
