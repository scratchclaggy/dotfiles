return {
  'pmizio/typescript-tools.nvim',
  ft = { 'typescript', 'typescriptreact' },
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    root_dir = function(fname)
      -- INFO: stolen from:
      -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua#L22
      local util = require 'lspconfig.util'
      local root_dir = util.root_pattern('pnpm-workspace.yaml', 'package.json')(fname)

      -- INFO: this is needed to make sure we don't pick up root_dir inside node_modules
      local node_modules_index = root_dir and root_dir:find('node_modules', 1, true)
      if node_modules_index and node_modules_index > 0 then
        root_dir = root_dir:sub(1, node_modules_index - 2)
      end

      return root_dir
    end,
    single_file_support = false,
  },
}
