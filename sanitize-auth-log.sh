#!/bin/bash
function finish {
  echo 'Stopped watching log' >> /tmp/sanitized-auth.log
}
trap finish EXIT
echo 'Started watching log' >> /tmp/sanitized-auth.log

tail -f /var/log/auth.log |
  grep --line-buffered \
    -e 'authenticated 1 pkalg rsa-sha2' \
    -e 'mm_.*_command' \
    -e 'Setting env' >> /tmp/sanitized-auth.log
