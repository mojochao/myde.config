# Sourced for login shells. PATH setup lives here so GUI apps pick it up on macOS.

# Deduplicate $path entries.
typeset -U path

# Homebrew
case $(uname) in
    Darwin) _brew_prefix=/opt/homebrew ;;
    Linux)  _brew_prefix=/home/linuxbrew/.linuxbrew ;;
esac
[[ -d $_brew_prefix/bin ]] && path=($_brew_prefix/bin $path)
unset _brew_prefix

# User binaries
[[ -d $HOME/bin ]] && path=($HOME/bin $path)

# Go binaries installed with `go install`
[[ -d $HOME/go/bin ]] && path=($HOME/go/bin $path)

# Krew kubectl plugin binaries
[[ -d $HOME/.krew/bin ]] && path=($HOME/.krew/bin $path)

# JetBrains Toolbox scripts
[[ -d $HOME/.local/share/JetBrains/Toolbox/scripts ]] && \
    path=($HOME/.local/share/JetBrains/Toolbox/scripts $path)

# Brew-installed Ruby binaries (needs brew in PATH first)
if command -v brew &>/dev/null; then
    _ruby_bin=$(brew --prefix ruby 2>/dev/null)/bin
    [[ -d $_ruby_bin ]] && path=($_ruby_bin $path)
    unset _ruby_bin
fi

# Gem user binaries
if command -v ruby &>/dev/null; then
    _gem_bin=$(ruby -e 'puts Gem.user_dir' 2>/dev/null)/bin
    [[ -d $_gem_bin ]] && path=($_gem_bin $path)
    unset _gem_bin
fi
