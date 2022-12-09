local lspconfig = require("lspconfig")
local servers = {
    { language = "bashls" },
    { language = "clangd" },
    { language = "gopls" },
    { language = "prismals" },
    { language = "pyright" },
    { language = "rust_analyzer" },
    {
        language = "sumneko_lua",
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            },
        },
    },
    { language = "tailwindcss" },
    { language = "texlab" },
    { language = "tsserver" },
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = "utf-8"

for _, lsp in ipairs(servers) do
    lspconfig[lsp.language].setup({
        capabilities = capabilities,
        settings = lsp.settings,
    })
end

local signs = { Error = "!", Warn = "!", Hint = "?", Info = "?" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("lspconfig").sumneko_lua.setup({
    capabilities = capabilities,
})

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

require("lspsaga").setup()

require("rust-tools").setup()
