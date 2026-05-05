# Antidote plugin loading.
# Plugin list lives in ~/.zsh_plugins.txt — antidote bundles + caches into a single static file.

# Find antidote (Homebrew on Mac, ~/.antidote on Linux from the install script)
if [ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
elif [ -f /usr/local/opt/antidote/share/antidote/antidote.zsh ]; then
  source /usr/local/opt/antidote/share/antidote/antidote.zsh
elif [ -f "$HOME/.antidote/antidote.zsh" ]; then
  source "$HOME/.antidote/antidote.zsh"
elif [ -f /usr/share/zsh-antidote/antidote.zsh ]; then
  source /usr/share/zsh-antidote/antidote.zsh
fi

if typeset -f antidote >/dev/null && [ -f "$HOME/.zsh_plugins.txt" ]; then
  antidote load
fi
