-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {"smartpde/telescope-recent-files"}

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('mbbill/undotree')
    use('folke/trouble.nvim')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        },
    }
    use('Mofiqul/dracula.nvim')
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use({
        "okuuva/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                trigger_events = {
                    immediate_save = { "BufLeave", "FocusLost", "InsertLeave", "TextChanged" },
                    defer_save = { "CursorHoldI" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                    cancel_defered_save = { "TextChangedI" }
                },
                debounce_delay = 1350 -- saves the file at most every `debounce_delay` milliseconds
            }
        end,
    })

    use 'm4xshen/autoclose.nvim'
    use 'mfussenegger/nvim-dap'
end)
