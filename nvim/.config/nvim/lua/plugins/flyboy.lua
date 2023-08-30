return {
  "CamdenClark/flyboy",
  config = function()
    require('flyboy.config').setup({
      model = "gpt-4"
    })
  end,
  dependencies = { { "nvim-lua/plenary.nvim" } }
}
