return {
  "folke/which-key.nvim",
  event = "UIEnter",
  config = function()
    require("which-key").setup({
      win = {
        border = "rounded",
      },
    })

    local wk = require("which-key")
  end,
}

