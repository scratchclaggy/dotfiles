local cmd = function(cmd_string)
    return "<cmd>" .. cmd_string .. "<cr>"
end

local telescope = require("telescope.builtin")

local servers = {
    bashls = {},
    clangd = {},
    pyright = {},
    sumneko_lua = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
    tailwindcss = {},
    tsserver = {},
}

local on_attach = function(_, bufnr)
    local nmap = function(keys, func)
        vim.keymap.set("n", keys, func, { buffer = bufnr })
    end

    nmap("<leader>rn", cmd("Lspsaga rename"))
    nmap("<leader>ca", cmd("Lspsaga code_action"))
    nmap("gd", vim.lsp.buf.definition)
    nmap("gr", cmd("TroubleToggle lsp_references"))
    nmap("gR", telescope.lsp_references)
    nmap("gI", vim.lsp.buf.implementation)
    nmap("<leader>D", vim.lsp.buf.type_definition)
    nmap("<leader>ds", telescope.lsp_document_symbols)
    nmap("<leader>ws", telescope.lsp_dynamic_workspace_symbols)
    nmap("K", cmd("Lspsaga hover_doc"))
    nmap("<C-k>", vim.lsp.buf.signature_help)
    nmap("gD", vim.lsp.buf.declaration)
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder)
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder)
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    nmap("<leader>fm", vim.lsp.buf.format)
end

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})

local signs = { Error = "!", Warn = "!", Hint = "?", Info = "?" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
    ensure_installed = { "black", "clang_format", "prettier", "rustfmt", "stylua" },
    automatic_installation = true,
})

mason_null_ls.setup_handlers({
    -- Default case
    function(source_name, methods)
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    -- Formatter specific cases
    clang_format = function(source_name, methods)
        null_ls.builtins.formatting.clang_format.with({
            extra_args = { "--style", "{BasedOnStyle: Google, ColumnLimit: 0, IndentWidth: 4}" },
        })
    end,
    stylua = function(source_name, methods)
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        })
    end,
})

null_ls.setup()

require("fidget").setup()
require("trouble").setup()
require("lspsaga").setup()
require("rust-tools").setup({
    server = {
        on_attach = on_attach
    }
})
