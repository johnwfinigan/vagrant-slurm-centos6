#!/bin/bash

#initial setup

cd /vagrant/RPMS/overlap
sudo rpm -i slurm*.rpm

if [ hostname = "head" ]; 
then	
	cd /vagrant/RPMS/head
else
	cd /vagrant/RPMS/node
fi

#Install slurm

sudo rpm -i slurm*.rpm

#move config file and slurm setup

ldconfig -n /usr/lib
sudo cp /vagrant/slurm.conf /etc/slurm/slurm.conf

