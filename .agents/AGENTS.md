# AGENTS.md

This file provides guidance to AI agents when working with code in this repository.

## What This Repo Is

A personal development environment managed with [GNU stow](https://www.gnu.org/software/stow/) and GNU make. The `home/` directory is a single stow package — its contents are symlinked into `$HOME` when installed.

## Common Commands

```bash
make preview   # Dry-run: show what symlinks would be created (run before link)
make link      # Create symlinks from home/ into $HOME
make unlink    # Remove managed symlinks (repo files untouched)
make adopt     # Copy existing $HOME configs into repo (requires clean git state)
make help      # List all targets
make vars      # Show environment variables
```

Always run `make preview` before `make link` to check for conflicts.

## Repository Structure

- `home/` — the stow package root; mirrors the structure of `$HOME`
  - `.config/fish/` — Fish shell configuration (primary interactive shell)
  - `.config/git/` — Git config with delta pager, custom aliases, rerere, zdiff3
  - `.config/mise/` — Mise version manager config (experimental features enabled)
  - `.config/starship.toml` — Starship prompt (detects Python, Go, Node, Rust, Elixir, Erlang, AWS/GCP/Azure/K8s)
  - `.config/ghostty/` — Ghostty terminal (Source Code Pro font, Catppuccin theme)
  - `.config/gh/` — GitHub CLI config
  - `.config/nushell/` — Nushell (secondary shell)
  - `.config/glow/` — Glow markdown viewer
  - `bin/` — Custom scripts (`myeditor` wraps `emacsclient -c -a emacs`; `gogh` installs terminal color themes)

## Key Tools in This Config

| Tool | Role |
|------|------|
| Fish | Primary interactive shell |
| Mise | Runtime version management |
| Starship | Shell prompt |
| Ghostty | Terminal emulator |
| delta | Git diff pager |
| zoxide | Directory jumping |
| fzf | Fuzzy search (files, history) |
| bat | Syntax-highlighted file viewer |
| fnox | Secrets injection into env vars |

## Notable Git Aliases (defined in `.config/git/`)

- `lg` — graph log with relative dates
- `wip` — all branches with last commit dates
- `cmp` — compare branch commits
- `dw` — word diff
- `clog` — conventional commit log
- `dunk` — diff via dunk (minified file diffing)

## Fish Shell Aliases (defined in `.config/fish/conf.d/`)

- `e` / `et` — emacsclient GUI / terminal
- `g` — git
- `v` — bat
- `l`, `la`, `ll`, `lla` — ls variants
- `bms`, `bmd`, `bmg`, `bml`, `bmp` — bookmarks.fish bookmark management
