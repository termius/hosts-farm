#!/bin/bash

create_user() {
    useradd -d /home/$1 -G remote -m $1
}

add_credential() {
    passwd -d $1
    mkdir -p /home/$1/.ssh/
    cat /tmp/id_rsa.pub > /home/$1/.ssh/authorized_keys
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
    chown -R $1:remote /home/$1/.ssh/

    cat > /etc/duo/pam_duo.conf <<EOF
[duo]
ikey = $DUO_INTEGRATION_KEY
skey = $DUO_SECRET_KEY
host = $DUO_API_HOSTNAME
EOF
    cat >/etc/pam.d/sshd <<EOF
#@include common-auth
auth  [success=1 default=ignore] /lib64/security/pam_duo.so
auth  requisite pam_deny.so
auth  required pam_permit.so
EOF
}

mkdir /var/run/sshd
groupadd remote

create_user $ADMIN
add_credential $ADMIN

touch /var/log/auth.log
chmod 666 /var/log/auth.log

/usr/sbin/syslog-ng -F &

echo 'Start daemon'
echo "$@"
exec "$@"
