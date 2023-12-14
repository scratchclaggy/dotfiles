export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

ZDOTDIR=$XDG_CONFIG_HOME/zsh

# bun completions
[ -s "/Users/james/.bun/_bun" ] && source "/Users/james/.bun/_bun"
