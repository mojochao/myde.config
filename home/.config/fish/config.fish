#-------------------------------------------------------------------------------
# Commands to run in all sessions
#-------------------------------------------------------------------------------

## Add rust cargo bin path to PATH if it exists.
if test -f $HOME/.cargo/env.fish
  source $HOME/.cargo/env.fish
end

## Add Jetbrains Toolbox tools install location to PATH if it exists.
set jetbrains_scripts_dir ~/.local/share/JetBrains/Toolbox/scripts
if test -d $jetbrains_scripts_dir
  fish_add_path $jetbrains_scripts_dir
end

#-------------------------------------------------------------------------------
# Commands to run only in interactive sessions
#-------------------------------------------------------------------------------

if status is-interactive

  # Squelch initial welcome message.
  set fish_greeting ''

  # Set emacs as my default text editor with wrapper script.
  set -gx EDITOR 'myeditor'
  set -gx VISUAL 'myeditor'

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

  # Bookmark directories with bookmarks.fish plugin.
  # repo: https://github.com/gregorias/bookmarks.fish
  alias bms 'bf save'
  alias bmd 'bf delete'
  alias bmg 'bf go'
  alias bml 'bf list'
  alias bmp 'bf print'

  # List files improved.
  alias l   'ls -1'
  alias la  'ls -1a'
  alias ll  'ls -l'
  alias lla 'ls -la'

  # Edit with emacs.
  alias e   'emacsclient'
  alias et  'emacsclient -nw'

  # Open files with registered desktop app handler for OS.
  switch (uname)
    case Linux
      alias o 'xdg-open'
    case Darwin
      alias o 'open'
  end

  # View with bat.
  # repo: https://github.com/sharkdp/bat
  alias v 'bat -p'

  # When git is just too much to type.
  alias g 'git'

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
    alias repos 'repos-cli'
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
# Local config to add if it exists.
#-------------------------------------------------------------------------------

set local_config $HOME/.config/fish/local.config.fish
if test -f $local_config
  source $local_config
end
