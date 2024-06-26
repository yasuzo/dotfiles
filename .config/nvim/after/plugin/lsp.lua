local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset("recommended")

lsp.ensure_installed({
    "tsserver",
    "eslint",
    "lua_ls",
    "gopls",
    "terraformls",
    "tflint",
    "ruff_lsp",
    "pyright",
    "yamlls",
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
                globals = {
                    "vim",
                    "require"
                }
            }
        }
    }
}

lspconfig.yamlls.setup {
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = { "*.yaml", "*.yml" }
            }
        }
    }
}

lspconfig.ruff_lsp.setup {
    on_attach = function(client, _) client.server_capabilities.hoverProvider = false end
}
lspconfig.pyright.setup {
    capabilities = (function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
        return capabilities
    end)(),
    settings = {
        python = {
            analysis = {
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "warning", -- or anything
                },
                typeCheckingMode = "basic",
            },
        },
    },
}

lspconfig.eslint.setup {
    on_attach = function(client, _)
        vim.notify(client.name)
        client.server_capabilities.documentFormattingProvider = true
    end
}

lspconfig.tsserver.setup {
    on_attach = function(client, _)
        if client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        end
    end
}

lspconfig.terraformls.setup {}

lspconfig.tflint.setup {}

lspconfig.gopls.setup {

}
