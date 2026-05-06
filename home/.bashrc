#!/usr/bin/env bash

# PATH — mirrors fish config
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

case "$(uname)" in
    Linux)  [[ -d /home/linuxbrew/.linuxbrew/bin ]] && PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" ;;
    Darwin) [[ -d /opt/linuxbrew/bin ]]              && PATH="/opt/linuxbrew/bin:$PATH" ;;
esac

[[ -d "$HOME/go/bin" ]]  && PATH="$HOME/go/bin:$PATH"
[[ -d "$HOME/.krew/bin" ]] && PATH="$HOME/.krew/bin:$PATH"
[[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]] && \
    PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if command -v brew &>/dev/null; then
    _ruby_bin="$(brew --prefix ruby 2>/dev/null)/bin"
    [[ -d "$_ruby_bin" ]] && PATH="$_ruby_bin:$PATH"
    unset _ruby_bin
fi

if command -v ruby &>/dev/null; then
    _gem_bin="$(ruby -e 'puts Gem.user_dir' 2>/dev/null)/bin"
    [[ -d "$_gem_bin" ]] && PATH="$_gem_bin:$PATH"
    unset _gem_bin
fi

export PATH

# Interactive-only from here
[[ $- == *i* ]] || return

# Shared aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Shell options
shopt -s histappend checkwinsize globstar nocaseglob

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000

# Completions
if [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
elif command -v brew &>/dev/null && [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

# Mise — activates completions for managed runtimes
command -v mise &>/dev/null && eval "$(mise activate bash)"

# GitKraken CLI completions
command -v gk &>/dev/null && eval "$(gk completion bash 2>/dev/null)"

# Starship prompt
command -v starship &>/dev/null && eval "$(starship init bash)"

# Local overrides
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
