-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins
require("lazy").setup({
    "lukas-reineke/indent-blankline.nvim",

    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    "smartpde/telescope-recent-files",

    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
    },

    'mbbill/undotree',
    'folke/trouble.nvim',

    -- LSP Support
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            'williamboman/mason-lspconfig.nvim',
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
    },

    'Mofiqul/dracula.nvim',

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },

    {
        "okuuva/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                trigger_events = {
                    immediate_save = { "BufLeave", "FocusLost" },
                    defer_save = { "InsertLeave" },
                    cancel_deferred_save = { "InsertEnter" }
                },
                debounce_delay = 500
            }
        end,
    },

    'm4xshen/autoclose.nvim',
    'mfussenegger/nvim-dap',
})
