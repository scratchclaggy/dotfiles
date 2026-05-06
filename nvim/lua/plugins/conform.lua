local web = { 'biome', 'prettier', stop_after_first = true }

return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }

      if disable_filetypes[vim.bo[bufnr].filetype] then return nil end

      return { timeout_ms = 1500 }
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    formatters_by_ft = {
      gritql = { 'biome' },
      html = web,
      javascript = web,
      json = web,
      jsonc = web,
      lua = { 'stylua' },
      kotlin = { 'ktfmt' },
      markdown = { 'prettier' },
      python = { 'isort', 'black', stop_after_first = true },
      rust = { 'rustfmt' },
      typescript = web,
      typescriptreact = web,
      yaml = { 'prettier' },
    },
  },
}
