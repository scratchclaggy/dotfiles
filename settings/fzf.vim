" Invoke CtrlP
nnoremap <C-f> :FZF<CR>
nnoremap <leader>v :FZF ~/.dotfiles<CR>

fzf#run({'source': 'fd .'})
