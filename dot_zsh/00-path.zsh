# Additional PATH entries (Homebrew + user bins set in .zshenv already).

typeset -U path

# Language toolchain shims (mise manages most languages — see 50-tools.zsh)
[ -d "$HOME/.cargo/bin" ] && path=("$HOME/.cargo/bin" $path)

# pnpm
if [ -d "$HOME/Library/pnpm" ]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  path=("$PNPM_HOME" $path)
fi

# Bun
if [ -d "$HOME/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  path=("$BUN_INSTALL/bin" $path)
fi

export PATH
