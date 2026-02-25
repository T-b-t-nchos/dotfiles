return {
    {
        "https://github.com/T-b-t-nchos/Aquavium.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local aquavium = require("Aquavium")

            aquavium.setup({
                -- bold = true,
                -- italic = true,
                -- transparent = true,
            })

            vim.cmd("colorscheme Aquavium")
        end,
    },
}
