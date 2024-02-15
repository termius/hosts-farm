#!/bin/bash

create_user() {
    groupadd remote
    useradd -s /bin/bash -d /home/$1 -G remote -m $1

    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$1/powerlevel10k
    # echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>/home/$1/.zshrc
    # echo "source /tmp/zshrc" >>/home/$1/.zshrc
}

add_credential() {
    mv /tmp/google_authenticator /home/$1/.google_authenticator
    chmod 600 /home/$1/.google_authenticator
    chown $1:$1 /home/$1/.google_authenticator
    mkdir -p /home/$1/.ssh/
    (cd /tmp && cat $PUB_KEY_NAME > /home/$1/.ssh/authorized_keys)
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
    chown -R $1:remote /home/$1/.ssh/

    if [[ (-n "$1") || (-n "$2") ]]; then
        echo "$1:$2" | chpasswd
    fi
}

mkdir /var/run/sshd

create_user $ADMIN
add_credential $ADMIN $ADMIN_PASS

touch /var/log/auth.log
chmod 666 /var/log/auth.log
/usr/sbin/syslog-ng -F &

echo 'Start daemon'
/usr/sbin/sshd -D
