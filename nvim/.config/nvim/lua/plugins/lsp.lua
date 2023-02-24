return {
  { "neovim/nvim-lspconfig", opts = {
    autoformat = false,
  } },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.stylua,
        },
      }
    end,
  },
}
