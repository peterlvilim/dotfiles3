return {
  { "peterlvilim/solarized.nvim" },
  {
    "peterlvilim/solarized.nvim",
    lazy = false,
    config = function()
      vim.cmd("set background=dark")
      require("solarized").set()
    end,
  },
}
