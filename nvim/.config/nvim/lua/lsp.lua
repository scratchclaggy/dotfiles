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

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = "utf-8"

require("lspconfig").sumneko_lua.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

local signs = { Error = "!", Warn = "!", Hint = "?", Info = "?" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
