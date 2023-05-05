return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            additional_vim_regex_highlighting = {'org'},
            ensure_installed = {"org", "rust"}
        }
    }
}
