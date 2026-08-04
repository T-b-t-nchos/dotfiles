return {
    "danymat/neogen",
    module = "neogen",
    cmd = "Neogen",
    keys = {
        {
            "<leader>d",
            function()
                require("neogen").generate()
            end,
            desc = "Generate Doc Comment",
        },
    },
    dependencies = "romus204/tree-sitter-manager.nvim",
    opts = {
        snippet_engine = "luasnip",
        languages = {
            cs = {
                template = {
                    annotation_convention = "xmldoc",
                },
            },
        },
    },
}
