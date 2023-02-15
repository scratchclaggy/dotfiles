local plug = require("utilities").plug

vim.g.yoinkIncludeDeleteOperations = 1

return {
  {
    "svermeulen/vim-cutlass",
    keys = {
      { "m", "d", { mode = "nx" } },
      { "mm", "dd" },
      { "M", "D" },
    },
  },
  {
    "svermeulen/vim-subversive",
    keys = {
      { "s", plug("SubversiveSubstitute"), { mode = "ns" } },
      { "ss", plug("SubversiveSubstituteLine") },
      { "S", plug("SubversiveSubstituteToEndOfLine") },
      { "p", plug("SubversiveSubstitute"), { mode = "s" } },
      { "P", plug("SubversiveSubstitute"), { mode = "s" } },
    },
  },
  {
    "svermeulen/vim-yoink",
    keys = {
      { "p", plug("YoinkPaste_p") },
      { "P", plug("YoinkPaste_P") },
      { "Y", "y$" },
      { "<c-n>", plug("YoinkPostPasteSwapBack") },
      { "<c-p>", plug("YoinkPostPasteSwapForward") },
    },
  },
}
