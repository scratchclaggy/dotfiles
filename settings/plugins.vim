call plug#begin('~/.config/nvim/autoload/plugged')

" Dracula colour scheme
Plug 'dracula/vim'

" Color sorted CSVs
Plug 'mechatroner/rainbow_csv'

" Completion and intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto surround with parentheses, braces, etc.
Plug 'raimondi/delimitmate'

" File Explorer
Plug 'scrooloose/NERDTree'

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Comments
Plug 'tpope/vim-commentary'

" Status bar
Plug 'vim-airline/vim-airline'

" Snippets
Plug 'honza/vim-snippets'

call plug#end()
