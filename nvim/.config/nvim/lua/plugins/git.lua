return {
  {
    "TimUntersberger/neogit",
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
      })
    end,
    lazy = false,
  },
}
