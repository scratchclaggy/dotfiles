vim.pack.add { Gh 'folke/todo-comments.nvim' }

require('todo-comments').setup { signs = true }

vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })
