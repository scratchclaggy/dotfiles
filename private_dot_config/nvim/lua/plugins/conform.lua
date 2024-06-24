return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      html = { { 'prettierd', 'prettier' } },
      lua = { 'stylua' },
      -- python = { "isort", "black" },
      javascript = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      rust = { 'rustfmt' },
      typescript = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
    },
  },
}
