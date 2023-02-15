return {
  {
    "svermeulen/vim-cutlass",
    lazy = false,
  },
  {
    "svermeulen/vim-subversive",
    lazy = false,
  },
  {
    "svermeulen/vim-yoink",
    config = function()
      vim.g.yoinkIncludeDeleteOperations = 1
    end,
    lazy = false,
  },
}
