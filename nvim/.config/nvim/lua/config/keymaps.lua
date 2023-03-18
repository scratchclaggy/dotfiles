local Util = require("lazyvim.util")
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local plug = require("utilities").plug
local cmd = require("utilities").cmd

local neogit = require("neogit")

map("n", "<leader>w", cmd("w"))

map("n", "<leader>gg", neogit.open, { desc = "Neogit" })
map("n", "<leader>gl", function()
  Util.float_term({ "lazygit" }, { cwd = Util.get_root() })
end, { desc = "Lazygit" })
map("n", "<leader>gG", "<nop>")

-- Cutlass / Subversive / Yoink
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
