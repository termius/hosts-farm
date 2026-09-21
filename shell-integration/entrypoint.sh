#!/bin/bash

create_user() {
    groupadd remote
    useradd -s /bin/bash -d /home/$1 -G remote -m $1
}

add_credential() {
    echo "$1:$2" | chpasswd
}

[ -n "${CONFIG:-}" ] && [ -r "/tmp/$CONFIG" ] || { echo "FATAL: CONFIG unset or /tmp/$CONFIG missing" >&2; exit 1; }
envsubst < /tmp/$CONFIG > "/etc/ssh/sshd_config"

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS

touch /var/log/auth.log
chmod 666 /var/log/auth.log

rm /etc/ssh/ssh_host_*_key
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

echo 'Start daemon'
exec /usr/sbin/sshd -D
