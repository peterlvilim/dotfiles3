-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({lhs, mode = mode}).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end
map("i", "<CapsLock>", "<Esc>", {desc = "caps to esc"})

map("n", "<C-w>h", ":vsplit<CR>", {desc = "Open split left"})
map("n", "<C-w>j", ":split<CR>", {desc = "Open split down"})
map("n", "<C-w>k", ":split<CR>", {desc = "Open split up"})
map("n", "<C-w>l", ":vsplit<CR>", {desc = "Open split right"})

map("n", "<leader>w/", ":tcd /<CR>", {desc = "Navigate to fs root"})
map("n", "<leader>w.", ":tcd.. <CR>", {desc = "Navigate up a directory"})
map("n", "<leader>wc", ":tcd ", {desc = "Navigate to directory"})
map("n", "<leader>wh", ":tcd /Users/pvilim/hacks/pvilim<CR>",
    {desc = "Navigate to hacks"})
map("n", "<leader>wH", ":tcd /Users/pvilim/<CR>", {desc = "Navigate to home"})
map("n", "<leader>wd", ":tcd /Users/pvilim/client/desktop<CR>",
    {desc = "Navigate to desktop"})
map("n", "<leader>wr", ":tcd /Users/pvilim/client/desktop/rust<CR>",
    {desc = "Navigate to rust"})
map("n", "<leader>wn", ":tcd /Users/pvilim/client/desktop/rust/nucleus<CR>",
    {desc = "Navigate to nucleus"})
map("n", "<leader>ws", ":tcd /Users/pvilim/server<CR>",
    {desc = "Navigate to server"})
map("n", "<leader>wg", ":tcd /Users/pvilim/server/go<CR>",
    {desc = "Navigate to go"})
map("n", "<leader>wp", ":tcd /Users/pvilim/server/configs/proto<CR>",
    {desc = "Navigate to protos"})
map("n", "<leader>wm", ":tcd /Users/pvilim/server/metaserver/metaservlets<CR>",
    {desc = "Navigate to metaservlets"})
map("n", "<leader>wi",
    ":tcd /Users/pvilim/server/go/src/dropbox/devtools/image_builder<CR>",
    {desc = "Navigate to image_builder"})
map("n", "<leader>wj", ":tcd /Users/pvilim/server/metaserver/static/js<CR>",
    {desc = "Navigate to js"})
map("n", "<leader>wt",
    ":tcd /Users/pvilim/server/go/src/dropbox/desktop_trace_search/<CR>",
    {desc = "Navigate to desktop_trace_search"})
map("n", "<leader>wC", ":tcd /Users/pvilim/.config<CR>",
    {desc = "Navigate to config"})

map("n", ";", ":", {desc = "Map ; to :"})

map("n", "<c-t>", ":tabprev<CR>", {desc = "Previous tab"})
map("n", "<c-y>", ":tabnext<CR>", {desc = "Next tab"})
map("t", "<c-t>", [[<C-\><C-n>:tabprev<CR>]], {desc = "Previous tab"})
map("t", "<c-y>", [[<C-\><C-n>:tabnext<CR>]], {desc = "Next tab"})
map("n", "<leader>sT", ":Telescope find_files<CR>", {desc = "Find files"})
map("n", "<leader>sY", ":Telescope cder<CR>",
    {desc = "Change working directory"})
map("n", "<c-b>", ":Telescope buffers<CR>", {desc = "Change buffer"})

map("n", "<leader>t", ":terminal<CR>", {desc = "Launch terminal"})
local terminal_group = vim.api.nvim_create_augroup("neovim_terminal",
                                                   {clear = true})
vim.api.nvim_create_autocmd("TermEnter", {
    pattern = "*",
    command = "setlocal nonumber norelativenumber",
    group = terminal_group
})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    command = "startinsert",
    group = terminal_group
})
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "setlocal nonumber norelativenumber",
    group = terminal_group
})
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "setlocal signcolumn=no",
    group = terminal_group
})
vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*",
    command = "setlocal number norelativenumber",
    group = terminal_group
})
vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*",
    command = "setlocal signcolumn=yes",
    group = terminal_group
})
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
    group = terminal_group
})

map("n", "<leader>gM",
    ":lua require('gitsigns').change_base('origin/master', true)<CR>",
    {desc = "Git sign diff vs origin/master"})
map("n", "<leader>gH", ":lua require('gitsigns').change_base('HEAD', true)<CR>",
    {desc = "Git sign diff vs HEAD"})

map("n", "<c-e>", ":Neotree source=git_status<CR>", {desc = "Find files"})

map("t", "<Esc>", [[<C-\><C-n>]], {desc = "Exit terminal mode"})
map("t", "<C-j>", [[<C-\><C-n>:wincmd j<CR>]],
    {desc = "Move down but stay terminal mode"})
map("t", "<C-k>", [[<C-\><C-n>:wincmd k<CR>]],
    {desc = "Move up but stay terminal mode"})
map("t", "<C-h>", [[<C-\><C-n>:wincmd h<CR>]],
    {desc = "Move left but stay terminal mode"})
map("t", "<C-l>", [[<C-\><C-n>:wincmd l<CR>]],
    {desc = "Move right but stay terminal mode"})
map("t", "<C-u>", [[<C-\><C-n><C-u>]],
    {desc = "scroll up by a page in terminal"})
map("t", "<C-f>", [[<C-\><C-n><C-f>]],
    {desc = "scroll down by a page in terminal"})

map("n", "<leader>/", ":Telescope live_grep<CR>", {desc = "Live grep pwd"})
