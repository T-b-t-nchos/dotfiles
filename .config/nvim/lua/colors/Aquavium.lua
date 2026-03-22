return{
    {
        "T-b-t-nchos/Aquavium.nvim",
        dev = false,
        name = "Aquavium.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            if not vim.g.colors_name then
                vim.cmd("colorscheme Aquavium")
            end
        end,
    },
}
