#!/bin/bash


# create keys directory if it doesnt exist
if [ ! -d ./keys ]; then
    mkdir ./keys
fi


# generate munge.key, or skip it if it exists
if [ -a ./keys/munge.key ]; then
    echo "keys/munge.key exists"
    echo "delete keys/munge.key if you want to regenerate it"
else
    openssl rand -out ./keys/munge.key 1024
fi


# generate rsa keys, or skip if they exist
if [ -a ./keys/id_rsa_vagrantslurm ] || [ -a ./keys/id_rsa_vagrantslurm.pub ]; then
    echo "keys/id_rsa_vagrantslurm or keys/id_rsa_vagrantslurm.pub exist"
    echo "delete keys/id_rsa_vagrantslurm and keys/id_rsa_vagrantslurm.pub if you want to regenerate them"
else
    ssh-keygen -t rsa -f ./keys/id_rsa_vagrantslurm
fi
