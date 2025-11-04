#!/usr/bin/env sh
set -eu

: "${ADMIN:?missing ADMIN}"
: "${ADMIN_PASS:?missing ADMIN_PASS}"

# Create user if absent (use /bin/sh to keep image minimal)
if ! id -u "$ADMIN" >/dev/null 2>&1; then
  useradd -m -s /bin/sh "$ADMIN"
fi
echo "$ADMIN:$ADMIN_PASS" | chpasswd

mkdir -p /var/run/sshd
# Generate host keys if missing
ssh-keygen -A

exec /usr/sbin/sshd -D -e
