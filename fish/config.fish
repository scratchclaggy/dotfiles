set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share

set -gx EDITOR nvim
set -gx PAGER "bat -p"

set -gx BAT_CONFIG_PATH $XDG_CONFIG_HOME/bat/batrc
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx GOPATH $XDG_DATA_HOME/go
set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc
set -gx PYENV_ROOT $HOME/.pyenv
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/config.toml
set -gx VOLTA_HOME $HOME/.volta

fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/scripts
fish_add_path $GOPATH/bin
fish_add_path $VOLTA_HOME/bin
fish_add_path $CARGO_HOME/bin
fish_add_path /usr/local/go/bin

eval "$(/opt/homebrew/bin/brew shellenv)"

starship init fish | source
zoxide init fish | source
fish_config theme choose catppuccin-mocha

abbr --add cat bat
abbr --add cnsl 'assume -c'
abbr --add g git
abbr --add la 'eza -la'
abbr --add lg lazygit
abbr --add ll 'eza -1'
abbr --add ls eza
abbr --add oc opencode
abbr --add p pnpm
abbr --add python python3
abbr --add tree 'eza --tree --git-ignore'
