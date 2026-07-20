#!/usr/local/env sh
# Builds a small, general-purpose alpine rootfs.

set -eu

# base alpine packages - apk itself is the main value-add, users can install anything else after boot
readonly ALPINE_PKGS='alpine-keys apk-tools musl-dev curl git linux-headers dropbear p7zip bash unzip'
readonly ALPINE_BRANCH="${ALPINE_VERSION:-3.20}"

case "$ARCH" in
"aarch64")
    ALPINE_ARCH="aarch64";;
"armv7a")
    ALPINE_ARCH="armhf";;
"i686")
    ALPINE_ARCH="x86";;
"x86_64")
    ALPINE_ARCH="x86_64";;
esac

sudo sh scripts/alpine-make-rootfs.sh \
    --arch $ALPINE_ARCH \
    --branch $ALPINE_BRANCH \
    --packages "$ALPINE_PKGS" \
    --script-chroot \
    build/rootfs.tar.xz ./scripts/setup-alpine-rootfs.sh
