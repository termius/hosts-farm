#!/bin/bash

mkdir /var/run/sshd

create_user() {
    groupadd remote
    useradd -d "/home/$1" -G remote -m "$1"
}

add_credential() {
    passwd -d $1
    mkdir -p "/home/$1/.ssh/"
    cat /tmp/id_rsa.pub > "/home/$1/.ssh/authorized_keys"
    chmod 700 "/home/$1/.ssh"
    chmod 600 "/home/$1/.ssh/authorized_keys"
    chown -R "$1:remote" "/home/$1/.ssh/"
}


create_user "$ADMIN"
add_credential "$ADMIN"

pkill ssh-agent ; pkill gpg-agent ; \
  eval "$(gpg-agent --daemon --enable-ssh-support --use-standard-socket \
  --log-file ~/.gnupg/gpg-agent.log --write-env-file)"
echo 'Start deamon'
/usr/sbin/sshd -D
