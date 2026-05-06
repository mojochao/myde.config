# Sourced for all zsh invocations (interactive, login, scripts).
# Keep this minimal — PATH changes here affect scripts and subshells.

# XDG base dirs — Nushell on macOS only reads ~/.config/nushell when this is set.
export XDG_CONFIG_HOME="$HOME/.config"

# Cargo binaries
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env
