#!/bin/bash

mkdir -p /home/vagrant/rpmbuild/SPECS /home/vagrant/rpmbuild/SOURCES
cp /vagrant/slurm.spec /home/vagrant/rpmbuild/SPECS
curl -L https://github.com/SchedMD/slurm/archive/slurm-14-11-11-1.tar.gz > /home/vagrant/rpmbuild/SOURCES/slurm-14-11-11-1.tar.gz
cd /home/vagrant/rpmbuild && rpmbuild -bb SPECS/slurm.spec && mkdir -p /vagrant/RPMS && cp /home/vagrant/rpmbuild/RPMS/x86_64/* /vagrant/RPMS



