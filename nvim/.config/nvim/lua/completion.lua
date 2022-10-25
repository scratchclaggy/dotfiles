local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<up>"] = cmp.mapping.select_prev_item(),
        ["<down>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        [";"] = cmp.mapping.close(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer" },
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
})
