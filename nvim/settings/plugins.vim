call plug#begin('~/.config/nvim/autoload/plugged')

" Dracula colour scheme
Plug 'dracula/vim', { 'as': 'dracula-vim'}

" Nvim lua shortcommands
Plug 'nvim-lua/plenary.nvim'

" Color sorted CSVs
Plug 'mechatroner/rainbow_csv'

" Color highlighter
Plug 'norcalli/nvim-colorizer.lua'

" Auto completion
Plug 'hrsh7th/nvim-compe'

" Native LSP
Plug 'neovim/nvim-lspconfig'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

" Auto surround with parentheses, braces, etc.
Plug 'raimondi/delimitmate'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Comments
Plug 'tpope/vim-commentary'

" Make and run
Plug 'tpope/vim-dispatch'

" Git integration
Plug 'tpope/vim-fugitive'

" Status bar
Plug 'vim-airline/vim-airline'

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" HTML smart snippets
Plug 'mattn/emmet-vim'

" Git commit navigation
Plug 'junegunn/gv.vim'

" Git changes
Plug 'lewis6991/gitsigns.nvim'

call plug#end()
