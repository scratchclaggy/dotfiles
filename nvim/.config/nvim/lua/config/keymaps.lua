local set = vim.keymap.set
local neogit = require("neogit")
local gitsigns = require("gitsigns")

set("n", "<leader>gg", neogit.open, { desc = "Neogit" })
set("n", "<leader>gG", "<nop>")

set("n", "<leader>ug", gitsigns.toggle_deleted, { desc = "Toggle Git Deleted" })
set("n", "<leader>ub", gitsigns.toggle_current_line_blame, { desc = "Toggle Git Deleted" })

local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
})
