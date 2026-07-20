#!/bin/sh
# Ran as part of alpine-make-rootfs, chrooted as the bootstrap thats being built
set -eu

export PATH='/sbin:/usr/sbin:/bin:/usr/bin'
export SHELL='/bin/sh'

# include resolv.conf
echo "nameserver 8.8.8.8 \n \
nameserver 8.8.4.4" >/etc/resolv.conf

# create a default non-root user account, for optional non-root usage
adduser -D -g "alpine" alpine
