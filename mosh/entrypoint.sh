#!/bin/bash

create_user() {
    groupadd remote
    useradd -s /bin/bash -d /home/$1 -G remote -m $1
}

add_key() {
    mkdir -p /home/$1/.ssh/
    cat /tmp/$PUB_KEY_NAME > /home/$1/.ssh/authorized_keys
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
    chown -R $1:remote /home/$1/.ssh/

    if [ -n "${PRIVATE_KEY_NAME}" ]; then
        PUB_KEY="$PRIVATE_KEY_NAME.pub"

        cp /tmp/$PRIVATE_KEY_NAME /home/$1/.ssh/id_rsa
        cp /tmp/$PUB_KEY /home/$1/.ssh/id_rsa.pub

        chmod 400 /home/$1/.ssh/id_rsa
        chown -R $1:remote /home/$1/.ssh/
    fi
}

add_pass() {
    mkdir -p /home/$1/.ssh/
    if [ -z "$ADMIN_PASS" ]; then
        passwd -d $1
    else
        echo "$ADMIN:$ADMIN_PASS" | chpasswd
    fi
}

mkdir /var/run/sshd

create_user $ADMIN
add_key $ADMIN
add_pass $ADMIN

touch /var/log/auth.log
chmod 666 /var/log/auth.log

/usr/sbin/syslog-ng -F &
/bin/sanitize-auth-log.sh &

if [ -n "$UNSTABLE_NETWORK" ]; then
    tc qdisc add dev eth0 root netem delay 500ms 500ms drop 10%
fi

echo 'Start sshd'
/usr/sbin/sshd -D
