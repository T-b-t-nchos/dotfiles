return {
    "danymat/neogen",
    module = "neogen",
    cmd = "Neogen",
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
