setopt autocd       # auto cd when given a dir name
setopt extendedglob # expand #, ~, and ^
setopt nomatch      # print errors when using invalid filename expansion

zle_highlight=('paste:none') # Don't highlight text on paste

# Enable programs
if [[ $(uname) == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Aliases
alias '?'='echo $?'
alias assume="source assume"
alias cnsl='assume -c'
alias c=clear
alias e=$EDITOR
alias explorer='/mnt/c/Windows/explorer.exe .'
alias files='xdg-open'
alias g='git'
alias gs='git status'
alias nala='sudo nala'
alias lg='lazygit'
alias python='python3'
alias p='pnpm'

if [[ $(command -v exa) ]]
then
  alias ls='exa'
  alias ll='exa -al'
  alias la='exa -1a'
  alias tree='exa --tree'
else
  echo "Install 'exa'"
  alias ll='ls -l'
  alias la='ls -la'
fi

if [[ $(command -v bat) ]]
then
  alias cat='bat'
else
  echo "Install 'bat'"
fi

# Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

### Lines beneath here were appended by some script ###
