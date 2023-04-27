local cmp = require("cmp")
return {
    {
        "hrsh7th/nvim-cmp",
        opts = {
            mapping = cmp.mapping.preset.insert({
                ["<C-f>"] = cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Insert
                }),
                ["<C-u>"] = cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Insert
                }),
                ["<C-l>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            })
        }
    }
}
