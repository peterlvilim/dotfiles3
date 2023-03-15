return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function()
      filesystem = {
        bind_to_cwd = true,
      }
      local command = require("neo-tree.command")
      function toggle_file_viewer()
        command.execute({ toggle = true, action = "show", source = "filesystem", git_base = vim.g["git_base"] })
      end

      vim.keymap.set("n", "<leader>e", ":lua toggle_file_viewer()<CR>", { desc = "Open file viewer" })
    end,
  },
}
