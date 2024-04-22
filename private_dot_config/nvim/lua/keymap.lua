-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Session utilities
map("n", "<leader>js", "<cmd>qa<cr>", { desc = "[J]ump [s]hip" })
map("n", "<leader>wb", "<cmd>w<cr>", { desc = "[W]rite" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left [W]indow" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right [W]indow" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower [W]indow" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper [W]indow" })
map("n", "<leader>wq", "<C-w>q", { desc = "[Q]uit [W]indow" })
map("n", "<leader>\\", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>-", "<C-w>s", { desc = "Split vertically" })

-- Disable command history
map("n", "q:", "<nop>", {})
