" Easily edit and source my vimrc
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>so :so ~/.config/nvim/init.vim<CR>

" Close the current buffer
nnoremap <leader>d :bd<CR>

" Save current buffer
nnoremap <silent> <leader>w :w<CR>

" Select all
nnoremap <leader>sa gg0vG$

" TAB in general mode will move to text buffer
" SHIFT-TAB will go back
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Anki import formatting
nnoremap <LEADER>j $F,a<lt>img src="<Esc>$a.png"><Esc>0yl:s/<C-r>0/_/g<CR>phxjA,
