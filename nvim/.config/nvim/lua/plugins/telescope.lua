local Util = require("lazyvim.util")

return {
  "telescope.nvim",
  keys = {
    { "<c-t>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<c-b>", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
  },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
