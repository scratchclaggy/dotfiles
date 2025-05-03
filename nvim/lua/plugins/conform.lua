local prettier = { 'biome', 'prettierd', 'prettier', stop_after_first = true }

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
