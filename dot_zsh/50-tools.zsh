# Third-party tool init.
# Ordered: prompt, jumper, history, version manager, completion glue, fzf.

# Starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# zoxide — `z foo` jumps to recently/frequently used dirs matching `foo`
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# atuin — fuzzy shell history (Ctrl+R). Up-arrow stays as prefix-search.
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# mise — polyglot version manager (replaces rbenv/pyenv/nvm)
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# fzf — fuzzy finder (Ctrl+T file picker, Alt+C dir picker)
if command -v fzf >/dev/null 2>&1; then
  # Homebrew install
  [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]   && source /opt/homebrew/opt/fzf/shell/completion.zsh
  # Linux package install
  [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
  [ -f /usr/share/doc/fzf/examples/completion.zsh ]   && source /usr/share/doc/fzf/examples/completion.zsh

  # Use fd (or rg) as the file source — respects .gitignore
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
fi

# GitHub CLI completion
command -v gh >/dev/null 2>&1 && eval "$(gh completion -s zsh)"

# qlty completions (preserved — you actually use this)
[ -s "/opt/homebrew/share/zsh/site-functions/_qlty" ] && source "/opt/homebrew/share/zsh/site-functions/_qlty"

# OpenClaw completions
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"
