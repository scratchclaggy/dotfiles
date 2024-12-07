return {
  'nvim-pack/nvim-spectre',
  config = true,
  -- opts = {
  --   replace_engine = {
  --     ['sed'] = vim.fn.has 'macunix' and { cmd = 'sed', args = { '-i', '', '-E' } },
  --   } or nil,
  -- },
  keys = function()
    local spectre = require 'spectre'

    return {
      { '<leader>sp', spectre.toggle, desc = 'Toggle Spectre' },
    }
  end,
}
