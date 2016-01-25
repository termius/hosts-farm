#!/bin/bash

for admin in $ADMIN_LIST
do
    ADMIN_ITEM=($(echo $admin | tr ":" " "));
    echo "Set pass for ${ADMIN_ITEM[0]}"
    passwd ${ADMIN_ITEM[0]};
done
