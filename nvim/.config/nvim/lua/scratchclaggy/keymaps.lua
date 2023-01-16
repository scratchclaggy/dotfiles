vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.yoinkIncludeDeleteOperations = 1

local cmd = function(cmd_string)
    return "<cmd>" .. cmd_string .. "<cr>"
end

local plug = function(cmd_string)
    return "<plug>(" .. cmd_string .. ")"
end

local buffer_search = function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end

local map = vim.keymap.set
local neogit = require("neogit")
local gitsigns = require("gitsigns")
local telescope = require("telescope.builtin")

map("n", "<leader>?", telescope.oldfiles)
map("n", "<leader><space>", telescope.buffers)
map("n", "<leader>/", buffer_search)
map("n", "<leader>sf", telescope.find_files)
map("n", "<leader>sh", telescope.help_tags)
map("n", "<leader>sw", telescope.grep_string)
map("n", "<leader>sg", telescope.live_grep)
map("n", "<leader>sd", telescope.diagnostics)

map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>e", vim.diagnostic.open_float)

-- Cutlass / Yoink / Subversive
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

map("n", "<leader>g", neogit.open)
map("n", "[g]", gitsigns.prev_hunk)
map("n", "]g", gitsigns.next_hunk)

-- Lua
map("n", "<leader>tt", cmd("TodoTrouble"))
map("n", "<leader>tw", cmd("TroubleToggle workspace_diagnostics"))
map("n", "<leader>td", cmd("TroubleToggle document_diagnostics"))
map("n", "<leader>tl", cmd("TroubleToggle loclist"))
map("n", "<leader>tq", cmd("TroubleToggle quickfix"))

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("n", "<leader>a", "ggVG")
map("n", "qq", cmd("q"))
map("n", "<leader><esc>", cmd("wqa"))
map("n", "<leader>w", cmd("w"))
map("n", "Q", "<nop>")
map("n", "<tab>", cmd("b#"))
map("n", "<s-tab>", cmd("bprevious"))
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<c-h>", cmd("FocusSplitLeft"))
map("n", "<c-j>", cmd("FocusSplitDown"))
map("n", "<c-k>", cmd("FocusSplitUp"))
map("n", "<c-l>", cmd("FocusSplitRight"))

map("n", "yob", gitsigns.toggle_current_line_blame)
map("n", "yod", gitsigns.toggle_current_line_blame)
map("n", "yof", cmd("FocusToggle"))
