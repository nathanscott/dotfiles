# Zsh shell options + history + completion.

# --- History ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY        # timestamp every entry
setopt INC_APPEND_HISTORY      # write as you go
setopt SHARE_HISTORY           # share between concurrent shells
setopt HIST_IGNORE_DUPS        # collapse consecutive dupes
setopt HIST_IGNORE_ALL_DUPS    # remove older dupes when adding
setopt HIST_IGNORE_SPACE       # leading space hides from history
setopt HIST_REDUCE_BLANKS      # tidy whitespace
setopt HIST_VERIFY             # show !!-expansion before running

# --- Directory navigation ---
setopt AUTO_CD                 # `dirname` == `cd dirname`
setopt AUTO_PUSHD              # cd pushes to dirstack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# --- Globbing & completion ---
setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt INTERACTIVE_COMMENTS    # allow `# comments` at the prompt

# Don't auto-correct commands; the muscle memory is worth more than the catches
unsetopt CORRECT
unsetopt CORRECT_ALL

# --- Key bindings ---
bindkey -e                                        # emacs-style line editing
bindkey "^[[3~"     delete-char                   # Fn+Delete
bindkey "^[[H"      beginning-of-line             # Home
bindkey "^[[F"      end-of-line                   # End
bindkey "^[[1;5C"   forward-word                  # Ctrl+Right
bindkey "^[[1;5D"   backward-word                 # Ctrl+Left
bindkey "^[[A"      history-search-backward       # Up = prefix-search
bindkey "^[[B"      history-search-forward        # Down = prefix-search

# --- Completion engine ---
autoload -Uz compinit
# Speed up: only re-check security daily
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
