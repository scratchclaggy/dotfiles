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

local vim_command = function(cmd_string)
	return "<cmd>" .. cmd_string .. "<cr>"
end

nest.applyKeymaps({
	{
		"<space>",
		{
			{ "a", vim_command("Lspsaga code_action") },
			{ "bd", vim_command("bd") },
			{ "e", vim.diagnostic.open_float },
			{
				"f",
				{
					{ "f", vim_command("Telescope find_files") },
					{ "h", vim_command("Telescope help_tags") },
					{ "j", vim_command("Telescope git_files") },
					{ "l", vim_command("Telescope live_grep") },
					{ "m", vim.lsp.buf.format },
				},
			},
			{
				"g",
				{
					{ "f", vim_command("tab G") },
					{ "g", neogit.open },
					{ "n", gitsigns.next_hunk },
					{ "p", gitsigns.prev_hunk },
				},
			},
			{
				"l",
				{
					{ "d", vim_command("TroubleToggle document_diagnostics") },
					{ "l", vim_command("TroubleToggle") },
					{ "q", vim_command("TroubleToggle quickfix") },
					{ "r", vim_command("TroubleToggle lsp_references") },
					{ "t", vim_command("TodoTrouble") },
					{ "w", vim_command("TroubleToggle workspace_diagnostics") },
				},
			},
			{
				"s",
				{
					{ "a", "ggVG" },
					{ "h", vim_command("FocusSplitLeft") },
					{ "j", vim_command("FocusSplitDown") },
					{ "k", vim_command("FocusSplitUp") },
					{ "l", vim_command("FocusSplitRight") },
				},
			},
			{ "q", {
				{ "q", vim_command("q") },
				{ "n", vim_command("wqa") },
			} },
			{ "rn", vim_command(" Lspsaga rename") },
			{ "w", vim_command("w") },
		},
	},
	{
		"yo",
		{
			{ "b", gitsigns.toggle_current_line_blame },
			{ "d", gitsigns.toggle_deleted },
			{ "f", vim_command("FocusToggle") },
		},
	},
	{
		"g",
		{
			{ "d", vim_command("Lspsaga peek_definition") },
			{ "D", vim.lsp.buf.declaration },
			{ "i", vim.lsp.buf.implementation },
		},
	},
	{ "K", vim_command("Lspsaga hover_doc") },
	{ "Q", "<nop>" },
	{
		mode = "is",
		options = { expr = true },
		{
			{ "<tab>", tab_complete },
			{ "<s-tab>", s_tab_complete },
		},
	},
	{ "tlb", vim_command("TexlabBuild") },
	{ "<tab>", vim_command("b#") },
	{ "<s-tab>", vim_command("bprevious") },
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
