#!/usr/bin/env bash

# XDG base dirs — Nushell on macOS only reads ~/.config/nushell when this is set.
export XDG_CONFIG_HOME="$HOME/.config"

[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

case "$(uname)" in
    Linux)  [[ -d /opt/linuxbrew/bin ]] && PATH="/opt/linuxbrew/bin:$PATH" ;;
    Darwin) [[ -d /opt/homebrew/bin ]]  && PATH="/opt/homebrew/bin:$PATH" ;;
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

# .NET binaries (needs brew in PATH first)
if command -v brew &>/dev/null; then
    _dotnet="$(brew --prefix)/opt/dotnet"
    if [[ -d "$_dotnet/bin" ]]; then
        PATH="$_dotnet/bin:$PATH"
        export DOTNET_ROOT="$_dotnet/libexec"
    fi
    unset _dotnet
fi
[[ -d "$HOME/.dotnet/tools" ]] && PATH="$HOME/.dotnet/tools:$PATH"

# LFE (Lisp Flavoured Erlang)
[[ -d /opt/lfe/bin ]] && PATH="/opt/lfe/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && PATH="$BUN_INSTALL/bin:$PATH"

# Deduplicate PATH, keeping first occurrence (bash has no `typeset -U`).
# ponytail: assumes no glob chars in PATH entries (true for these dotfiles).
_dedup_path() {
    local dir out= IFS=:
    for dir in $PATH; do
        [[ -z $dir || :$out: == *:$dir:* ]] && continue
        out=${out:+$out:}$dir
    done
    PATH=$out
}
_dedup_path
unset -f _dedup_path

export PATH

# Silence macOS "default shell is now zsh" banner
export BASH_SILENCE_DEPRECATION_WARNING=1

# Interactive-only from here
[[ $- == *i* ]] || return

# Editor
export EDITOR='emacsclient -cq -nw'
export VISUAL='emacsclient -cq'

# Shared aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Shell options
shopt -s histappend checkwinsize nocaseglob
# globstar requires bash 4+ (macOS ships 3.2)
((BASH_VERSINFO[0] >= 4)) && shopt -s globstar

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000

# Completions
if [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
elif command -v brew &>/dev/null && [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

# Git completion + wire the `g` alias (Homebrew git ships none; use CLT/OS copy).
for _gc in \
    "$(brew --prefix 2>/dev/null)/etc/bash_completion.d/git-completion.bash" \
    "$(xcode-select -p 2>/dev/null)/usr/share/git-core/git-completion.bash" \
    /usr/share/bash-completion/completions/git \
    /usr/share/git-core/contrib/completion/git-completion.bash; do
    if [[ -r $_gc ]]; then
        source "$_gc"
        declare -F __git_complete &>/dev/null && __git_complete g git
        break
    fi
done
unset _gc

# Mise — activates completions for managed runtimes
command -v mise &>/dev/null && eval "$(mise activate bash)"

# Directory jumping (zoxide)
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"

# Secrets injection (fnox)
if command -v fnox &>/dev/null; then
    eval "$(fnox activate bash)"
    alias fnox_activate='eval "$(fnox activate bash)"'
fi

# Fuzzy finder (fzf)
command -v fzf &>/dev/null && eval "$(fzf --bash)"

# GitKraken CLI completions
command -v gk &>/dev/null && eval "$(gk completion bash 2>/dev/null)"

# Docker completions
command -v docker &>/dev/null && eval "$(docker completion bash)"

# Starship prompt
command -v starship &>/dev/null && eval "$(starship init bash)"

# Shell history (atuin)
command -v atuin &>/dev/null && eval "$(atuin init bash)"

# Local overrides
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"

# Ensure clean exit status so Starship's first prompt isn't red
true
