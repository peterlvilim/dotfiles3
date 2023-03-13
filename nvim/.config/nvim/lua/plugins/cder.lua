return {
  { "Zane-/cder.nvim" },
  {
    "LazyVim/LazyVim",
    config = function()
      require("telescope").load_extension("cder")
    end,
  },
}
