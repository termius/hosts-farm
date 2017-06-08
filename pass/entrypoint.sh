#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    echo "$ADMIN:$ADMIN_PASS" | chpasswd
}

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS

echo 'Start deamon'
/usr/sbin/sshd -D
