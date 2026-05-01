# Commands to run in all sessions

## Add user-local bin paths

## user binaries
set home_bin_dir $HOME/bin
if test -d $home_bin_dir
    fish_add_path $home_bin_dir
end

## golang binaries installed with `go install`
set go_bin_dir $HOME/go/bin
if test -d $go_bin_dir
    fish_add_path $go_bin_dir
end

## rustlang binaries installed with `cargo install`
set cargo_bin_dir $HOME/.cargo/env.fish
if test -f $cargo_bin_dir
    source $cargo_bin_dir
end

## brew-installed ruby binaries installed with `brew install ruby`
if command -q brew
    set ruby_bin_dir (brew --prefix ruby)/bin
    if test -d $ruby_bin_dir
        fish_add_path $ruby_bin_dir
    end
end

## gem-installed ruby binaries installed with `gem install`
if command -q ruby
    set gem_bin_dir (ruby -e 'puts Gem.user_dir')/bin
    if test -d $gem_bin_dir
        fish_add_path $gem_bin_dir
    end
end

## krew plugin binaries installed with `kubectl krew install`
set krew_bin_dir $HOME/.krew/bin
if test -d $krew_bin_dir
    fish_add_path $krew_bin_dir
end

## jetbrains ides scripts installed by JetBrains Toolbox app
set jetbrains_scripts_dir ~/.local/share/JetBrains/Toolbox/scripts
if test -d $jetbrains_scripts_dir
    fish_add_path $jetbrains_scripts_dir
end

# Commands to run only in interactive sessions
if status is-interactive

    # Squelch initial welcome message.
    set fish_greeting ''

    # Set emacs as my default text editor.
    set -gx EDITOR 'emacsclient -cq -nw' # TUI
    set -gx VISUAL 'emacsclient -cq' # GUI

    alias et $EDITOR # TUI
    alias eg $VISUAL # GUI

    # Use starship for portable shell prompt.
    # docs: https://starship.rs/
    # repo: https://github.com/starship/starship
    if command -q starship
        starship init fish | source
    end

    # Use zoxide for change directory with history.
    # docs: https://zoxide.org/
    # repo: https://github.com/ajeetdsouza/zoxide
    if command -q zoxide
        zoxide init fish | source
    end

    # Use fnox for secrets injection into environment variables.
    # docs: https://fnox.jdx.dev/
    # repo: https://github.com/jdx/fnox
    if command -q fnox
        fnox activate fish | source
        alias fnox_activate 'fnox activate fish | source'
    end

    # Use mise for local development environments.
    # docs://mise.jdx.dev/
    # repo: https://github.com/jdx/mise
    if command -q mise
        mise activate fish | source
        alias mr 'mise run'
    end

    # GitKraken CLI completion
    if command -q gk
        gk completion fish | source
    end

    # Use my repos layout
    # repo: https://github.com/mojochao/repos-cli
    if command -q repos-cli
        alias repos repos-cli
    end

    # Keep git nice and short but still provide completions.
    if command -q git
        alias g git
        complete -c g -w git
    end

    # Bookmark directories with bookmarks.fish plugin.
    # repo: https://github.com/gregorias/bookmarks.fish
    alias bms 'bf save'
    alias bmd 'bf delete'
    alias bmg 'bf go'
    alias bml 'bf list'
    alias bmp 'bf print'

    # List files improved.
    alias l 'ls -1'
    alias la 'ls -1a'
    alias ll 'ls -l'
    alias lla 'ls -la'

    # Edit with emacs.
    alias e emacsclient
    alias et 'emacsclient -nw'

    # Open files with registered desktop app handler for OS.
    switch (uname)
        case Linux
            alias o xdg-open
        case Darwin
            alias o open
    end

    # View with bat.
    # repo: https://github.com/sharkdp/bat
    alias v 'bat -p'

    # When git is just too much to type.
    alias g git

    # Mermaid diagrams CLI
    # docs: https://mermaid.js.org/
    # repo: https://github.com/mermaid-js/mermaid-cli
    alias mmdc 'npx @mermaid-js/mermaid-cli'

    # Manage agent-only, zero-human companies with paperclipai.
    # docs: https://paperclip.ing/
    # repo: https://github.com/paperclipai/paperclip
    alias paperclipai 'npx paperclipai'

    # Monitor agent spend with codeburn.
    # repo: https://github.com/AgentSeal/codeburn
    alias codeburn 'npx codeburn'

    # Manage agent skills with skilz CLI
    # docs: https://skillzwave.ai/
    # repo: https://github.com/SpillwaveSolutions/skilz-cli
    alias skilz 'uvx skilz'

    # Run agents in isolated sandboxes with SmolVM
    # docs: https://mintlify.wiki/CelestoAI/SmolVM/introduction
    # repo: https://github.com/CelestoAI/SmolVM
    alias smolvm 'uvx smolvm'

    # https://github.com/mojochao/repos-cli
    if command -q repos-cli
        alias repos repos-cli
    end

    # NOTE: these are now installed locally

    # # Manage agent skills with skills CLI
    # # docs: https://skills.sh
    # # repo: https://github.com/vercel-labs/skills
    # alias skills 'npx skills'

    # # Local RAG-ish tools

    # # qmd is a local markdown documents search engine.
    # # repo: https://github.com/tobi/qmd
    # alias qmd 'npx @tobilu/qmd'

    # # Stacklit is a code indexer for AI use.
    # # docs: https://www.npmjs.com/package/stacklit
    # # repo: https://github.com/glincker/stacklit
    # alias stacklit 'npx stacklit'

end

#-------------------------------------------------------------------------------
# Local fish config to add if it exists.
#-------------------------------------------------------------------------------

set local_config_fish $HOME/.config/fish/local.config.fish
if test -f $local_config_fish
    source $local_config_fish
end
