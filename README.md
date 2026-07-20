# alpine4a-bootstrap-builder

This repository contains a set of different scripts and GitHub Action workflow files, that are used to build a general-purpose Alpine Linux rootfs, used by the [alpine4a](https://github.com/feelfreelinux/alpine4a) app. It is a fork of [octo4a-bootstrap-builder](https://github.com/feelfreelinux/octo4a-bootstrap-builder), with the OctoPrint-specific installation steps removed - the rootfs it produces is plain Alpine Linux with `apk` available, nothing else preinstalled.

It also builds proot, and includes it alongside the bootstrap archive. Proot is used to chroot into the rootfs on the Android device.

## Scripts
- `scripts/alpine-make-rootfs.sh` - modified version of [alpine-make-rootfs](https://github.com/alpinelinux/alpine-make-rootfs), used to build a custom version of the alpine-linux bootstrap. The original script was altered to support multiple architectures.
- `scripts/build-octo4a-bootstrap.sh` - Builds the Alpine rootfs itself via `alpine-make-rootfs.sh`, with the base package set and `scripts/setup-alpine-rootfs.sh` as the in-chroot setup script.
- `scripts/setup-alpine-rootfs.sh` - Ran during the bootstrap's build process, chrooted into the rootfs being built - sets up `/etc/resolv.conf` and a default non-root user.
- `scripts/build-talloc.sh` - Statically builds the talloc allocator, using Android NDK. Talloc is a dependency of proot.
- `scripts/build-proot.sh` - Statically builds proot (from external/proot) using Android NDK.
- `scripts/run-bootstrap-android.sh` - Bootstrap's entrypoint script, included as part of the built bootstrap. Executes proot with necessary binds and other parameters.
- `scripts/create-bootstrap.sh` - Top-level orchestrator: builds talloc/proot/minitar, builds the Alpine rootfs, then assembles it all into the final bootstrap zip.
