local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local plug = require("utilities").plug

map({ "n", "x" }, "m", "d")
map("n", "mm", "dd")
map("n", "M", "D")
map("n", "Y", "y$")
map({ "n", "x" }, "s", plug("SubversiveSubstitute"))
map("n", "ss", plug("SubversiveSubstituteLine"))
map("n", "S", plug("SubversiveSubstituteToEndOfLine"))
map("n", "p", plug("YoinkPaste_p"))
map("x", "p", plug("SubversiveSubstitute"))
map("n", "P", plug("YoinkPaste_P"))
map("x", "P", plug("SubversiveSubstitute"))
map("n", "<c-n>", plug("YoinkPostPasteSwapBack"))
map("n", "<c-p>", plug("YoinkPostPasteSwapForward"))
