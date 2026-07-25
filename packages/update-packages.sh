#!/usr/bin/env bash
set -euo pipefail

# Regenerate the package lists from the currently installed packages so the
# dotfiles reflect this machine's current state.

DIR="$(dirname "$0")"

# Native (repo) packages explicitly installed.
pacman -Qqen > "$DIR/pkglist.txt"

# Foreign (AUR) packages explicitly installed, excluding -debug packages.
pacman -Qqem | grep -v -- '-debug$' > "$DIR/pkglist-aur.txt"

echo "Updated:"
echo "  pkglist.txt     ($(wc -l < "$DIR/pkglist.txt") native packages)"
echo "  pkglist-aur.txt ($(wc -l < "$DIR/pkglist-aur.txt") AUR packages)"
