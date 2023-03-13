return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local colors = require("solarized.colors")
      local color_cmd1 = "highlight IndentBlanklineIndent1 guibg=" .. colors.bg .. " gui=nocombine"
      vim.cmd(color_cmd1)
      local color_cmd2 = "highlight IndentBlanklineIndent2 guibg=" .. colors.bg_alt .. " gui=nocombine"
      vim.cmd(color_cmd2)
      require("indent_blankline").setup({
        char = "",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        space_char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        show_trailing_blankline_indent = false,
      })
    end,
  },
}
