return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {theme = 'solarized_dark'},
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {{'filename', path = 1}}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {{'filename', path = 1}}
            }
        }
    }
}
