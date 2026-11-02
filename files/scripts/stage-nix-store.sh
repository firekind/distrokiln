#!/usr/bin/env bash
set -euo pipefail

# Nix needs /nix to be writable, but on an ostree/bootc system everything
# outside /etc and /var is read-only at runtime. So /nix is left as an empty
# mountpoint and an overlay is mounted there at boot (see nix.mount):
# /usr/share/nix-store as the read-only lower layer, /var/lib/nix-store as the
# writable upper layer.
#
# The nix RPM installs its store skeleton into /nix during the build. This moves
# that skeleton to /usr/share/nix-store so it becomes the overlay's lower layer,
# and leaves /nix empty for the mount to land on.

mkdir -p /usr/share/nix-store

if [ -d /nix ]; then
  cp -a /nix/. /usr/share/nix-store/
  find /nix -mindepth 1 -maxdepth 1 -exec rm -rf {} +
fi

mkdir -p /nix
