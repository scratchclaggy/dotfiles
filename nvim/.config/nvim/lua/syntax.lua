require("nvim-treesitter.configs").setup({
	autotag = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	refactor = {
		highlight_definitions = { enable = true },
	},
	yati = { enable = true },
})
