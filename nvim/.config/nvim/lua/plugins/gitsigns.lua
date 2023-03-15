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
      function toggle_base(new_base)
        vim.g["git_base"] = new_base
        require("gitsigns").change_base(vim.g["git_base"], true)
      end

      map(
        "n",
        "<leader>gM",
        ":lua toggle_base('origin/master')<CR>:lua toggle_file_viewer(false)<CR>",
        { desc = "Git sign diff vs origin/master" }
      )
      map(
        "n",
        "<leader>gH",
        ":lua toggle_base('HEAD')<CR>:lua toggle_file_viewer(false)<CR>",
        { desc = "Git sign diff vs HEAD" }
      )
    end,
  },
}
