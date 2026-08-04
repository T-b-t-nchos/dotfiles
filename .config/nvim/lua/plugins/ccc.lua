return {
    "uga-rosa/ccc.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
        { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color CccPick" },
    },

    config = function()
        local ccc = require("ccc")

        ccc.setup({
            highlighter = {
                auto_enable = false,
            },
        })
    end
}
