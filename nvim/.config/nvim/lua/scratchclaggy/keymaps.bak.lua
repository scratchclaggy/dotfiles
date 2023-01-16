vim.g.mapleader = " "
vim.g.maplocalleader = " "

local gitsigns = require("gitsigns")
local neogit = require("neogit")
local nest = require("nest")

vim.g.yoinkIncludeDeleteOperations = 1

local vim_command = function(cmd_string)
    return "<cmd>" .. cmd_string .. "<cr>"
end

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

local keymaps = {}
keymaps.on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim_command("Lspsaga rename"), "[R]e[n]ame")
    nmap("<leader>ca", vim_command("Lspsaga code_action"), "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

nest.applyKeymaps({
    {
        "<space>",
        {
            { "bd", vim_command("bd") },
            { "e", vim.diagnostic.open_float },
            {
                "f",
                {
                    { "f", vim_command("Telescope find_files") },
                    { "h", vim_command("Telescope help_tags") },
                    { "j", vim_command("Telescope git_files") },
                    { "l", vim_command("Telescope live_grep") },
                    {
                        "m",
                        function()
                            vim.lsp.buf.format({ timeout_ms = 2000 })
                        end,
                    },
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
                },
            },
            {
                "q",
                {
                    { "q", vim_command("q") },
                    { "n", vim_command("wqa") },
                },
            },
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
    { "K", vim_command("Lspsaga hover_doc") },
    { "Q", "<nop>" },
    { "tlb", vim_command("TexlabBuild") },
    { "<tab>", vim_command("b#") },
    { "<s-tab>", vim_command("bprevious") },
    { "<", "<gv", mode = "v" },
    { ">", ">gv", mode = "v" },
    {
        "<c-",
        {
            { "h>", vim_command("FocusSplitLeft") },
            { "j>", vim_command("FocusSplitDown") },
            { "k>", vim_command("FocusSplitUp") },
            { "l>", vim_command("FocusSplitRight") },
        },
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

return keymaps
