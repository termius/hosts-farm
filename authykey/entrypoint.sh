#!/bin/bash

create_user() {
    useradd -s /bin/bash -d /home/$1 -G remote -m $1
}

add_credential() {
    passwd -d $1
    mkdir -p /home/$1/.ssh/
    cat /tmp/id_rsa.pub > /home/$1/.ssh/authorized_keys
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
    chown -R $1:remote /home/$1/.ssh/
    echo y | authy-ssh enable $1 $2 $3 $4
}

mkdir /var/run/sshd
groupadd remote
echo -e "$AUTHY_API_KEY\n2\n" | bash authy-ssh install /usr/local/bin

for admin in $ADMIN_LIST
do
    ADMIN_ITEM=($(echo $admin | tr ":" " "))
    create_user ${ADMIN_ITEM[0]}
    add_credential ${ADMIN_ITEM[*]}
done

create_user $ADMIN
add_credential $ADMIN

touch /var/log/auth.log
chmod 666 /var/log/auth.log

echo 'Start daemon'
/usr/sbin/sshd -D
