return {
  {
    "Zane-/cder.nvim",
    config = function()
      local opts = {
        dir_command = { "fd", "--type=d", ".", vim.loop.cwd },
      }
      require("telescope").setup({
        extensions = {
          cder = opts,
        },
      })
      require("telescope").load_extension("cder")
    end,
  },
}
