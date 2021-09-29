local lspconfig = require("lspconfig")
local servers = {"ccls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

require("lspsaga").init_lsp_saga {
  finder_action_keys = {
    open = "<cr>",
    quit = {"q", "<esc>"},
    scroll_down = "<C-d>",
    scroll_up = "<C-u>"
  },
  max_preview_lines = 50,
  rename_prompt_prefix = ">"
}
