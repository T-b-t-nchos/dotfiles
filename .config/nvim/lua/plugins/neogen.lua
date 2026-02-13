return {
    "danymat/neogen",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
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
