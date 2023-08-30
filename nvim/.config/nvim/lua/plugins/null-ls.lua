local function return_root()
  if string.find(vim.api.nvim_buf_get_name(0), "desktop") then
    return "/Users/pvilim/client/desktop"
  else
    return ""
  end
end

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")

      return {
        debug = true,
        sources = {
          nls.builtins.formatting.lua_format,
          nls.builtins.formatting.prettier.with({
            filetypes = {
              "css",
              "javascript",
              "typescript",
              "typescriptreact",
            }
          }),
          nls.builtins.formatting.gofmt,
          nls.builtins.formatting.rustfmt.with({
            cwd = return_root,
            args = { "--edition=2018" }
          }), nls.builtins.formatting.protolint
        }
      }
    end
  }
}
