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

# proot has no mount namespaces, so /proc/mounts (bound in wholesale) still lists every
# mountpoint from the host Android system, but only the explicitly bound ones actually
# exist inside the sandbox - df tries to stat all of them and fails noisily on the rest.
# This wrapper hides that noise without touching df's real output.
DF_WRAPPER='df() { command df "$@" 2>&1 | grep -vE '"'"'No such file or directory|Permission denied'"'"'; }'
echo "$DF_WRAPPER" >>/root/.bashrc
echo "$DF_WRAPPER" >>/home/alpine/.bashrc
