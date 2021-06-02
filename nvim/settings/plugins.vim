call plug#begin('~/.config/nvim/autoload/plugged')

" Dracula colour scheme
Plug 'dracula/vim', { 'as': 'dracula-vim'}

" Color sorted CSVs
Plug 'mechatroner/rainbow_csv'

" Color highlighter
Plug 'ap/vim-css-color'

" Completion and intellisense
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Native LSP
Plug 'neovim/nvim-lspconfig'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Auto surround with parentheses, braces, etc.
Plug 'raimondi/delimitmate'

" File Explorer
Plug 'scrooloose/NERDTree'

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
Plug 'honza/vim-snippets'

" Web filetype formatting
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" JS Support
Plug 'pangloss/vim-javascript'

call plug#end()
