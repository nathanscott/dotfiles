#!/bin/sh
# install.sh — entrypoint for `curl | sh` bootstrap on a fresh Mac or Debian/Ubuntu box.
#
# Usage:
#   sh -c "$(curl -fsLS https://raw.githubusercontent.com/nathanscott/dot-files/master/install.sh)"
#
# Or, equivalently (chezmoi's blessed one-liner):
#   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply nathanscott
#
# This script just installs chezmoi if missing and runs `chezmoi init --apply` for you.

set -eu

GH_USER="${GH_USER:-nathanscott}"
DOTFILES_REPO="${DOTFILES_REPO:-dot-files}"   # GitHub repo name; chezmoi accepts user OR user/repo

BIN_DIR="${HOME}/.local/bin"
mkdir -p "$BIN_DIR"

# 1. Install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "==> chezmoi not found; installing to ${BIN_DIR}..."
  if command -v brew >/dev/null 2>&1; then
    brew install chezmoi
  else
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
  fi
fi

# Make sure chezmoi is on PATH for this shell
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) export PATH="$BIN_DIR:$PATH" ;;
esac

# 2. Initialise from the dotfiles repo
echo "==> Bootstrapping dotfiles for ${GH_USER}/${DOTFILES_REPO}..."
exec chezmoi init --apply "${GH_USER}/${DOTFILES_REPO}"
