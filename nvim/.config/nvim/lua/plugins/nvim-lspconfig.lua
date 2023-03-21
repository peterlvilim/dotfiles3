return {
    "neovim/nvim-lspconfig",
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
