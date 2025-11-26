return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    lazygit = {
      win = {
        position = 'float',
      },
    },
    terminal = {
      shell = 'fish',
      win = {
        position = 'right',
      },
    },
  },
  keys = {
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>tt',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
  },
}
