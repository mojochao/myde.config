# Nushell environment — runs before config.nu.
# Sets up PATH and generates vendor autoload files for external tool init.

# Squelch startup banner (must be set in env.nu — banner displays before config.nu loads)
$env.config = { show_banner: false }

# --- PATH ----------------------------------------------------------------

def --env add-path [dir: string] {
    let p = ($dir | path expand)
    if ($p | path exists) and ($p not-in $env.PATH) {
        $env.PATH = ($env.PATH | prepend $p)
    }
}

let brew_bin = if (sys host | get name) == "Darwin" {
    "/opt/homebrew/bin"
} else {
    "/opt/linuxbrew/bin"
}

add-path $brew_bin
add-path "~/bin"
add-path "~/go/bin"
add-path "~/.cargo/bin"
add-path "~/.krew/bin"
add-path "~/.local/share/JetBrains/Toolbox/scripts"
add-path "~/.local/bin"

# brew-installed ruby + gem user dir
if (which brew | is-not-empty) {
    add-path $"(brew --prefix ruby | str trim)/bin"
}
if (which ruby | is-not-empty) {
    add-path $"(ruby -e 'puts Gem.user_dir' | str trim)/bin"
}

# .NET binaries + tools (needs brew)
if (which brew | is-not-empty) {
    let dotnet = $"(brew --prefix | str trim)/opt/dotnet"
    if (($dotnet | path join "bin") | path exists) {
        add-path ($dotnet | path join "bin")
        $env.DOTNET_ROOT = ($dotnet | path join "libexec")
    }
}
add-path "~/.dotnet/tools"

# LFE (Lisp Flavoured Erlang)
add-path "/opt/lfe/bin"

# Bun
$env.BUN_INSTALL = ($env.HOME | path join ".bun")
add-path ($env.BUN_INSTALL | path join "bin")

# --- Environment ---------------------------------------------------------

# XDG base dirs — Nushell on macOS only reads ~/.config/nushell when this is set.
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")

$env.EDITOR = "emacsclient -cq -nw"
$env.VISUAL = "emacsclient -cq"

# --- Vendor autoload generation -----------------------------------------

# Nushell auto-sources every .nu file under this directory at startup, so we
# generate init scripts for external tools here instead of `source`-ing them
# from config.nu (which can't source dynamic content at parse time).

let autoload = ($nu.data-dir | path join "vendor/autoload")
mkdir $autoload

if (which starship | is-not-empty) {
    let f = ($autoload | path join "starship.nu")
    if not ($f | path exists) {
        starship init nu | save -f $f
    }
}

if (which zoxide | is-not-empty) {
    let f = ($autoload | path join "zoxide.nu")
    if not ($f | path exists) {
        zoxide init nushell | save -f $f
    }
}

if (which mise | is-not-empty) {
    let f = ($autoload | path join "mise.nu")
    if not ($f | path exists) {
        mise activate nu | save -f $f
    }
}

if (which carapace | is-not-empty) {
    let f = ($autoload | path join "carapace.nu")
    if not ($f | path exists) {
        carapace _carapace nushell | save -f $f
    }
}

if (which atuin | is-not-empty) {
    let f = ($autoload | path join "atuin.nu")
    if not ($f | path exists) {
        atuin init nu | save -f $f
    }
}

if (which fnox | is-not-empty) {
    let f = ($autoload | path join "fnox.nu")
    if not ($f | path exists) {
        fnox activate nu | save -f $f
    }
}

if (which gk | is-not-empty) {
    let f = ($autoload | path join "gk.nu")
    if not ($f | path exists) {
        gk completion nushell | save -f $f
    }
}
