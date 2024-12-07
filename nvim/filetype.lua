vim.filetype.add {
  extension = {
    ts = function(path)
      -- INFO: stolen from:
      -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua#L22
      local util = require 'lspconfig.util'
      local root_dir = util.root_pattern 'deno.json'(path)
      if root_dir ~= nil then
        return 'deno'
      else
        return 'typescript'
      end
    end,
  },
}
