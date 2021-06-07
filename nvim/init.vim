" Set nvim to use sh
if &shell =~# 'fish$'
    set shell=sh
endif

" Plugin manager 
source $HOME/.config/nvim/settings/plugins.vim

" General settings
source $HOME/.config/nvim/settings/general.vim
source $HOME/.config/nvim/settings/clipboard.vim
source $HOME/.config/nvim/settings/colorscheme.vim

" Individual plugin settings
source $HOME/.config/nvim/settings/airline.vim
source $HOME/.config/nvim/settings/delimitmate.vim
luafile $HOME/.config/nvim/settings/gitsigns.lua
luafile $HOME/.config/nvim/settings/nvim-colorizer.lua
luafile $HOME/.config/nvim/settings/nvim-compe.lua
source $HOME/.config/nvim/settings/vim-vsnip.vim

" LSP
luafile $HOME/.config/nvim/settings/lsp_config.lua

" Treesitter
luafile $HOME/.config/nvim/settings/treesitter.lua

" Mappings
source $HOME/.config/nvim/settings/keymaps.vim

" Filetype plugins
source $HOME/.config/nvim/ftplugin/css.vim
source $HOME/.config/nvim/ftplugin/help.vim
source $HOME/.config/nvim/ftplugin/html.vim

