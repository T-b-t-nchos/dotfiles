return {
    "kevalin/mermaid.nvim",
    ft = { "markdown", "mermaid" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("mermaid").setup()
    end,
}
