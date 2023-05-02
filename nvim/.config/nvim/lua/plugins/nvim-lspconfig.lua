return {
    "neovim/nvim-lspconfig",
    init = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        -- change keymap since telescope disabled
        keys[#keys + 1] = {"gd", "<cmd>lua vim.lsp.buf.definition()<CR>"}
    end,
    opts = {
        servers = {
            gopls = {
                build = {
                    directoryFilters = {
                        "-", "+go/src/dropbox/desktop_trace_search"
                    }
                }
            }
        }
    }
}
