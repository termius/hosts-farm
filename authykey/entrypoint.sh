#!/bin/bash


create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    passwd -d $1
    mkdir -p /home/$1/.ssh/
    cat /tmp/id_rsa.pub > /home/$1/.ssh/authorized_keys
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
    chown -R $1:remote /home/$1/.ssh/
}

mkdir /var/run/sshd
echo -e 'zhDa85XgGi61HTOG1zJSZmn0dBZN8q6w\n2\n' | bash authy-ssh install /usr/local/bin

create_user $ADMIN
add_credential $ADMIN

echo 'Start deamon'
/usr/sbin/sshd -D
