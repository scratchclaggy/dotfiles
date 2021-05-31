# Fish Settings
set fish_greeting

# Aliases
alias .. 'cd ..'
alias c clear
alias exe 'explorer.exe .'
alias g git
alias gcam 'git add . && git commit -a -m'
alias gs 'git status'
alias python python3
alias v nvim
alias vim nvim

# FZF
set -x FZF_DEFAULT_COMMAND 'fd . $CWD -H -t f'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_ALT_C_COMMAND 'fd . $CWD -t d'

# PATH variable
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.yarn/bin $PATH
set PATH $HOME/.yarn/global/node_modules/.bin $PATH
set PATH $HOME/go/bin $PATH
set PATH /usr/local/go/bin $PATH

# Enable Starship prompt
# starship init fish | source
