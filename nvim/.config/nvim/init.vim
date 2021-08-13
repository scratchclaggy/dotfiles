" Plugin manager 
source $HOME/.config/nvim/settings/plugins.vim

" General settings
source $HOME/.config/nvim/settings/general.vim
source $HOME/.config/nvim/settings/clipboard.vim
source $HOME/.config/nvim/settings/colorscheme.vim

" Individual plugin settings
source $HOME/.config/nvim/settings/airline.vim
source $HOME/.config/nvim/settings/delimitmate.vim
source $HOME/.config/nvim/settings/neoformat.vim
luafile $HOME/.config/nvim/settings/nvim-colorizer.lua
luafile $HOME/.config/nvim/settings/nvim-compe.lua
source $HOME/.config/nvim/settings/vim-vsnip.vim

" LSP
luafile $HOME/.config/nvim/settings/lsp_config.lua

" Treesitter
luafile $HOME/.config/nvim/settings/treesitter.lua

" Mappings
source $HOME/.config/nvim/settings/keymaps.vim
