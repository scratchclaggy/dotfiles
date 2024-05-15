return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  keys = function()
    local smart_splits = require 'smart-splits'

    return {
      { '<C-h>', smart_splits.move_cursor_left, { desc = 'Move focus to the left [W]indow' } },
      { '<C-j>', smart_splits.move_cursor_down, { desc = 'Move focus to the lower [W]indow' } },
      { '<C-k>', smart_splits.move_cursor_up, { desc = 'Move focus to the upper [W]indow' } },
      { '<C-l>', smart_splits.move_cursor_right, { desc = 'Move focus to the right [W]indow' } },
    }
  end,
}
