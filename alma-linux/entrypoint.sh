#!/usr/bin/env sh
set -eu

: "${ADMIN:?missing ADMIN}"
: "${ADMIN_PASS:?missing ADMIN_PASS}"

if ! id -u "$ADMIN" >/dev/null 2>&1; then
  useradd -m -s /bin/bash "$ADMIN"
else
  usermod -s /bin/bash "$ADMIN"
fi

# Deterministically set a strong hash (SHA-512)
HASH="$(/usr/bin/openssl passwd -6 "$ADMIN_PASS")"
usermod -p "$HASH" "$ADMIN"
passwd -u "$ADMIN" >/dev/null 2>&1 || true  # ensure not locked

mkdir -p /var/run/sshd
ssh-keygen -A

groupadd -f remote
usermod -aG remote "$ADMIN"

exec /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
