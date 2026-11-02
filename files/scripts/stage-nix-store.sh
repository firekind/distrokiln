#!/usr/bin/env bash
set -euo pipefail

# Nix needs /nix to be writable, but on an ostree/bootc system everything
# outside /etc and /var is read-only at runtime. So /nix is left as an empty
# mountpoint and an overlay is mounted there at boot (see nix-overlay.service).
#
# Anything the nix RPMs place in /nix during the build is moved to
# /usr/share/nix-store, which ships in the image and becomes the overlay's
# read-only lower layer. /nix is left empty for the mount to land on.

mkdir -p /usr/share/nix-store

if [ -d /nix ]; then
  cp -a /nix/. /usr/share/nix-store/
  find /nix -mindepth 1 -maxdepth 1 -exec rm -rf {} +
fi

mkdir -p /nix
