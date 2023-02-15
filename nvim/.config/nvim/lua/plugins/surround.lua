return {
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  { "echasnovski/mini.surround", enabled = false },
}
