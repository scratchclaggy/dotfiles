local servers = {
    bashls = {},
    clangd = {},
    pyright = {},
    rust_analyzer = {},
    sumneko_lua = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
    tailwindcss = {},
    tsserver = {},
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

local keymaps = require('keymaps')

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = keymaps.on_attach,
            settings = servers[server_name],
        })
    end,
})

require("fidget").setup()

local signs = { Error = "!", Warn = "!", Hint = "?", Info = "?" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--[[ local null_ls = require("null-ls") ]]
--[[ null_ls.setup({ ]]
--[[     sources = { ]]
--[[         null_ls.builtins.formatting.black, ]]
--[[         null_ls.builtins.formatting.clang_format.with({ ]]
--[[             extra_args = { "--style", "{BasedOnStyle: Google, ColumnLimit: 0, IndentWidth: 4}" }, ]]
--[[         }), ]]
--[[         null_ls.builtins.formatting.prettier, ]]
--[[         null_ls.builtins.formatting.rustfmt, ]]
--[[         null_ls.builtins.formatting.stylua.with({ ]]
--[[             extra_args = { ]]
--[[                 "--indent-type", ]]
--[[                 "Spaces", ]]
--[[             }, ]]
--[[         }), ]]
--[[     }, ]]
--[[ }) ]]

require("trouble").setup()

require("lspsaga").setup()

require("rust-tools").setup()
