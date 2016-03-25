#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    mv /tmp/otpw /home/$1/.otpw
    chown $1: /home/$1/.otpw
    chmod 600 /home/$1/.otpw
}

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS

echo 'Start deamon'
/usr/sbin/sshd -D
