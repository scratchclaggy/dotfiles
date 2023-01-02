local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
    pickers = {
        help_tags = {
            mappings = {
                i = {
                    ["<CR>"] = actions.select_tab
                },
            },
        },
    },
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
})
