return{
    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("aerial").setup({
            layout = {
                default_direction = "right",
                placement = "edge",
            },
            backends = { "lsp", "treesitter" },
            show_guides = true,
            filter_kind = false,
            })
        end,
    }
}
