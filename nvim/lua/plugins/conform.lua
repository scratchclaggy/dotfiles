local prettier = { 'prettier', 'biome', stop_after_first = true }

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })

return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 1500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      html = prettier,
      javascript = prettier,
      json = prettier,
      jsonc = prettier,
      lua = { 'stylua' },
      markdown = { 'prettier' },
      python = { 'isort', 'black', stop_after_first = true },
      rust = { 'rustfmt' },
      typescript = prettier,
      typescriptreact = prettier,
      yaml = prettier,
    },
  },
}
