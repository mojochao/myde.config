# Nushell config — interactive shell behavior, aliases, completions.
# PATH and external tool init live in env.nu / vendor autoload.

# --- Shell behavior ------------------------------------------------------

$env.config = {
    show_banner: false
    edit_mode: emacs
    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: false
    }
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
        external: {
            enable: true
            max_results: 100
            # carapace provides multi-shell completions; if not installed,
            # nushell falls back to its built-in completer.
            completer: (
                if (which carapace | is-not-empty) {
                    {|spans|
                        carapace $spans.0 nushell ...$spans
                        | from json
                    }
                } else { null }
            )
        }
    }
    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }
}

# --- Aliases (mirrors fish config) --------------------------------------

# Editor
alias e = emacsclient
alias et = emacsclient -nw
alias eg = emacsclient -cq

# Git
alias g = git

# View / list
alias v = bat -p
alias l = ls
alias la = ls -a
alias ll = ls -l
alias lla = ls -la

# Tree
alias t = tree
alias ta = tree -a
alias td = tree -L
alias tad = tree -a -L

# Open with OS handler
def o [...args] {
    if (sys host | get name) == "Darwin" {
        ^open ...$args
    } else {
        ^xdg-open ...$args
    }
}

# Mise
alias mr = mise run

# Repos CLI
alias repos = repos-cli

# Bookmarks (if you port bookmarks.fish, otherwise plain dirs)
# alias bml = bf list

# npx / uvx tool shortcuts
alias mmdc = npx @mermaid-js/mermaid-cli
alias paperclipai = npx paperclipai
alias codeburn = npx codeburn
alias skilz = uvx skilz
alias smolvm = uvx smolvm

# --- Local overrides -----------------------------------------------------

# Drop a `local.nu` into the vendor autoload dir to extend this config:
#   ~/Library/Application Support/nushell/vendor/autoload/local.nu  (macOS)
#   ~/.config/nushell/vendor/autoload/local.nu                      (Linux)
# Nushell auto-sources any .nu file there at startup.
