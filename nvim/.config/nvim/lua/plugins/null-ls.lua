return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      sources = {
        nls.builtins.formatting.lua_format,
        nls.builtins.formatting.gofmt,
        nls.builtins.formatting.rustfmt,
      }
      vim.cmd("map <Leader>F :lua vim.lsp.buf.format(Nil, 5000)<CR>")

      vim.api.nvim_create_autocmd(
        "BufWritePre",
        { pattern = "*", command = "undojoin | :lua vim.lsp.buf.format(Nil, 5000)" }
      )
    end,
  },
}
