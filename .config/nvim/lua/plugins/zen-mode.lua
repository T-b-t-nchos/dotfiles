return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
        window = {
            backdrop = 1.4
        },
        plugins = {
            options = {
                enabled = true,
                ruler = true,
                showcmd = true,
                -- laststatus = 3,
            },
            wezterm = {
                enabled = false,
                font = "+2",
            },
        },
    }
}
