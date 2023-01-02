require("lualine").setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_b = {
            "branch",
            "diff",
            "diagnostics",
            { max_length = 2 },
        },
        lualine_c = {
            {
                "filename",
                path = { 1 },
            },
        },
    },
    winbar = {
        lualine_c = { { "filename", path = 1 } },
    },
    inactive_winbar = {
        lualine_c = { { "filename", path = 1 } },
    },
})
