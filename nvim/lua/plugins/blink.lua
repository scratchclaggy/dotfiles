vim.pack.add { { src = Gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }

require('blink.cmp').setup {
	keymap = { preset = 'default' },
	appearance = { nerd_font_variant = 'normal' },
	completion = {
		-- By default, you may press `<c-space>` to show the documentation.
		-- Optionally, set `auto_show = true` to show the documentation after a delay.
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
	},
	sources = { default = { 'lsp', 'path', 'snippets' } },
	fuzzy = { implementation = 'prefer_rust_with_warning' },
	signature = { enabled = true },
}
