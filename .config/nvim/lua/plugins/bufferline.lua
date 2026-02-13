return {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("bufferline").setup({
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Explorer",
                        text_align = "left",
                        separator = true,
                    },
                },
            },
        })
    end,
}
