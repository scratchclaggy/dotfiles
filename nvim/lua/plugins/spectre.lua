return {
  'nvim-pack/nvim-spectre',
  opts = function()
    if vim.fn.has 'macunix' == 1 then
      return {
        replace_engine = {
          ['sed'] = {
            cmd = 'sed',
            args = { '-i', '', '-E' },
          },
        },
      }
    end
  end,
  keys = function()
    local spectre = require 'spectre'

    return {
      { '<leader>sp', spectre.toggle, desc = 'Toggle Spectre' },
    }
  end,
}
