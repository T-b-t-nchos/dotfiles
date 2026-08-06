return {
    "mikavilpas/yazi.nvim",
    version = "*",
    -- event = "VeryLazy",
    cmd = { "Yazi" },
    keys = {
        { "<leader>yz", "<cmd>Yazi<cr>", desc = "Yazi" },
        { "<leader>yZ", "<cmd>Yazi cwd<cr>", desc = "Yazi in nvim's working directory" },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
}
