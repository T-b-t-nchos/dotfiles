return {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    config = function()
        local ccc = require("ccc")

        ccc.setup({
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
            default_color = "#000000"
        })
    end
}
