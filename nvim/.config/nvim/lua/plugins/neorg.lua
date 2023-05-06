return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.keybinds"] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = "<Leader><Leader>"
                }
            }, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {workspaces = {notes = "~/notes"}}
            }
        }
    },
    dependencies = {{"nvim-lua/plenary.nvim"}}
}
