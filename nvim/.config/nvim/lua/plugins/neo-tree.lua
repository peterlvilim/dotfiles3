return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function()
      filesystem = {
        bind_to_cwd = true,
      }
      local command = require("neo-tree.command")
      vim.g["neo_tree_source"] = "fileystem"
      function toggle_neo_tree(toggle, source)
        vim.g["neo_tree_source"] = source

        command.execute({
          toggle = toggle,
          action = "show",
          source = vim.g["neo_tree_source"],
          git_base = vim.g["git_base"],
        })
      end

      vim.keymap.set("n", "<leader>e", ":lua toggle_neo_tree(true, 'filesystem')<CR>", { desc = "Open file viewer" })
      vim.keymap.set("n", "<leader>E", ":lua toggle_neo_tree(true, 'git_status')<CR>", { desc = "Open file viewer" })
    end,
  },
}
