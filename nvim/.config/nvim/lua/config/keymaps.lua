-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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
map("n", "<C-w>h", ":vsplit<CR>", { desc = "Open split left" })
map("n", "<C-w>j", ":split<CR>", { desc = "Open split down" })
map("n", "<C-w>k", ":split<CR>", { desc = "Open split up" })
map("n", "<C-w>l", ":vsplit<CR>", { desc = "Open split right" })

map("n", "<leader>w/", ":cd /<CR>", { desc = "Navigate to fs root" })
map("n", "<leader>w.", ":cd.. <CR>", { desc = "Navigate up a directory" })
map("n", "<leader>wc", ":cd ", { desc = "Navigate to directory" })
map("n", "<leader>wH", ":cd /Users/pvilim/hacks/pvilim<CR>", { desc = "Navigate to hacks" })
map("n", "<leader>wh", ":cd /Users/pvilim/<CR>", { desc = "Navigate to home" })
map("n", "<leader>wd", ":cd /Users/pvilim/client/desktop<CR>", { desc = "Navigate to desktop" })
map("n", "<leader>wr", ":cd /Users/pvilim/client/desktop/rust<CR>", { desc = "Navigate to rust" })
map("n", "<leader>wn", ":cd /Users/pvilim/client/desktop/rust/nucleus<CR>", { desc = "Navigate to nucleus" })
map("n", "<leader>ws", ":cd /Users/pvilim/server<CR>", { desc = "Navigate to server" })
map("n", "<leader>wg", ":cd /Users/pvilim/server/go<CR>", { desc = "Navigate to go" })
map("n", "<leader>wp", ":cd /Users/pvilim/server/configs/proto<CR>", { desc = "Navigate to protos" })
map("n", "<leader>wm", ":cd /Users/pvilim/server/metaserver/metaservlets<CR>", { desc = "Navigate to metaservlets" })
map(
  "n",
  "<leader>wi",
  ":cd /Users/pvilim/server/go/src/dropbox/devtools/image_builder<CR>",
  { desc = "Navigate to image_builder" }
)
map("n", "<leader>wj", ":cd /Users/pvilim/server/metaserver/static/js<CR>", { desc = "Navigate to js" })
map("n", ";", ":", { desc = "Map ; to :" })
map("n", "<c-t>", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<c-y>", ":Telescope cder<CR>", { desc = "Change working directory" })
map("n", "<c-b>", ":Telescope buffers<CR>", { desc = "Change buffer" })

map("n", "<leader>t", ":terminal<CR>", { desc = "Launch terminal" })
local terminal_group = vim.api.nvim_create_augroup("neovim_terminal", { clear = true })
vim.api.nvim_create_autocmd(
  "TermEnter",
  { pattern = "*", command = "setlocal nonumber norelativenumber", group = terminal_group }
)
vim.api.nvim_create_autocmd(
  "TermOpen",
  { pattern = "*", command = "setlocal nonumber norelativenumber", group = terminal_group }
)
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal signcolumn=no", group = terminal_group })
vim.api.nvim_create_autocmd(
  "TermClose",
  { pattern = "*", command = "setlocal number norelativenumber", group = terminal_group }
)
vim.api.nvim_create_autocmd("TermClose", { pattern = "*", command = "setlocal signcolumn=yes", group = terminal_group })
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert", group = terminal_group })
