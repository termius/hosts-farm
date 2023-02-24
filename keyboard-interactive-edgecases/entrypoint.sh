#!/bin/bash
# Copyright (c) 2020 Termius Corporation.

create_user() {
    groupadd remote
    useradd -s /bin/bash -d /home/$1 -G remote -m $1

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$1/powerlevel10k
    echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>/home/$1/.zshrc
    echo "source /tmp/zshrc" >>/home/$1/.zshrc
}

add_credential() {
    mkdir -p /home/$1/.ssh/
    echo "$ADMIN:$ADMIN_PASS" | chpasswd

    (cd /tmp && cat $PUB_KEY_NAME > /home/$1/.ssh/authorized_keys)
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
    chown -R $1:remote /home/$1/.ssh/
}

envsubst < /tmp/sshd_config > "/etc/ssh/sshd_config"
mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS

touch /var/log/auth.log
chmod 666 /var/log/auth.log
syslog-ng -F &

echo 'Start daemon'
/usr/sbin/sshd -D
