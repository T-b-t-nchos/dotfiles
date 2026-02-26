return {
    {
        "T-b-t-nchos/Aquavium.nvim",
        name = "Aquavium",
        lazy = false,
        priority = 1000,
        config = function()
            if not vim.g.colors_name then
                vim.cmd("colorscheme Aquavium")
            end
        end,
    },
    {
        dir = vim.fn.expand("~/source/repos/Aquavium.nvim"),
        name = "Aquavium-dev",
        lazy = true,
    },
}
