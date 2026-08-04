return {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
    keys = {
        { "<leader>cm", "<cmd>Huefy<cr>", desc = "Minty/Huefy" },
        { "<leader>cM", "<cmd>Shades<cr>", desc = "Minty/Shades" },
    },

    dependencies = { "nvzone/volt" },
}
