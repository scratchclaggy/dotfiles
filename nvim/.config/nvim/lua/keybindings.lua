local gitsigns = require("gitsigns")
local neogit = require("neogit")
local nest = require("nest")
local trouble = require("trouble")

vim.g.yoinkIncludeDeleteOperations = 1

local replace_termcodes = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local s_tab_complete = function()
	if vim.fn["vsnip#jumpable"](-1) == 1 then
		vim.fn.feedkeys(replace_termcodes("<Plug>(vsnip-jump-prev)"), "")
		return ""
	end
end

local tab_complete = function()
	if vim.fn["vsnip#available"](1) == 1 then
		vim.fn.feedkeys(replace_termcodes("<Plug>(vsnip-expand-or-jump)"), "")
		return ""
	else
		return replace_termcodes("<Tab>")
	end
end

nest.applyKeymaps({
	{
		"<space>",
		{
			{ "bd", "<cmd>bd<cr>" },
			{ "e", vim.diagnostic.open_float },
			{
				"f",
				{
					{ "f", "<cmd>Telescope find_files<cr>" },
					{ "h", "<cmd>Telescope help_tags<cr>" },
					{ "j", "<cmd>Telescope git_files<cr>" },
					{ "l", "<cmd>Telescope live_grep<cr>" },
					{ "m", function() vim.lsp.buf.formatting_sync(nil, 5000) end },
				},
			},
			{
				"g",
				{
					{ "f", "<cmd>tab G<cr>" },
					{ "g", neogit.open },
					{ "n", gitsigns.next_hunk },
					{ "p", gitsigns.prev_hunk },
				},
			},
			{
				"l",
				{
					{ "d", "<cmd>TroubleToggle document_diagnostics<cr>" },
					{ "l", "<cmd>TroubleToggle<cr>" },
					{ "q", "<cmd>TroubleToggle quickfix<cr>" },
					{ "r", "<cmd>TroubleToggle lsp_references<cr>" },
					{ "t", "<cmd>TodoTrouble<cr>" },
					{ "w", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
				},
			},
			{
				"s",
				{
					{ "a", "ggVG" },
					{ "h", "<cmd>FocusSplitLeft<cr>" },
					{ "j", "<cmd>FocusSplitDown<cr>" },
					{ "k", "<cmd>FocusSplitUp<cr>" },
					{ "l", "<cmd>FocusSplitRight<cr>" },
				},
			},
			{ "q", {
				{ "q", "<cmd>q<cr>" },
				{ "n", "<cmd>wqa<cr>" },
			} },
			{ "rn", vim.lsp.buf.rename },
			{ "w", "<cmd>w<cr>" },
		},
	},
	{
		"yo",
		{
			{ "b", gitsigns.toggle_current_line_blame },
			{ "d", gitsigns.toggle_deleted },
			{ "f", "<cmd>FocusToggle<cr>" },
		},
	},
	{ "gd", vim.lsp.buf.definition },
	{ "gD", vim.lsp.buf.declaration },
	{ "gi", vim.lsp.buf.implementation },
	{ "K", vim.lsp.buf.hover },
	{ "Q", "<nop>" },
	{
		mode = "is",
		options = { expr = true },
		{
			{ "<tab>", tab_complete },
			{ "<s-tab>", s_tab_complete },
		},
	},
	{ "tlb", "<cmd>TexlabBuild<cr>" },
	{ "<tab>", "<cmd>b#<cr>" },
	{ "<s-tab>", "<cmd>bprevious<cr>" },
	{ "<", "<gv", mode = "v" },
	{ ">", ">gv", mode = "v" },
	{
		"<c-",
		{ { "h>", "<c-w>h" }, { "j>", "<c-w>j" }, { "k>", "<c-w>k" }, { "l>", "<c-w>l" } },
	},
	-- Cutlass / Yoink / Subversive
	{ "m", "d", mode = "nx" },
	{ "mm", "dd" },
	{ "M", "D" },
	{ "Y", "y$" },
	{
		options = { noremap = false },
		{
			{ "s", "<plug>(SubversiveSubstitute)", mode = "nx" },
			{ "ss", "<plug>(SubversiveSubstituteLine)" },
			{ "S", "<plug>(SubversiveSubstituteToEndOfLine)" },
			{ "p", "<plug>(YoinkPaste_p)" },
			{ "p", "<plug>(SubversiveSubstitute)", mode = "x" },
			{ "P", "<plug>(YoinkPaste_P)" },
			{ "P", "<plug>(SubversiveSubstitute)", mode = "x" },
			{ "<c-n>", "<Plug>(YoinkPostPasteSwapBack)" },
			{ "<c-p>", "<Plug>(YoinkPostPasteSwapForward)" },
		},
	},
})
