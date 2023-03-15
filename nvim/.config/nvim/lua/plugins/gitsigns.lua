local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      -- Default to HEAD
      vim.g["git_base"] = "HEAD"
      map(
        "n",
        "<leader>gM",
        ":lua require('gitsigns').change_base(vim.g['git_base'], true)<CR>",
        { desc = "Git sign diff vs origin/master" }
      )
      map(
        "n",
        "<leader>gH",
        ":lua require('gitsigns').change_base(vim.g['git_base'], true)<CR>",
        { desc = "Git sign diff vs HEAD" }
      )
    end,
  },
}
