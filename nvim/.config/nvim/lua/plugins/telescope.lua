local Util = require("lazyvim.util")
local actions = require("telescope.actions")

return {
    "telescope.nvim",
    keys = {
        {"<c-t>", Util.telescope("files", {cwd = false}), "Find Files (cwd)"},
        {
            "<c-b>", "<cmd>Telescope buffers show_all_buffers=true<cr>",
            "Switch Buffer"
        }, {"<leader>ff", false}, {"<leader>fb", false}
    },
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<c-j>"] = function(...)
                        return actions.move_selection_next(...)
                    end,
                    ["<c-k>"] = function(...)
                        return actions.move_selection_previous(...)
                    end
                }
            }
        }
    },
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function() require("telescope").load_extension("fzf") end
    }
}
