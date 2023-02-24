return {
  "TimUntersberger/neogit",
    config = function()
      require("neogit").setup()
    end,
  keys = {
    {"<leader>gg", "<cmd>Neogit<cr>"}
  }
}
