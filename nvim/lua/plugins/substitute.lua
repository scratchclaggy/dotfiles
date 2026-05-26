vim.pack.add { Gh 'gbprod/substitute.nvim' }

require('substitute').setup {}

vim.keymap.set('n', 's', function() require('substitute').operator() end)
vim.keymap.set('n', 'ss', function() require('substitute').line() end)
vim.keymap.set('n', 'S', function() require('substitute').eol() end)
vim.keymap.set('x', 's', function() require('substitute').visual() end)
