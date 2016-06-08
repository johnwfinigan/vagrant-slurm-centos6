#!/bin/bash
cd /vagrant
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install paramiko PyYAML Jinja2 httplib2 six
