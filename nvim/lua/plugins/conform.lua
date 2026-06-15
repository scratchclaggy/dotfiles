vim.pack.add { Gh 'stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local enabled_filetypes = {
      css = true,
      graphql = true,
      grit = true,
      gritql = true,
      html = true,
      javascript = true,
      javascriptreact = true,
      json = true,
      jsonc = true,
      lua = true,
      markdown = true,
      svg = true,
      typescript = true,
      typescriptreact = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    css = { 'biome' },
    graphql = { 'biome' },
    grit = { 'biome' },
    gritql = { 'biome' },
    html = { 'biome' },
    javascript = { 'biome' },
    javascriptreact = { 'biome' },
    json = { 'biome' },
    jsonc = { 'biome' },
    lua = { 'stylua' },
    markdown = { 'oxfmt' },
    svg = { 'biome' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
