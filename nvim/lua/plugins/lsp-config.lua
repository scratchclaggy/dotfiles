vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('yoh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle Inlay [H]ints')
    end
  end,
})

local ignored_tsc_diagnostic_codes = { [6133] = true }

local servers = {
  biome = {
    -- HACK: prevents biome from duplicating go-to-definition
    on_attach = function(client)
      local supports_method = client.supports_method

      client.supports_method = function(self, method, bufnr)
        if method == 'textDocument/definition' then return false end

        return supports_method(self, method, bufnr)
      end
    end,
  },
  ruff = {},
  stylua = {},
  tsc = {
    handlers = {
      -- Prevent tsc from surfacing diagnostics duplicated by biome or other linters.
      ['textDocument/diagnostic'] = function(err, result, ctx)
        if result and result.items then
          result.items = vim.tbl_filter(function(diagnostic) return not ignored_tsc_diagnostic_codes[diagnostic.code] end, result.items)
        end

        return vim.lsp.diagnostic.on_diagnostic(err, result, ctx)
      end,
    },
  },
  lua_ls = {},
}

vim.pack.add {
  Gh 'neovim/nvim-lspconfig',
  Gh 'mason-org/mason.nvim',
  Gh 'mason-org/mason-lspconfig.nvim',
  Gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('mason').setup {}

require('mason-lspconfig').setup {
  automatic_enable = false,
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
