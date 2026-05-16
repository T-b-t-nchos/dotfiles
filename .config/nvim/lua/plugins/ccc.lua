return {
    "uga-rosa/ccc.nvim",
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        local ccc = require("ccc")

        ccc.setup({
            highlighter = {
                auto_enable = false,
            },
        })
    end
}
