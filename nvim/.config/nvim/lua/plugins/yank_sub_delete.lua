local plug = function(cmd_string)
  return "<plug>(" .. cmd_string .. ")"
end

return {
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
