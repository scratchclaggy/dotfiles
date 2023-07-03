return {
  {
    "NeogitOrg/neogit",
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
        disable_builtin_notifications = true,
      })
    end,
    lazy = false,
  },
}
