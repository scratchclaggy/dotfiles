local lsp = require 'plugins.lspconfig.servers'

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        map('gln', vim.lsp.buf.rename, 'Re[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('gla', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })

        -- Goto Declaration (e.g. in C this would take you to the header)
        map('glD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Highlight references of the word under your cursor when it rests there.
        --   See `:help CursorHold`
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

        -- Toggle inlay hints, if the language server supports them
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Diagnostic keymaps (global, not LSP-specific)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

    vim.diagnostic.config {
      update_in_insert = false,
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = { min = vim.diagnostic.severity.WARN } },
      virtual_text = true,
      virtual_lines = false,
      jump = { float = true },
    }

    require('mason-tool-installer').setup {
      ensure_installed = lsp.ensure_installed,
    }

    for name, server in pairs(lsp.servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
}
