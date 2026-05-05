# dot-files

Personal dotfiles. Bootstraps a fresh Mac or Debian/Ubuntu box end-to-end.

## One-liner

On any new machine:

```sh
sh -c "$(curl -fsLS https://raw.githubusercontent.com/nathanscott/dot-files/master/install.sh)"
```

Or, equivalently, the [chezmoi](https://chezmoi.io) one-liner:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply nathanscott/dot-files
```

Both install chezmoi (to `~/.local/bin`), clone this repo to `~/.local/share/chezmoi`, prompt for a few values (email, work-vs-personal, etc.), and apply everything.

## What you get

- **Zsh** with [Antidote](https://getantidote.github.io) for plugins, [Starship](https://starship.rs) for the prompt
- **Modern CLI**: [eza](https://github.com/eza-community/eza), [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [zoxide](https://github.com/ajeetdsouza/zoxide), [atuin](https://atuin.sh), [git-delta](https://github.com/dandavison/delta), [fzf](https://github.com/junegunn/fzf)
- **[mise](https://mise.jdx.dev)** for polyglot version management (Ruby, Node, Python, Go, …)
- **Git** with delta, sane defaults, and the muscle-memory alias layer (`g`, `gl`, `gd`, …)
- **macOS** Brewfile of dev tools + GUI apps + curated `defaults` script
- **LazyVim** starter at `~/.config/nvim` for sensible Neovim
- **1Password CLI** integration for secrets — nothing sensitive in this repo

## Layout

```
~/.dotfiles/                      # source of truth (chezmoi sourceDir)
├── install.sh                    # readable curl|sh wrapper
├── .chezmoi.toml.tmpl            # first-run prompts
├── .chezmoiignore                # per-OS file filtering
├── .chezmoiexternal.toml         # LazyVim starter as a managed external
├── .chezmoiscripts/              # idempotent install side effects
├── dot_zshenv                    # always-sourced PATH/EDITOR
├── dot_zshrc.tmpl                # interactive shell loader
├── dot_zsh/                      # 00–99 numbered fragments
├── dot_zsh_plugins.txt           # antidote bundle list
├── dot_config/                   # ~/.config/* (starship, git, mise, bat, ghostty)
├── Brewfile.tmpl                 # macOS package list (templated)
└── README.md
```

## Per-machine differentiation

`.chezmoi.toml.tmpl` prompts on first install:

- **email** — git identity
- **isWork** — work machine flag (drives signing key, alt email by directory, etc.)
- **installCasks** — install GUI apps? (default yes on Mac, no on servers)
- **useOnePassword** — pull secrets from 1Password CLI at apply time?

Re-edit answers any time:

```sh
chezmoi edit-config
chezmoi apply
```

## Day-to-day

| Command | Effect |
|---|---|
| `chezmoi apply` | Re-render and apply (run after editing source files) |
| `chezmoi cd` | cd into the source dir for editing/git |
| `chezmoi edit ~/.zshrc` | Edit the source of `~/.zshrc` (auto-applies on save) |
| `chezmoi update` | Pull from origin + apply |
| `chezmoi diff` | Preview what `apply` would do |
| `chezmoi managed` | List every file chezmoi controls |

## Aliases preserved (muscle memory)

```
g     git status -sb
ga    git add
gd    git diff --word-diff
gl    git log --graph (pretty)
gr    git remote -v
gmd   git merge --no-ff --no-edit develop
p     ping 8.8.8.8 with timestamps
o     open
s, c  code (VS Code)
t     tail -f
cds   cd + ll (function)
```

Plus the modern overlays: `ll` → eza, `cat` → bat, `z foo` → zoxide jump.

## Secrets

`~/.zsh/99-local.zsh` is rendered by chezmoi from a `.tmpl` and can pull values from 1Password:

```
export ANTHROPIC_API_KEY="{{ onepasswordRead "op://Personal/Anthropic/credential" }}"
```

That file is never committed to this repo. Re-render after rotating a secret with `chezmoi apply`.

For un-templated per-machine overrides (work paths, host-specific aliases), edit `~/.zshrc.local` — it's gitignored and sourced last.
