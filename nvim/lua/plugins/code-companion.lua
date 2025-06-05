return {
  {
    'olimorris/codecompanion.nvim',
    opts = {
      opts = {
        strategies = {
          chat = { adapter = 'githubmodels', model = 'gpt-4o' },
          inline = { adapter = 'githubmodels', model = 'gpt-4o' },
        },
      },
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)

      vim.cmd [[cab cc CodeCompanion]]
    end,

    keys = {
      { '<C-c>', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' } },
      { '<LocalLeader>c', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' } },
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
    opts = {},
  },
}
