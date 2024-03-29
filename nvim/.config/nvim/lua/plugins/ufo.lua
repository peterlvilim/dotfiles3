return {
    {"kevinhwang91/nvim-ufo"}, {"kevinhwang91/promise-async"}, {
        "LazyVim/LazyVim",
        dependences = {"kevinhwang91/promise-async"},
        keys = {
            {'zR', ":lua require('ufo').openAllFolds()<CR>", "Open all folds"},
            {'zM', ":lua require('ufo').closeAllFolds()<CR>", "Close all folds"}
        },
        opts = function(_, opts)
            vim.o.foldcolumn = '0'
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
            local language_servers = require("lspconfig").util
                                         .available_servers() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require('lspconfig')[ls].setup({
                    capabilities = capabilities
                    -- you can add other fields for setting up lsp server in this table
                })
            end
            require('ufo').setup()
        end
    }
}
