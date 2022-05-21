-- Bootstrap Packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

return require("packer").startup(function()
	-- Plugin Manager
	use("wbthomason/packer.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" })

	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")

	-- Syntax
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/nvim-treesitter-refactor", requires = "nvim-treesitter/nvim-treesitter" })
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("tpope/vim-surround")

	-- Snippet
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/vim-vsnip-integ")
	use("rafamadriz/friendly-snippets")

	-- Fuzzy Finder

	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Color
	use("norcalli/nvim-colorizer.lua")

	-- Colorscheme
	use({ "dracula/vim", as = "dracula" })
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Icon
	use("kyazdani42/nvim-web-devicons")

	-- Utility
	use("jghauser/mkdir.nvim")
	use("tpope/vim-eunuch")
	use("tpope/vim-unimpaired")

	-- Neovim Lua Development
	use("nvim-lua/plenary.nvim")

	-- Statusline
	use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })

	-- Indent
	use("lukas-reineke/indent-blankline.nvim")

	-- Git
	use({ "tpope/vim-fugitive" })
	use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

	-- Comment
	use("numToStr/Comment.nvim")
	use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Session
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- Session
	use("rmagatti/auto-session")

	-- Keybinding
	use("LionC/nest.nvim")
	use("svermeulen/vim-cutlass")
	use("svermeulen/vim-yoink")
	use("svermeulen/vim-subversive")

	-- Split and Window
	use("beauwilliams/focus.nvim")
end)
