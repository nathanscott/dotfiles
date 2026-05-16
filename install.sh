#!/bin/sh
# install.sh — entrypoint for `curl | sh` bootstrap on a fresh Mac or Debian/Ubuntu box.
#
# Usage:
#   sh -c "$(curl -fsLS https://raw.githubusercontent.com/nathanscott/dotfiles/master/install.sh)"
#
#   # No admin / sudo available (skip brew, apt, casks — user-local install only):
#   sh -c "$(curl -fsLS https://raw.githubusercontent.com/nathanscott/dotfiles/master/install.sh)" -- --no-admin
#
# Or, equivalently (chezmoi's blessed one-liner):
#   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply nathanscott
#
# This script installs chezmoi if missing and runs `chezmoi init --apply` for you.

set -eu

GH_USER="${GH_USER:-nathanscott}"
DOTFILES_REPO="${DOTFILES_REPO:-dotfiles}"   # GitHub repo name; chezmoi accepts user OR user/repo

NO_ADMIN=0
for arg in "$@"; do
  case "$arg" in
    --no-admin) NO_ADMIN=1 ;;
    -h|--help)
      sed -n '2,12p' "$0"
      exit 0 ;;
    *)
      echo "Unknown argument: $arg" >&2
      exit 2 ;;
  esac
done

if [ "$NO_ADMIN" = "1" ]; then
  export DOTFILES_NO_ADMIN=1
fi

BIN_DIR="${HOME}/.local/bin"
mkdir -p "$BIN_DIR"

# 1. Install chezmoi if missing.
#    No-admin mode always uses the user-local curl installer, even if brew is present —
#    brew install can still call into casks/services that escalate, and the curl installer
#    is the safe, sudo-free path.
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "==> chezmoi not found; installing to ${BIN_DIR}..."
  if [ "$NO_ADMIN" = "1" ] || ! command -v brew >/dev/null 2>&1; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
  else
    brew install chezmoi
  fi
fi

# Make sure chezmoi is on PATH for this shell
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) export PATH="$BIN_DIR:$PATH" ;;
esac

# 2. Initialise from the dotfiles repo
#    DOTFILES_NO_ADMIN=1 makes the noAdmin prompt default to "true" — chezmoi will still prompt
#    interactively but the right default is pre-selected.
echo "==> Bootstrapping dotfiles for ${GH_USER}/${DOTFILES_REPO}..."
exec chezmoi init --apply "${GH_USER}/${DOTFILES_REPO}"
