#!/bin/bash
set -e

cd /tmp/inetutils-build/telnetd

# Replace send_will, send_do, and send_dont TELOPT_ECHO calls with empty statements
# This prevents the server from sending WILL ECHO, DO ECHO, or DONT ECHO
find . -name "*.c" -type f -exec sed -i \
  's/send_will[[:space:]]*([^,]*TELOPT_ECHO[^)]*);/\/\* send_will TELOPT_ECHO disabled \*\/ ;/g' {} +

find . -name "*.c" -type f -exec sed -i \
  's/send_do[[:space:]]*([^,]*TELOPT_ECHO[^)]*);/\/\* send_do TELOPT_ECHO disabled \*\/ ;/g' {} +

find . -name "*.c" -type f -exec sed -i \
  's/send_dont[[:space:]]*([^,]*TELOPT_ECHO[^)]*);/\/\* send_dont TELOPT_ECHO disabled \*\/ ;/g' {} +

echo "Patched telnetd to disable IAC WILL/DO/DONT ECHO"
