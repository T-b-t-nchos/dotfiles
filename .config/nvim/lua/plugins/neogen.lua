return {
    "danymat/neogen",
    module = "neogen",
    cmd = "Neogen",
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
