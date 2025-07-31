-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- File navigation
    use {'nvim-telescope/telescope.nvim', tag = '0.1.4',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 'ThePrimeagen/harpoon' }
    use { 'mbbill/undotree' }

    -- Git integration
    use { 'tpope/vim-fugitive'}

    -- Syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }}

    -- LSP setup
    use {'williamboman/mason.nvim'}
    use {'williamboman/mason-lspconfig.nvim'}
    use {'neovim/nvim-lspconfig'}

    -- Autocompletion
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'saadparwaiz1/cmp_luasnip'}
    use {'L3MON4D3/LuaSnip'}
    -- Symbols for autocomplete window
    use {'onsails/lspkind.nvim'}
    -- Neovim lua LSP/completion -> need to move to lazydev.nvim
    use {'folke/neodev.nvim' }

    -- Obsidian plugin
    use {"epwalsh/obsidian.nvim",
        tag = "*",
        requires = { "nvim-lua/plenary.nvim" },
    }

    -- Color Themes
    use { 'NLKNguyen/papercolor-theme' }
    use { 'tiagovla/tokyodark.nvim' }
    use { 'sainnhe/gruvbox-material' }
    use { 'ribru17/bamboo.nvim' }
   -- use { 'comfysage/evergarden' }
    use { 'everviolet/nvim' }
    use { 'sainnhe/everforest' }
end)

