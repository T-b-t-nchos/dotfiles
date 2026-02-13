return{
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = { "BufReadPre", "BufNewFile" },
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup()
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end,
    }
}
