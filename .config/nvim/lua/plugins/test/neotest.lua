return{
    "nvim-neotest/neotest",
    --event = "VeryLazy",
    cmd = { "Neotest", "NeotestRun", "NeotestSummary" },
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        --adapters
        "Issafalcon/neotest-dotnet",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-dotnet")
            }
        })
    end,
}

