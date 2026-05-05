# Shell functions.

# `cds` — cd then list (preserved from legacy ~/.zshrc)
cds() {
  builtin cd "$@" && ll
}

# `mkcd` — mkdir + cd in one
mkcd() {
  mkdir -p "$1" && builtin cd "$1"
}

# `g.` — open the current dir in $EDITOR
g.() {
  ${EDITOR:-vi} .
}

# `extract` — universal archive extractor
extract() {
  if [ -z "$1" ]; then
    echo "usage: extract <archive>"
    return 1
  fi
  if [ ! -f "$1" ]; then
    echo "extract: '$1' is not a file"
    return 1
  fi
  case "$1" in
    *.tar.bz2|*.tbz2) tar xjf  "$1" ;;
    *.tar.gz|*.tgz)   tar xzf  "$1" ;;
    *.tar.xz)         tar xJf  "$1" ;;
    *.tar)            tar xf   "$1" ;;
    *.bz2)            bunzip2  "$1" ;;
    *.gz)             gunzip   "$1" ;;
    *.zip)            unzip    "$1" ;;
    *.7z)             7z x     "$1" ;;
    *.rar)            unrar x  "$1" ;;
    *) echo "extract: don't know how to handle '$1'"; return 1 ;;
  esac
}

# `ip` — public IP (silent, no curl spinner)
myip() {
  curl -s https://ifconfig.me && echo
}

# `serve` — quick HTTP server in cwd
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}
