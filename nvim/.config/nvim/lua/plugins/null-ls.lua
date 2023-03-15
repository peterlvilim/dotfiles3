return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function()
            local nls = require("null-ls")

            return {
                sources = {
                    nls.builtins.formatting.lua_format,
                    nls.builtins.formatting.gofmt,
                    nls.builtins.formatting.rustfmt,
                    nls.builtins.formatting.protolint
                }
            }
        end
    }
}
