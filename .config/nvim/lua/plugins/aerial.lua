return{
    {
        "stevearc/aerial.nvim",
        cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll", "AerialInfo", },
        dependencies = {
            "romus204/tree-sitter-manager.nvim",
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
