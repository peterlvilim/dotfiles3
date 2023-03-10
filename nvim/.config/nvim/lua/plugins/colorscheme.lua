return {
  -- add gruvbox
  { "shaunsingh/solarized.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "shaunsingh/solarized.nvim",
    opts = {
      colorscheme = require("solarized").set(),
    },
  },
}
