return{
  "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
        vim.cmd("hi DashboardHeader gui=bold cterm=bold")

        require("dashboard").setup({
            theme = "hyper",
            config = {
                header = {
                    "",
                    "---------------------------------------------------------",
                    "_____   __                ___    ______            ",
                    "___  | / /__________      __ |  / /__(_)______ ___ ",
                    "__   |/ /_  _ \\  __ \\     __ | / /__  /__  __ `__ \\",
                    "_  /|  / /  __/ /_/ /     __ |/ / _  / _  / / / / /",
                    "/_/ |_/  \\___/\\____/      _____/  /_/  /_/ /_/ /_/ ",
                    "",
                    "--------------------------------------- Neo - Vi IMproved",
                    ""
                },
                header_hl = "DashboardHeader",

                --packages = { enable = false },

                shortcut = {
                    { desc = ' New File', group = 'String', action = 'enew', key = 'n'},
                    { desc = ' Recent Files', group = 'Keyword', action = 'Telescope oldfiles', key = 'r' },
                    { desc = '󰊳 Lazy-nvim Update', group = 'Character', action = 'Lazy update', key = 'u' },
                },

                mru = { enable = false },

                footer = function ()
                    local v = vim.version()
                     return {
                        "",
                        string.format(
                            " Neovim v%d.%d.%d",
                            v.major, v.minor, v.patch
                        ),
                    }
                end,
            },
        })
    end,
}
