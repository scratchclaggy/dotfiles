local plug = require("utilities").plug

return {
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
      },
    },
    keys = {
      { "p", plug("YankyPutAfter"), { "n", "x" } },
      { "P", plug("YankyPutBefore"), { "n", "x" } },
      { "gp", plug("YankyGPutAfter"), { "n", "x" } },
      { "gP", plug("YankyGPutBefore"), { "n", "x" } },
      { "<c-n>", plug("YankyCycleForward") },
      { "<c-p>", plug("YankyCycleBackward") },
    },
    dependencies = {
      "telescope.nvim",
      config = function()
        require("telescope").load_extension("yank_history")
      end,
    },
  },
  {
    "gbprod/substitute.nvim",
    config = function()
      local set = vim.keymap.set
      require("substitute").setup()

      set("n", "s", require("substitute").operator, { noremap = true })
      set("n", "ss", require("substitute").line, { noremap = true })
      set("n", "S", require("substitute").eol, { noremap = true })
      set("n", "sx", require("substitute.exchange").operator, { noremap = true })
      set("n", "sxx", require("substitute.exchange").line, { noremap = true })
      set("x", "X", require("substitute.exchange").visual, { noremap = true })
      set("n", "sxc", require("substitute.exchange").cancel, { noremap = true })
      set("x", "s", require("substitute").visual, { noremap = true })
    end,
  },
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "m",
    },
  },
}
