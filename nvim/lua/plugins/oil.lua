return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    default_file_explorer = true,
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
    },
    view_options = { show_hidden = true },
  },
  lazy = false,
  keys = {
    { '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' } },
  },
}
