#!/bin/bash

groupadd remote
useradd -s /bin/bash -d /home/$ADMIN -G remote -m $ADMIN
echo "$ADMIN:$ADMIN_PASS" | chpasswd

service xinetd start
tail -f /dev/null