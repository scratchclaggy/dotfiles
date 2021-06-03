source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export FZF_DEFAULT_COMMAND="fd . $CWD"
export FZF_CTRL_T_COMMAND="fd . $HOME"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
