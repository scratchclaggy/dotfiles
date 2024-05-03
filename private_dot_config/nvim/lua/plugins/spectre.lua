return {
  'nvim-pack/nvim-spectre',
  opts = {},
  keys = function()
    local spectre = require 'spectre'

    return {
      { '<leader>sp', spectre.toggle, desc = 'Toggle Spectre' },
      {
        '<leader>sw',
        function()
          spectre.open_visual { select_word = true }
        end,
        desc = 'Search current word',
      },
      { '<leader>sw', spectre.open_visual, mode = 'v', desc = 'Search current word' },
      {
        '<leader>sc',
        function()
          spectre.open_file_search { select_word = true }
        end,
        desc = 'Search in current file',
      },
    }
  end,
}
