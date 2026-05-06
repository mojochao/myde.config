# Sourced for interactive shells.
# /etc/zshrc (Apple) already handles: COMBINING_CHARS, key bindings, and
# Terminal.app CWD reporting + session history via /etc/zshrc_Apple_Terminal.

# --- History ------------------------------------------------------------------

HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS     # don't store consecutive duplicate commands
setopt HIST_IGNORE_SPACE    # don't store commands prefixed with a space
setopt HIST_VERIFY          # show expanded history before executing
setopt INC_APPEND_HISTORY   # write to HISTFILE immediately, not at exit

# --- Completions --------------------------------------------------------------

# Brew zsh completions must be on fpath before compinit.
[[ -d /opt/homebrew/share/zsh/site-functions ]] && \
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

autoload -Uz compinit
# Regenerate dump at most once per day.
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' menu select              # arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive

# --- Editor -------------------------------------------------------------------

export EDITOR='emacsclient -cq -nw'
export VISUAL='emacsclient -cq'

# --- Prompt (Starship) --------------------------------------------------------

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# --- Directory jumping (zoxide) -----------------------------------------------

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# --- Secrets injection (fnox) -------------------------------------------------

if command -v fnox &>/dev/null; then
    eval "$(fnox activate zsh)"
    alias fnox_activate='eval "$(fnox activate zsh)"'
fi

# --- Runtime version manager (mise) ------------------------------------------

if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
    alias mr='mise run'
fi

# --- Fuzzy finder (fzf) -------------------------------------------------------

if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi

# --- GitKraken CLI completions ------------------------------------------------

if command -v gk &>/dev/null; then
    source <(gk completion zsh)
fi

# --- Aliases ------------------------------------------------------------------

[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# --- Local overrides ----------------------------------------------------------

[[ -f ${ZDOTDIR:-$HOME}/.config/zsh/local.zshrc ]] && \
    source ${ZDOTDIR:-$HOME}/.config/zsh/local.zshrc
