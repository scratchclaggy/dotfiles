return {
  'MagicDuck/grug-far.nvim',
  opts = {},
  keys = {
    {
      '<leader>f',
      function()
        require('grug-far').open()
      end,
      desc = '[F]ind (and replace)',
    },
  },
}
