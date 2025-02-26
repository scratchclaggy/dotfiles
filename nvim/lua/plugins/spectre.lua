return {
  'nvim-pack/nvim-spectre',
  config = true,
  opts = function()
    if vim.fn.has 'macunix' then
      return { replace_engine = { ['sed'] = { cmd = 'sed', args = { '-i', '', '-E' } } } }
    else
      return {}
    end
  end,
  keys = function()
    local spectre = require 'spectre'

    return {
      { '<leader>sp', spectre.toggle, desc = 'Toggle Spectre' },
    }
  end,
}
