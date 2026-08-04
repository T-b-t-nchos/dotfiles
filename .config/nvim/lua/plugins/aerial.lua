return{
    {
        "stevearc/aerial.nvim",
        cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll", "AerialInfo", },
        keys = {
            { "<leader>xa", "<cmd>AerialToggle<CR>", desc = "Outline Window" },
            { "<C-{>", "<cmd>AerialPrev<CR>", desc = "Previous Symbol" },
            { "<C-}>", "<cmd>AerialNext<CR>", desc = "Next Symbol" },
        },
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
