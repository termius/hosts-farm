#!/bin/bash

create_user() {
    groupadd remote
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    passwd -d $1

    yes|authy-ssh enable $ADMIN $AUTHY_EMAIL $AUTHY_COUNTRY_CODE $AUTHY_PHONE
}

mkdir /var/run/sshd
echo -e "$AUTHY_API_KEY\n2\n" | bash authy-ssh install /usr/local/bin

create_user $ADMIN
add_credential $ADMIN

echo 'Start deamon'
/usr/sbin/sshd -D
