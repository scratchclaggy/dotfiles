" Set leader to spacebar
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set termguicolors                       " Use 24 bit colors
set cursorline                          " Highlight the current line the cursor is over
set nowrap                              " Display long lines as just one line
set pumheight=10                        " Makes popup menu smaller
set number	                          	" Line numbers
set relativenumber 	            		" Relative numbers
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nohlsearch                          " Remove highlights after search completed
set scrolloff=8                         " Start scrolling before the first/last visible line
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set formatoptions-=cro                  " Stop newline continution of comments
set hidden                              " Required to keep multiple buffers open multiple buffers
set noswapfile                          " Do not create swapfiles
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set undodir=~/.config/nvim/undo         " Set directory to store undo history
set undofile                            " Undo history
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set clipboard=unnamed                   " Copy paste between vim and everything else
set shortmess+=I                        " Disable startup message
set ignorecase                          " Case insensitive search
set smartcase                           " Case sensitive search if mixed cash
set mouse+=a                            " Enable mouse support
set nostartofline                       " Keep cursor position when changing active buffer 

