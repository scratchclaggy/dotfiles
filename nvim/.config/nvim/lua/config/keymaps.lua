local Util = require("lazyvim.util")
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local plug = require("utilities").plug
local cmd = require("utilities").cmd

local neogit = require("neogit")
local gs = require("gitsigns")

map("n", "<leader>gg", neogit.open, { desc = "Neogit" })
map("n", "<leader>gl", function()
  Util.float_term({ "lazygit" }, { cwd = Util.get_root() })
end, { desc = "Lazygit" })
map("n", "<leader>gG", "<nop>")
map("n", "<leader>ug", gs.toggle_deleted, { desc = "Toggle Git Deleted" })
map("n", "<leader>ub", gs.toggle_current_line_blame, { desc = "Toggle Git Deleted" })
