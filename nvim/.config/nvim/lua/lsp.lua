local lspconfig = require("lspconfig")
local servers = {
	{ language = "bashls", formatting = false },
	{ language = "clangd", formatting = false },
	{ language = "gopls", formatting = false },
	{ language = "pyright", formatting = false },
	{ language = "rust_analyzer", formatting = false },
	{ language = "tailwindcss", formatting = false },
	{ language = "texlab", formatting = false },
	{ language = "tsserver", formatting = false },
}

local signs = { Error = "!", Warn = "!", Hint = "?", Info = "?" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp.language].setup({
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	})

	if not lsp.formatting then
		lspconfig[lsp.language].setup({
			on_attach = function(client)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end,
		})
	end
end

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format.with({
			extra_args = { "--style", "{IndentWidth: 4}" },
		}),
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
	},
})
