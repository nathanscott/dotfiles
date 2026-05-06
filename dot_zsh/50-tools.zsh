# Third-party tool init.
# Most of these touch ZLE (the line editor) — only useful and only valid in interactive shells.

# mise activates everywhere — non-interactive shells need it for `python`/`ruby`/`node`/etc. shims to resolve
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# Everything below is interactive-only
if [[ -o interactive ]]; then

  # Starship prompt
  command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

  # zoxide — `z foo` jumps to recently/frequently used dirs matching `foo`
  command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

  # atuin — fuzzy shell history (Ctrl+R). Up-arrow stays as prefix-search.
  command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh --disable-up-arrow)"

  # fzf — fuzzy finder (Ctrl+T file picker, Alt+C dir picker)
  if command -v fzf >/dev/null 2>&1; then
    [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]   && source /opt/homebrew/opt/fzf/shell/completion.zsh
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ]   && source /usr/share/doc/fzf/examples/completion.zsh

    if command -v fd >/dev/null 2>&1; then
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
  fi

  # GitHub CLI completion
  command -v gh >/dev/null 2>&1 && eval "$(gh completion -s zsh)"

  # qlty completions
  [ -s "/opt/homebrew/share/zsh/site-functions/_qlty" ] && source "/opt/homebrew/share/zsh/site-functions/_qlty"

  # OpenClaw completions
  [ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"
fi
