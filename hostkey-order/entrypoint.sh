#!/bin/bash
# Copyright (c) 2020 Termius Corporation.

create_user() {
    groupadd remote
    useradd -s /bin/bash -d /home/$1 -G remote -m $1

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$1/powerlevel10k
    echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>/home/$1/.zshrc
    echo "source /tmp/zshrc" >>/home/$1/.zshrc
    (cat /tmp/bashrc > /home/$1/.bashrc)
}

add_credential() {
    mkdir -p /home/$1/.ssh/
    echo "$ADMIN:$ADMIN_PASS" | chpasswd
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

/usr/sbin/syslog-ng -F &
/bin/sanitize-auth-log.sh &

rm /etc/ssh/ssh_host_*

if [ -n "${HOST_KEY_NAME}" ]; then
  # shellcheck disable=SC2066
  for KEY in ${HOST_KEY_NAME}
  do
    cp "/tmp/${KEY}" /etc/ssh/
  done
fi

echo 'Start daemon'
echo "$@"
exec "$@"
