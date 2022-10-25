require("lualine").setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_c = {
            {
                "filename",
                path = { 1 },
            },
        },
    },
    winbar = {
        lualine_c = { "filename" },
    },
    inactive_winbar = {
        lualine_c = { "filename" },
    },
})
