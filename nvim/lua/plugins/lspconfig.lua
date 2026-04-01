return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gln', vim.lsp.buf.rename, 'Re[n]ame')
        map('gla', vim.lsp.buf.code_action, 'Trigger Code [A]ction', { 'n', 'x' })
        map('glr', function()
          require('telescope.builtin').lsp_references()
        end, 'Goto [R]eferences')
        map('gli', function()
          require('telescope.builtin').lsp_implementations()
        end, 'Goto [I]mplementation')
        map('gld', function()
          require('telescope.builtin').lsp_definitions()
        end, 'Goto [D]efinition')
        map('glD', vim.lsp.buf.declaration, '[G]oto [D]eclaration') -- i.e. Go to header file...
        map('go', function()
          require('telescope.builtin').lsp_document_symbols()
        end, 'Open Document Symbols')
        map('gw', function()
          require('telescope.builtin').lsp_dynamic_workspace_symbols()
        end, 'Open [W]orkspace Symbols')
        map('glt', function()
          require('telescope.builtin').lsp_type_definitions()
        end, 'Goto [T]ype Definition')

        -- Diagnostic navigation
        map(']d', function() vim.diagnostic.jump { count = 1 } end, 'Next [D]iagnostic')
        map('[d', function() vim.diagnostic.jump { count = -1 } end, 'Previous [D]iagnostic')
        map('<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
        map('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          --
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
      end,
    })

    vim.diagnostic.config {
      update_in_insert = false,
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = { min = vim.diagnostic.severity.WARN } },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
      jump = { on_jump = function() vim.diagnostic.open_float() end },
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Set capabilities globally so all servers inherit them
    vim.lsp.config('*', { capabilities = capabilities })

    -- Per-server configuration overrides
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          completion = { callSnippet = 'Replace' },
        },
      },
    })

    vim.lsp.config('denols', {
      root_markers = { 'deno.json', 'deno.jsonc' },
      workspace_required = true,
    })

    vim.lsp.config('biome', {
      root_markers = { 'biome.json' },
      workspace_required = true,
    })

    require('mason-tool-installer').setup { ensure_installed = {} }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      automatic_enable = true,
    }
  end,
}
