return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function ()
        require("notify").setup({
            background_colour = "#000000",
            stages = "fade",
            timeout = 3000,
            top_down = false,
        })
    end,
}
