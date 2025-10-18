return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  keys = function()
    local todo = require 'todo-comments'
    return {
      { ']t', todo.jump_next, desc = 'Next todo comment' },
      { '[t', todo.jump_prev, desc = 'Previous todo comment' },
    }
  end,
}
