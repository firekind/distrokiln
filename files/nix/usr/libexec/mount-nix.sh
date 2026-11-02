#!/usr/bin/env bash
set -euo pipefail

# Mount the overlay that makes /nix writable: /usr/share/nix-store from the
# image as the read-only lower layer, /var/lib/nix-store as the writable upper
# layer. Creates the upper and work directories, which live in /var and so
# don't exist on a fresh install.
#
# Runs before systemd-tmpfiles-setup so the nix-filesystem package's own
# tmpfiles config creates /nix/store, /nix/var etc. inside the overlay.

mkdir -p /usr/share/nix-store /var/lib/nix-store /var/cache/nix-store /nix

if ! mountpoint -q /nix; then
  mount -t overlay overlay \
    -o lowerdir=/usr/share/nix-store,upperdir=/var/lib/nix-store,workdir=/var/cache/nix-store \
    /nix
fi
