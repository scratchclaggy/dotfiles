-- Refer to the nvim-lspconfig for configuration help
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

require'lspconfig'.cssls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.vimls.setup{}
