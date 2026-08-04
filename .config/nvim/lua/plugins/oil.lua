return{
    {
        'stevearc/oil.nvim',
        --event = "VeryLazy",
        cmd = "Oil",
        keys = {
            { "<leader>.", "<cmd>Oil<cr>", desc = "Open Oil" },
        },
        opts = {},
        dependencies = { "nvim-mini/mini.icons" },
        --lazy = false,
    }
}
