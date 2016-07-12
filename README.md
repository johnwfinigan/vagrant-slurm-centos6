vagrant-slurm-centos6
=====================

Vagrant box for testing Slurm in Centos 6. Work in progress.

Before first run, run `make-keys.sh` to generate ssh & munge keys

Need to set an environment variable with the name of your CentOS 6 Box - eg: 

`export CENTOS6_BOX=name-of-centos68-base-box`


Upon first `vagrant up`, provisioning will fail because the SLURM 
RPMs have not been built. Let it fail, then:

`vagrant ssh head`


`bash /vagrant/build-slurm.sh`
 
Log out of VM, then `vagrant destroy` and `vagrant up` to use the new RPMs.
