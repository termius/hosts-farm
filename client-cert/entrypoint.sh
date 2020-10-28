#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    mkdir -p /home/$1/.ssh/
    echo "$ADMIN:$ADMIN_PASS" | chpasswd
}

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS

touch /var/log/auth.log
chmod 666 /var/log/auth.log

echo 'Start daemon'
/usr/sbin/sshd -D
