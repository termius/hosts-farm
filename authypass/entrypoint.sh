#!/bin/bash

create_user() {
    useradd -s /bin/bash -d /home/$1 -G remote -m $1

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$1/powerlevel10k
    echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>/home/$1/.zshrc
    echo "source /tmp/zshrc" >>/home/$1/.zshrc
}

add_credential() {
    passwd -d $1

    echo y |authy-ssh enable $1 $2 $3 $4
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

touch /var/log/auth.log
chmod 666 /var/log/auth.log

echo 'Start daemon'
/usr/sbin/sshd -D
