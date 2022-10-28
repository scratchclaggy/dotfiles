local lspconfig = require("lspconfig")
local servers = {
    { language = "bashls" },
    { language = "clangd" },
    { language = "gopls" },
    { language = "prismals" },
    { language = "pyright" },
    { language = "rust_analyzer" },
    { language = "tailwindcss" },
    { language = "texlab" },
    { language = "tsserver" },
}

local signs = { Error = "!", Warn = "!", Hint = "?", Info = "?" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = 'utf-8'
for _, lsp in ipairs(servers) do
    lspconfig[lsp.language].setup({
        capabilities = capabilities,
    })
end

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format.with({
            extra_args = { "--style", "{BasedOnStyle: Google, ColumnLimit: 0, IndentWidth: 4}" },
        }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.stylua.with({
            extra_args = {
                "--indent-type",
                "Spaces",
            },
        }),
    },
})

require("trouble").setup()

local lspsaga = require("lspsaga")
lspsaga.setup()
