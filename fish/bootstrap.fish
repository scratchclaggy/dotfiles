# NOTE: This sets some persistent config values and only needs to be run once 
# for each system, not for each shell session.

set -U XDG_CACHE_HOME $HOME/.cache
set -U XDG_CONFIG_HOME $HOME/.config
set -U XDG_DATA_HOME $HOME/.local/share

set -U EDITOR nvim
set -U PAGER "bat -p"

set -U BAT_CONFIG_PATH $XDG_CONFIG_HOME/bat/batrc
set -U CARGO_HOME $XDG_DATA_HOME/cargo
set -U GOPATH $XDG_DATA_HOME/go
set -U NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -U NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -U PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc
set -U PYENV_ROOT "$HOME/.pyenv"
set -U RUSTUP_HOME $XDG_DATA_HOME/rustup
set -U STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/config.toml
set -U VOLTA_HOME "$HOME/.volta"


fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/scripts
fish_add_path $HOME/.local/share/go/bin
fish_add_path $HOME/.volta/bin

fish_add_path $CARGO_HOME/bin

fish_add_path /usr/local/go/bin
