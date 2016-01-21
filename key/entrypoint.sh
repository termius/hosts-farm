#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    mkdir -p /home/$1/.ssh/
    cat /tmp/id_rsa.pub > /home/$1/.ssh/authorized_keys
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
}

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN

echo 'Start deamon'
/usr/sbin/sshd -D
