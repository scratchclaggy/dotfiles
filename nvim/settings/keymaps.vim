" Easily source config
nnoremap <leader>so :so ~/.config/nvim/init.vim<CR>

" Close the current buffer
nnoremap <silent> <leader>d :bd<CR>

" Save current buffer
nnoremap <silent> <leader>w :w<CR>

" Open netrw
nnoremap <silent> <leader>e :Ex<CR>

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

" Toggle paste mode
nnoremap <silent> <leader>sp :set paste!<CR>

" Disable ex mode
nnoremap Q <Nop>

" Plugins

" Fugitive
nnoremap <silent> <leader>g :vertical Git<CR>

" fzf
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>v :Files ~/.dotfiles<CR>
nnoremap <leader>r :Rg 

" nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

