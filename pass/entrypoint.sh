#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    mkdir -p /home/$1/.ssh/
    echo "$ADMIN:$ADMIN_PASS" | chpasswd

    if [ -n "${PRIVATE_KEY_NAME}" ]; then
        PUB_KEY="$PRIVATE_KEY_NAME.pub"

        cp /tmp/$PRIVATE_KEY_NAME /home/$1/.ssh/id_rsa
        cp /tmp/$PUB_KEY /home/$1/.ssh/id_rsa.pub

        chmod 400 /home/$1/.ssh/id_rsa
        chown -R $1:remote /home/$1/.ssh/
    fi
}

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS


touch /var/log/auth.log
chmod 666 /var/log/auth.log

echo 'Start daemon'
/usr/sbin/sshd -D
