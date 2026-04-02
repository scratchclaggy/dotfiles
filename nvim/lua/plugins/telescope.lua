return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  event = 'VimEnter',
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { 'node_modules', '.git/' },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- LSP keymaps via Telescope (runs per-buffer on LspAttach)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
      callback = function(event)
        local builtin = require 'telescope.builtin'
        local buf = event.buf

        -- Find references for the word under your cursor.
        vim.keymap.set('n', 'glr', builtin.lsp_references, { buffer = buf, desc = 'LSP: Goto [R]eferences' })

        -- Jump to the implementation of the word under your cursor.
        vim.keymap.set('n', 'gli', builtin.lsp_implementations, { buffer = buf, desc = 'LSP: Goto [I]mplementation' })

        -- Jump to the definition of the word under your cursor.
        vim.keymap.set('n', 'gld', builtin.lsp_definitions, { buffer = buf, desc = 'LSP: Goto [D]efinition' })

        -- Fuzzy find all the symbols in your current document.
        vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'LSP: Open Document Symbols' })

        -- Fuzzy find all the symbols in your current workspace.
        vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'LSP: Open Workspace Symbols' })

        -- Jump to the type of the word under your cursor.
        vim.keymap.set('n', 'glt', builtin.lsp_type_definitions, { buffer = buf, desc = 'LSP: Goto [T]ype Definition' })
      end,
    })
  end,
  keys = {
    {
      '<leader>sb',
      function() require('telescope.builtin').buffers() end,
      desc = '[S]earch existing [B]uffers',
    },
    {
      '<leader>sh',
      function() require('telescope.builtin').help_tags() end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function() require('telescope.builtin').keymaps() end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>ss',
      function() require('telescope.builtin').git_status() end,
      desc = '[S]earch git [S]tatus',
    },
    {
      '<leader><leader>',
      function() require('telescope.builtin').find_files { hidden = true } end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>st',
      function() require('telescope.builtin').builtin() end,
      desc = '[S]earch Select [T]elescope',
    },
    {
      '<leader>sw',
      function() require('telescope.builtin').grep_string() end,
      mode = { 'n', 'v' },
      desc = '[S]earch current [W]ord',
    },
    {
      '<leader>sg',
      function() require('telescope.builtin').live_grep() end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      function() require('telescope.builtin').diagnostics() end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function() require('telescope.builtin').resume() end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>s.',
      function() require('telescope.builtin').oldfiles() end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      function()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sc',
      function() require('telescope.builtin').commands() end,
      desc = '[S]earch [C]ommands',
    },
    {
      '<leader>sn',
      function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end,
      desc = '[S]earch [N]eovim files',
    },
  },
}
