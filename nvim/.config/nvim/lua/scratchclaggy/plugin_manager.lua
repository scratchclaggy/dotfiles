local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local update_treesitter = function()
    pcall(require("nvim-treesitter.install").update({ with_sync = true }))
end

require("packer").startup(function(use)
    use("beauwilliams/focus.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })
    use("folke/todo-comments.nvim")
    use("folke/trouble.nvim")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/vim-vsnip-integ")
    use("jghauser/mkdir.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("jose-elias-alvarez/null-ls.nvim")
    use("kkharji/lspsaga.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("kylechui/nvim-surround")
    use("lewis6991/gitsigns.nvim")
    use("LionC/nest.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("neovim/nvim-lspconfig")
    use("norcalli/nvim-colorizer.lua")
    use("numToStr/Comment.nvim")
    use("nvim-lualine/lualine.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = update_treesitter })
    use("nvim-treesitter/nvim-treesitter-refactor")
    use("rafamadriz/friendly-snippets")
    use("rmagatti/auto-session")
    use("simrat39/rust-tools.nvim")
    use("svermeulen/vim-cutlass")
    use("svermeulen/vim-subversive")
    use("svermeulen/vim-yoink")
    use("TimUntersberger/neogit")
    use("tpope/vim-eunuch")
    use("tpope/vim-sleuth")
    use("tpope/vim-unimpaired")
    use("wbthomason/packer.nvim")
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("j-hui/fidget.nvim")
    use("folke/neodev.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
    use("olimorris/persisted.nvim")
    use("jay-babu/mason-null-ls.nvim")
    use("delphinus/vim-firestore")

    if packer_bootstrap then
        require("packer").sync()
    end
end)

if packer_bootstrap then
    print("==================================")
    print("    Plugins are being installed")
    print("    Wait until Packer completes,")
    print("       then restart nvim")
    print("==================================")
    return
end
