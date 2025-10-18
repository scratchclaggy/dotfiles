return {
  'gbprod/substitute.nvim',
  opts = {},
  keys = function()
    local substitute = require 'substitute'
    return {
      { 's', substitute.operator },
      { 'ss', substitute.line },
      { 'S', substitute.eol },
      { 's', substitute.visual, mode = 'x' },
    }
  end,
}
