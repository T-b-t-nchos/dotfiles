return {
    {
        "saghen/blink.cmp",

        version = "*",

        event = { "InsertEnter", "CmdLineEnter" },

        dependencies = {
            "asaghen/blink.compat",
            "ray-x/cmp-treesitter",

            "moyiz/blink-emoji.nvim",

            "L3MON4D3/LuaSnip",
        },

        opts = {
            keymap = {
                preset = "default",

                ["<Tab>"] = {
                    function(cmp)
                        if cmp.is_visible() then
                            return false
                        end

                        local ok, sm = pcall(
                            require,
                            "supermaven-nvim.completion_preview"
                        )

                        if ok and sm.has_suggestion() then
                            vim.schedule(function()
                                sm.on_accept_suggestion()
                            end)

                            return true
                        end

                        return false
                    end,

                    "select_next",
                    "fallback",
                },

                ["<S-Tab>"] = {
                    function(cmp)
                        if cmp.is_visible() then
                            cmp.select_prev()
                            return true
                        end

                        return false
                    end,

                    "fallback",
                },

                ["<C-Space>"] = {
                    "show",
                },

                ["<CR>"] = {
                    "accept",
                    "fallback",
                },
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = {
                    auto_show = true,
                },

                menu = {
                    max_height = 20,

                    draw = {
                        columns = {
                            --     { "kind_icon" },
                            --     { "label", "label_description", gap = 1 },
                            -- },
                            { "label", "label_description", gap = 2 },
                            { "kind_icon", gap = 1 },
                            { "kind" },
                        },
                    },
                },
            },

            signature = {
                enabled = true,
            },

            cmdline = {
                enabled = true,
                keymap = {
                    preset = "cmdline",
                },

                sources = {
                    "buffer",
                    "cmdline",
                },

                completion = {
                    list = {
                        selection = {
                            preselect = false,
                            auto_insert = true,
                        },
                    },
                    menu = {
                        auto_show = true,
                    },
                },
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "buffer",
                    "snippets",
                    "emoji",
                    "treesitter",
                },

                providers = {
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- Tune by preference
                        opts = {
                            insert = true, -- Insert emoji (default) or complete its name
                            ---@type string|table|fun():table
                            trigger = function()
                                return { ":" }
                            end,
                        },
                        should_show_items = function()
                            return vim.tbl_contains(
                                { "gitcommit", "markdown" },
                                vim.o.filetype
                            )
                        end,
                    },

                    treesitter = {
                        name = "Treesitter",
                        module = "blink.compat.source",
                    },
                },
            },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
        },
    },

    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,

        opts = {},
    }

}
