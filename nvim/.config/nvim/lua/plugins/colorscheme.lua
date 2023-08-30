return {
    {"peterlvilim/solarized.nvim"}, {
        "peterlvilim/solarized.nvim",
        lazy = false,
        config = function()
            vim.cmd("set background=dark")
            vim.g.solarized_borders = true
            require("solarized").set()
        end
    }
}
