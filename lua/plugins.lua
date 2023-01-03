-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

local packer = require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- nvim-treesitter/nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-tree/nvim-tree.lua',
        tag = 'nightly', --optional, updated every week
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }

    -- [LSP] mason: LSP servers, DAP servers, linters and formatters manager
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- [LSP] nvim-lspconfig Configurations for Nvim LSP
    use 'neovim/nvim-lspconfig'

    -- [Autocompletion] nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin

    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    -- nvim-ts-rainbow
    use 'p00f/nvim-ts-rainbow'

    -- alpha-vim
    use {
        'goolord/alpha-nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
            'BlakeJC94/alpha-nvim-fortune',
        },
    }

    -- nvim-lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- indent-blankline
    use 'lukas-reineke/indent-blankline.nvim'

    -- nvim-comment
    use 'terrortylor/nvim-comment'

    -- vim-startuptime
    use {
        'dstein64/vim-startuptime',
        opt = true,
        cmd = "StartupTime",
    }

    --#region git-integrated

    -- vim-fugitive(git operation)
    use 'tpope/vim-fugitive'

    -- gitsigns(git status)
    use 'lewis6991/gitsigns.nvim'

    --#endregion

    --#region colorscheme

    -- colorscheme gruvbox
    use 'ellisonleao/gruvbox.nvim'

    -- colorscheme tokyonight
    use 'folke/tokyonight.nvim'

    --#endregion

end)

require('plugin/nvim_treesitter')
require('plugin/indent_blankline')
require('plugin/nvim_comment')
require('plugin/nvim_tree')
require('plugin/telescope')
require('plugin/alpha')
require('plugin/gitsigns')

-- set up servers via lspconfig
require('plugin/lspconfig')
require('plugin/lualine')

return packer
