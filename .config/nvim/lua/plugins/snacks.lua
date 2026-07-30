return {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
        bigfile = {
            enabled = true,

            notify = true,
            size = 10 * 1024 * 1024, -- 10MB
            line_length = 5000,
        },
        bufdelete = {
            enabled = true,
        },
    },
}
