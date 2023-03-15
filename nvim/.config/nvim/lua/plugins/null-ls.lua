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
      vim.cmd("map <Leader>Ff :lua vim.lsp.buf.format(Nil, 5000)<CR>")

      local format_id = nil
      function toggle_auto_format()
        if format_id == nil then
          format_id = vim.api.nvim_create_autocmd(
            "BufWritePre",
            { pattern = "*", command = "undojoin | :lua vim.lsp.buf.format(Nil, 5000)" }
          )
          print("Autoformat enabled")
        else
          vim.api.nvim_del_autocmd(format_id)
          format_id = nil
          print("Autoformat disabled")
        end
      end

      toggle_auto_format()
      vim.cmd("map <Leader>FF :lua toggle_auto_format()<CR>")
    end,
  },
}
