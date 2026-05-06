# Sourced for all zsh invocations (interactive, login, scripts).
# Keep this minimal — PATH changes here affect scripts and subshells.

# Cargo binaries
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env
