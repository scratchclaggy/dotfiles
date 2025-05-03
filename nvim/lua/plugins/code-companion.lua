return {
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    keys = {
      { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' } },
      { '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' } },
      { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v' },
    },

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    cmd = 'Copilot',
    config = function()
      require('copilot').setup {}
    end,
  },
}
