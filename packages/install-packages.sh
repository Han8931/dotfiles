#!/usr/bin/env bash
set -euo pipefail

DIR="$(dirname "$0")"
PKGLIST="$DIR/pkglist.txt"
AURLIST="$DIR/pkglist-aur.txt"

# Sync and install native (repo) packages.
sudo pacman -Syu --needed --noconfirm - < "$PKGLIST"

# Bootstrap yay if missing, then install AUR packages.
if ! command -v yay >/dev/null 2>&1; then
	echo "yay not found; bootstrapping yay-bin from the AUR..."
	tmp="$(mktemp -d)"
	git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
	(cd "$tmp/yay-bin" && makepkg -si --noconfirm)
	rm -rf "$tmp"
fi

yay -S --needed --noconfirm - < "$AURLIST"
