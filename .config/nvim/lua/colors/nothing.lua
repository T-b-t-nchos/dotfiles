return {
    {
        "T-b-t-nchos/nothing.nvim",
        dev = false,
        name = "nothing.nvim",
        lazy = true,
        config = function()
            require("nothing").setup({
                mode = "dark",
            })
        end,
    },
}
