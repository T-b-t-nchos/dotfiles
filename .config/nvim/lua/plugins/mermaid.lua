return {
    "kevalin/mermaid.nvim",
    ft = { "markdown", "mermaid" },
    dependencies = { "romus204/tree-sitter-manager.nvim" },
    config = function()
        require("mermaid").setup()
    end,
}
