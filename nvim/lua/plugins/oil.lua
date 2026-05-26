vim.pack.add { Gh 'stevearc/oil.nvim' }

local oil = require 'oil'

oil.setup {
  default_file_explorer = true,
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
  },
  view_options = { show_hidden = true },
}

vim.keymap.set('n', '-', function() oil.open() end, { desc = 'Open parent directory' })
