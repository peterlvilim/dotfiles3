local command = require("neo-tree.command")
vim.g["neo_tree_source"] = "fileystem"
function toggle_neo_tree(toggle, source)
    if source ~= nil then vim.g["neo_tree_source"] = source end

    command.execute({
        toggle = toggle,
        action = "show",
        source = vim.g["neo_tree_source"],
        git_base = vim.g["git_base"]
    })
end

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dir = "/Users/pvilim/neo-tree.nvim/",
        keys = {
            {
                "<leader>ff", ":lua toggle_neo_tree(true, 'filesystem')<CR>",
                "Toggle file viewer"
            }, {
                "<leader>fg", ":lua toggle_neo_tree(true, 'git_status')<CR>",
                "Toggle git viewer"
            },
            {
                "<leader>fb", ":lua toggle_neo_tree(true, 'buffers')<CR>",
                "Toggle buffers"
            }
        },
        opts = function()
            return {
                filesystem = {bind_to_cwd = true, follow_current_file = true},
                buffer = {bind_to_cwd = true},
                git_status = {bind_to_cwd = true}
            }
        end
    }
}
