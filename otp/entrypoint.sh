#!/bin/bash

create_user() {
    groupadd remote
    useradd -s /bin/bash -d /home/$1 -G remote -m $1

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$1/powerlevel10k
    echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>/home/$1/.zshrc
    echo "source /tmp/zshrc" >>/home/$1/.zshrc
}

add_credential() {
    mv /tmp/otpw /home/$1/.otpw
    chown $1: /home/$1/.otpw
    chmod 600 /home/$1/.otpw
}

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS

touch /var/log/auth.log
chmod 666 /var/log/auth.log

echo 'Start daemon'
/usr/sbin/sshd -D
