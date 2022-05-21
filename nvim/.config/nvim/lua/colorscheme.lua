vim.api.nvim_set_option("termguicolors", true)
-- vim.cmd("colorscheme dracula")
require("catppuccin").setup({ integrations = { neogit = true } })
vim.cmd("colorscheme catppuccin")
