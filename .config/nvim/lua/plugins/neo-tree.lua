return{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },

    event = "UIEnter",

    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            sources = {
                "filesystem",
                "buffers",
                "git_status",
            },
            source_selector = {
                winbar = true,
                statusline = false,
                content_layout = "center",
                tabs_layout = "equal",
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                hijack_netrw_behavior = "open_default",

                open_on_setup = false,
                open_on_setup_file = false,

                filtered_items = {
                    visible = false,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,

                    hide_hidden = false,
                    hide_by_name = {},
                    never_show = {},
                },
            },
        })
    end,
}
