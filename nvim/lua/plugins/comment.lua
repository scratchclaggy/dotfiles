return {
  'numToStr/Comment.nvim',
  opts = function()
    local ts_comment = require 'ts_context_commentstring.integrations.comment_nvim'

    return {
      pre_hook = ts_comment.create_pre_hook(),
    }
  end,
  dependencies = { {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = { enable_autocmd = false },
  } },
}
