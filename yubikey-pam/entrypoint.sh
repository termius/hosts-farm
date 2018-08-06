#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

mkdir /var/run/sshd

create_user $ADMIN

echo 'Start deamon'
/usr/sbin/sshd -D
