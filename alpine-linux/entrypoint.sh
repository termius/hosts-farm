#!/usr/bin/env sh
set -eu

: "${ADMIN:?missing ADMIN}"
: "${ADMIN_PASS:?missing ADMIN_PASS}"

if ! id -u "$ADMIN" >/dev/null 2>&1; then
  useradd -m -s /bin/bash "$ADMIN"
else
  usermod -s /bin/bash "$ADMIN"
fi

# Set password and unlock account
HASH="$(/usr/bin/openssl passwd -6 "$ADMIN_PASS")"
usermod -p "$HASH" "$ADMIN"
usermod -U "$ADMIN" 2>/dev/null || true

mkdir -p /var/run/sshd
ssh-keygen -A
exec /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
