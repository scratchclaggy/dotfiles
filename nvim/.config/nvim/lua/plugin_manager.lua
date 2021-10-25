-- Bootstrap Packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd "packadd packer.nvim"
end

return require("packer").startup(
  function()
    -- Plugin Manager
    use "wbthomason/packer.nvim"

    -- LSP
    use "neovim/nvim-lspconfig"
    use {"glepnir/lspsaga.nvim", requires = "neovim/nvim-lspconfig"}
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons"
    }

    -- Completion
    use {"hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lua", requires = "hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-path", requires = "hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-vsnip", requires = "hrsh7th/nvim-cmp"}
    use "hrsh7th/nvim-cmp"

    -- Syntax
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"nvim-treesitter/nvim-treesitter-refactor", requires = "nvim-treesitter/nvim-treesitter"}
    use "tpope/vim-surround"

    -- Snippet
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"
    use "rafamadriz/friendly-snippets"

    -- Fuzzy Finder
    use {"nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim"}

    -- Colorscheme
    use {"dracula/vim", as = "dracula"}

    -- Icon
    use "kyazdani42/nvim-web-devicons"

    -- Utility
    use "famiu/bufdelete.nvim"
    use "jghauser/mkdir.nvim"
    use "tpope/vim-unimpaired"

    -- Neovim Lua Development
    use "nvim-lua/plenary.nvim"

    -- Statusline
    use {"NTBBloodbath/galaxyline.nvim", requires = "kyazdani42/nvim-web-devicons"}

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim"
    }
    use "tpope/vim-fugitive"

    -- Comment
    use "tpope/vim-commentary"

    -- Formatting
    use "mhartington/formatter.nvim"

    -- Session
    use "rmagatti/auto-session"

    -- Keybinding
    use "LionC/nest.nvim"

    -- Split and Window
    use "beauwilliams/focus.nvim"
  end
)
