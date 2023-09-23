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
      { "p", "<Plug>(YankyPutAfter)", { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", { "n", "x" } },
      { "gp", "<Plug>(YankyGPutAfter)", { "n", "x" } },
      { "gP", "<Plug>(YankyGPutBefore)", { "n", "x" } },
      { "<c-n>", "<Plug>(YankyCycleForward)" },
      { "<c-p>", "<Plug>(YankyCycleBackward)" },
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
    lazy = false,
    config = function()
      require("substitute").setup()

      vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
      vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
      vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true })
      vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true })
      vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
      vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true })
      vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
    end,
  },
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "m",
    },
  },
}
