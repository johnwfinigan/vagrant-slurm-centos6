#!/bin/bash

#initial setup

if [ hostname = "head" ]; 
then	
	cd /vagrant/RPMS/x86_64/head
else
	cd /vagrant/RPMS/x86_64/node
fi

#Install slurm

sudo rpm -i slurm*.rpm

#move config file and slurm setup

ldconfig -n /usr/lib
sudo cp /vagrant/slurm.conf /etc/slurm/slurm.conf

#start the daemons
if [ hostname = "head"];
then
	sudo /# /etc/rc.d/init.d/slurmctld start
else
	sudo /# /etc/rc.d/init.d/slurmd start
fi
