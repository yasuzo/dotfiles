-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "ts_ls",
        "eslint",
        "lua_ls",
        "gopls",
        "terraformls",
        "tflint",
        "ruff",
        "pyright",
        "yamlls",
        "svelte",
    },
})

-- Setup nvim-cmp capabilities
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities()
)

-- LSP keybindings on attach
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({
            count = 1
        })
        vim.schedule(function()
            vim.diagnostic.open_float()
        end)
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({
            count = -1
        })
        vim.schedule(function()
            vim.diagnostic.open_float()
        end)
    end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true
})

-- Default LSP config
local default_config = {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Lua LSP
vim.lsp.config.lua_ls = vim.tbl_deep_extend("force", default_config, {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
                globals = { "vim", "require" }
            }
        }
    }
})

-- YAML LSP
vim.lsp.config.yamlls = vim.tbl_deep_extend("force", default_config, {
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = { "*.yaml", "*.yml" }
            }
        }
    }
})

-- Python LSP (Ruff)
vim.lsp.config.ruff = vim.tbl_deep_extend("force", default_config, {
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
    end,
})

-- Python LSP (Pyright)
vim.lsp.config.pyright = vim.tbl_deep_extend("force", default_config, {
    capabilities = (function()
        local caps = vim.tbl_deep_extend("force", capabilities, {})
        caps.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
        return caps
    end)(),
    settings = {
        python = {
            analysis = {
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "warning",
                },
                typeCheckingMode = "basic",
            },
        },
    },
})

-- ESLint
vim.lsp.config.eslint = vim.tbl_deep_extend("force", default_config, {
    on_attach = function(client, bufnr)
        vim.notify(client.name)
        client.server_capabilities.documentFormattingProvider = true
        on_attach(client, bufnr)
    end,
})

-- TypeScript
vim.lsp.config.ts_ls = vim.tbl_deep_extend("force", default_config, {
    on_attach = function(client, bufnr)
        if client.name == "ts_ls" then
            client.server_capabilities.documentFormattingProvider = false
        end
        on_attach(client, bufnr)
    end,
})

-- Terraform
vim.lsp.config.terraformls = default_config
vim.lsp.config.tflint = default_config

-- Go
vim.lsp.config.gopls = default_config

-- Svelte
vim.lsp.config.svelte = default_config

-- Enable the LSP servers
vim.lsp.enable({ "lua_ls", "yamlls", "ruff", "pyright", "eslint", "ts_ls", "terraformls", "tflint", "gopls", "svelte" })
