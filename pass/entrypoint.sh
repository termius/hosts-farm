#!/bin/bash

create_user() {
    groupadd remote
    useradd -s /bin/bash -s /bin/bash -d /home/$1 -G remote -m $1

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$1/powerlevel10k
    echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>/home/$1/.zshrc
    echo "source /tmp/zshrc" >>/home/$1/.zshrc
    cp /tmp/bash_history /home/$1/.bash_history
    chown $1:$1 /home/$1/.bash_history
    chmod -w /home/$1/.bash_history
}

add_credential() {
    mkdir -p /home/$1/.ssh/
    echo "$1:$2" | chpasswd
    cp /tmp/bash_logout /home/$1/.bash_logout
    chown -R $1:remote /home/$1/.bash_logout

    if [ -n "${PRIVATE_KEY_NAME}" ]; then
        PUB_KEY="$PRIVATE_KEY_NAME.pub"

        cp /tmp/$PRIVATE_KEY_NAME /home/$1/.ssh/id_rsa
        cp /tmp/$PUB_KEY /home/$1/.ssh/id_rsa.pub

        chmod 400 /home/$1/.ssh/id_rsa
        chown -R $1:remote /home/$1/.ssh/
    fi
}

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
