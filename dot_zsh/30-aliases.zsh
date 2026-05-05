# Aliases.
# Two layers:
#   1. Muscle memory preserved verbatim from the legacy ~/.zshrc
#   2. Modern-tool overlays (eza/bat/fd/rg) — `command <name>` always escapes them

# === Muscle memory ===
alias g='git status -sb'
alias ga='git add'
alias gd='git diff --word-diff'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gr='git remote -v'
alias gmd='git merge --no-ff --no-edit develop'
alias p='ping 8.8.8.8 | perl -nle '\''print scalar(localtime), " ", $_'\'''
alias o='open'
alias s='code'
alias c='code'
alias t='tail -f'

# === Extra git quality-of-life ===
alias gs='git status'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpu='git push -u origin HEAD'
alias gpl='git pull --rebase'
alias gf='git fetch --all --prune'
alias gst='git stash'
alias gstp='git stash pop'
alias gdc='git diff --cached'

# === Modern-tool overlays ===
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza -lh --group-directories-first --git'
  alias la='eza -lah --group-directories-first --git'
  alias lt='eza --tree --level=2'
  alias llt='eza -lh --tree --level=2 --git'
else
  alias ll='ls -lh'
  alias la='ls -lAh'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias catp='bat'
fi

# fd: install ships as `fdfind` on Debian/Ubuntu — alias it back
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

# bat: same Debian quirk
if ! command -v bat >/dev/null 2>&1 && command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
  alias cat='batcat --paging=never'
fi

# === Misc ===
alias df='df -h'
alias du='du -h'
alias less='less -R'
alias mkdir='mkdir -p'
alias reload='exec zsh'
