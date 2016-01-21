#!/bin/bash

mkdir /var/run/sshd
echo 'Start deamon'
/usr/sbin/sshd -D
