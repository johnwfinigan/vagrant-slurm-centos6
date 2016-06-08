#!/bin/bash

mkdir ./keys
openssl rand -o ./keys/munge.key 1024
ssh-keygen -t rsa -f ./keys/id_rsa_vagrantslurm
