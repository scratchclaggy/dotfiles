return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
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
  end,
  keys = function()
    local builtin = require 'telescope.builtin'

    return {
      { '<leader>sb', builtin.buffers, desc = '[S]earch existing [B]uffers' },
      { '<leader>sh', builtin.help_tags, desc = '[S]earch [H]elp' },
      { '<leader>sk', builtin.keymaps, desc = '[S]earch [K]eymaps' },
      { '<leader>ss', builtin.git_status, desc = '[S]earch git [S]tatus' },
      {
        '<leader><leader>',
        function()
          builtin.find_files { hidden = true }
        end,
        desc = '[S]earch [F]iles',
      },
      { '<leader>st', builtin.builtin, desc = '[S]earch Select [T]elescope' },
      { '<leader>sw', builtin.grep_string, desc = '[S]earch current [W]ord' },
      { '<leader>sg', builtin.live_grep, desc = '[S]earch by [G]rep' },
      { '<leader>sd', builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', builtin.resume, desc = '[S]earch [R]esume' },
      { '<leader>s.', builtin.oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },

      -- Slightly advanced example of overriding default behavior and theme
      {
        '<leader>/',
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        desc = '[/] Fuzzily search in current buffer',
      },

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      {
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        desc = '[S]earch [/] in Open Files',
      },

      -- Shortcut for searching your neovim configuration files
      {
        '<leader>sn',
        function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[S]earch [N]eovim files',
      },
    }
  end,
}
