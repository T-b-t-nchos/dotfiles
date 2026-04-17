return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                cmdline = {
                    enabled = true,
                    view = "cmdline",
                },
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = false,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                },

                views = {
                    cmdline_popup = {
                        position = {
                            row = "40%",
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                        border = {
                            style = "rounded",
                        },
                        win_options = {
                            winblend = 0,
                        },
                    },
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
}
