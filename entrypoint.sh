#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    passwd -d $1
    mkdir -p /home/$1/.ssh/
    cat /tmp/$PUB_KEY_NAME > /home/$1/.ssh/authorized_keys
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
    chown -R $1:remote /home/$1/.ssh/
}

envsubst < /tmp/$CONFIG > "/etc/ssh/sshd_config"

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN

echo 'Start deamon'
/usr/sbin/sshd -D
