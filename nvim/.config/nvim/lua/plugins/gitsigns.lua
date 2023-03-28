vim.g["git_base"] = "HEAD"
function toggle_base(new_base)
    vim.g["git_base"] = new_base
    require("gitsigns").change_base(vim.g["git_base"], true)
end

return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {update_debounce = 10000},
        keys = {

            {
                "<leader>gM",
                ":lua toggle_base('origin/' .. vim.g.gitsigns_head)<CR>:lua toggle_neo_tree(false, nil)<CR>",
                "Git sign diff vs origin/master"
            }, {
                "<leader>gH",
                ":lua toggle_base('HEAD')<CR>:lua toggle_neo_tree(false, nil)<CR>",
                "Git sign diff vs HEAD"
            }
        }
    }
}
