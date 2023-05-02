return {
    "ibhagwan/fzf-lua",
    keys = {
        {
            "<leader>ff",
            function() require("fzf-lua").files() end,
            desc = "Find Files"
        }, {
            "<leader>fb",
            function() require("fzf-lua").buffers() end,
            desc = "Open buffers"
        }, {
            "<leader>fl",
            function() require("fzf-lua").blines() end,
            desc = "lines in current buffer"
        }, {
            "<leader>fL",
            function() require("fzf-lua").lines() end,
            desc = "lines in all open buffers"
        },
        {"<leader>fs", function() require("fzf-lua").grep() end, desc = "grep"},
        {
            "<leader>/",
            function() require("fzf-lua").live_grep_native() end,
            desc = "live grep"
        }, {
            "<leader>fgs",
            function() require("fzf-lua").git_status() end,
            desc = "git status"
        }, {
            "<leader>fgc",
            function() require("fzf-lua").git_commits() end,
            desc = "git log"
        }, {
            "<leader>fgb",
            function() require("fzf-lua").git_bcommits() end,
            desc = "git log this buffer"
        }, {
            "<leader>fgB",
            function() require("fzf-lua").git_branches() end,
            desc = "git branches"
        }, {
            "<leader>fd",
            function() require("fzf-lua").lsp_document_symbols() end,
            desc = "lsp document symbols"
        }, {
            "<leader>fD",
            function() require("fzf-lua").diagnostics_workspace() end,
            desc = "lsp workspace diagnostics"
        }
    }
}
