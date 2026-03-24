-- Setup treesitter (optional, using defaults)
require('nvim-treesitter').setup {
}

-- Install parsers
require('nvim-treesitter').install({ "typescript", "go", "python", "toml", "yaml", "json", "c", "lua", "vim", "vimdoc",
    "query", "terraform", "svelte" })

-- Enable highlighting for common filetypes
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'typescript', 'javascript', 'go', 'python', 'toml', 'yaml', 'json', 'c', 'lua', 'vim', 'terraform', 'svelte' },
    callback = function()
        vim.treesitter.start()
    end,
})
