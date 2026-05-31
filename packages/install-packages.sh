#!/usr/bin/env bash
set -euo pipefail

PKGLIST="$(dirname "$0")/pkglist.txt"

sudo pacman -Syu

xargs sudo pacman -S --needed --noconfirm < "$PKGLIST"
