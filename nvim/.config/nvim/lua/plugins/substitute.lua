return {
  'gbprod/substitute.nvim',
  opts = {},
  keys = function()
    local substitute = require 'substitute'
    local exchange = require 'substitute.exchange'
    return {
      { 's', substitute.operator },
      { 'ss', substitute.line },
      { 'S', substitute.eol },
      { 'sx', exchange.operator },
      { 'sxx', exchange.line },
      { 'X', exchange.visual },
      { 'sxc', exchange.cancel },
      { 's', substitute.visual },
    }
  end,
}
