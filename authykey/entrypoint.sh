#!/bin/bash

mkdir /var/run/sshd
bash authy-ssh install /usr/local/bin
echo 'Start deamon'
/usr/sbin/sshd -D
