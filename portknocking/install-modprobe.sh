#!/bin/bash
# run with 
# bash <(curl -s https://gist.githubusercontent.com/iampeterbanjo/f1c9931002f5a939464c172fed6f96cb/raw/520cee811a47714291394dec5fb4352683a17158/install-modprobe-ubuntu-kernel.sh)
set -e


# Determine versions
arch="$(uname -m)"
release="$(uname -r)"
upstream="${release%%-*}"
local="${release#*-}"

# Get kernel sources
mkdir -p /usr/src
wget -q -O "/usr/src/linux-${upstream}.tar.xz" "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${upstream}.tar.xz"
tar xf "/usr/src/linux-${upstream}.tar.xz" -C /usr/src/

mkdir -p /lib/modules/${release}/

ln -fns "/usr/src/linux-${upstream}" /usr/src/linux
ln -fns "/usr/src/linux-${upstream}" "/lib/modules/${release}/build"

# Prepare kernel
zcat /proc/config.gz > /usr/src/linux/.config
printf 'CONFIG_LOCALVERSION="%s"\nCONFIG_CROSS_COMPILE=""\n' "${local:+-$local}" >> /usr/src/linux/.config
wget -q -O /usr/src/linux/Module.symvers "http://mirror.scaleway.com/kernel/${arch}/${release}/Module.symvers"
apt-get install -y libssl-dev # adapt to your package manager
make -C /usr/src/linux prepare modules_prepare

apt-get install -y zfsutils-linux

zcat /proc/config.gz > /boot/config-4.5.7
cd /tmp;  wget -q https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.5.7.tar.xz && tar xf linux-4.5.7.tar.xz
cp -r /tmp/linux-4.5.7 /lib/modules/4.5.7-std-2/build && cd /lib/modules/4.5.7-std-2/build/
cp /boot/config-4.5.7 .config
make oldconfig
make prepare scripts
apt-get remove -y zfsutils-linux
apt-get install -y zfsutils-linux
cd /lib/modules/4.5.7-std-2/build && make -j4
dkms --verbose install spl/0.6.5.6
dkms --verbose install zfs/0.6.5.6
dkms status
spl, 0.6.5.6, 4.5.7-std-2, x86_64: installed
zfs, 0.6.5.6, 4.5.7-std-2, x86_64: installed
modprobe zfs
zpool list