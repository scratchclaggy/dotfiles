return {
  'gbprod/substitute.nvim',
  config = function()
    local substitute = require 'substitute'
    local exchange = require 'substitute.exchange'
    local set = vim.keymap.set

    substitute.setup()

    set('n', 's', substitute.operator)
    set('n', 'ss', substitute.line)
    set('n', 'S', substitute.eol)
    set('x', 's', substitute.visual)

    set('n', 'sx', exchange.operator)
    set('n', 'sxx', exchange.line)
    set('x', 'X', exchange.visual)
    set('n', 'sxc', exchange.cancel)
  end,
}
