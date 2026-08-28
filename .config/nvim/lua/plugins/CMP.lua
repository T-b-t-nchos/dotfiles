return {
    {
        "saghen/blink.cmp",

        version = "*",

        event = { "InsertEnter", "CmdLineEnter" },

        dependencies = {
            "asaghen/blink.compat",
            "ray-x/cmp-treesitter",

            "moyiz/blink-emoji.nvim",
            'Kaiser-Yang/blink-cmp-git',
            "erooke/blink-cmp-latex",
            "giuxtaposition/blink-cmp-copilot",

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

                ["<C-@>"] = {
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

                    window = {
                        border = "single",
                        max_width = 80,
                        max_height = 20,
                    },
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
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
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
                    "path",
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
                    "git",
                    "latex",
                    "copilot",
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
                                { "gitcommit", "markdown", "text" },
                                vim.o.filetype
                            )
                        end,
                    },

                    treesitter = {
                        name = "Treesitter",
                        module = "blink.compat.source",
                    },

                    git = {
                        name = 'Git',
                        module = 'blink-cmp-git',
                        -- only enable this source when filetype is gitcommit, markdown, or 'octo'
                        enabled = function()
                            return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
                        end,
                        --- @module 'blink-cmp-git'
                        --- @type blink-cmp-git.Options
                        opts = {
                            commit = {
                                triggers = { ':', '@', '#', '!' },
                            },
                            git_centers = {
                                github = {

                                },
                                gitlab = {

                                }
                            }
                        }
                    },
                    latex = {
                        name = "Latex",
                        module = "blink-cmp-latex",
                        opts = {
                            insert_command = false
                        },
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
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
    },

    {
        "xzbdmw/colorful-menu.nvim",
        config = function()
            -- You don't need to set these options.
            require("colorful-menu").setup({
                ls = {
                    lua_ls = {
                        -- Maybe you want to dim arguments a bit.
                        arguments_hl = "@comment",
                    },
                    gopls = {
                        -- By default, we render variable/function's type in the right most side,
                        -- to make them not to crowd together with the original label.

                        -- when true:
                        -- foo             *Foo
                        -- ast         "go/ast"

                        -- when false:
                        -- foo *Foo
                        -- ast "go/ast"
                        align_type_to_right = true,
                        -- When true, label for field and variable will format like "foo: Foo"
                        -- instead of go's original syntax "foo Foo". If align_type_to_right is
                        -- true, this option has no effect.
                        add_colon_before_type = false,
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                        preserve_type_when_truncate = true,
                    },
                    -- for lsp_config or typescript-tools
                    ts_ls = {
                        -- false means do not include any extra info,
                        -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                        extra_info_hl = "@comment",
                    },
                    vtsls = {
                        -- false means do not include any extra info,
                        -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                        extra_info_hl = "@comment",
                    },
                    ["rust-analyzer"] = {
                        -- Such as (as Iterator), (use std::io).
                        extra_info_hl = "@comment",
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                        preserve_type_when_truncate = true,
                    },
                    clangd = {
                        -- Such as "From <stdio.h>".
                        extra_info_hl = "@comment",
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                        -- the hl group of leading dot of "•std::filesystem::permissions(..)"
                        import_dot_hl = "@comment",
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                        preserve_type_when_truncate = true,
                    },
                    zls = {
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                    },
                    roslyn = {
                        extra_info_hl = "@comment",
                    },
                    dartls = {
                        extra_info_hl = "@comment",
                    },
                    -- The same applies to pyright/pylance
                    basedpyright = {
                        -- It is usually import path such as "os"
                        extra_info_hl = "@comment",
                    },
                    pylsp = {
                        extra_info_hl = "@comment",
                        -- Dim the function argument area, which is the main
                        -- difference with pyright.
                        arguments_hl = "@comment",
                    },
                    -- If true, try to highlight "not supported" languages.
                    fallback = true,
                    -- this will be applied to label description for unsupport languages
                    fallback_extra_info_hl = "@comment",
                },
                -- If the built-in logic fails to find a suitable highlight group for a label,
                -- this highlight is applied to the label.
                fallback_highlight = "@variable",
                -- If provided, the plugin truncates the final displayed text to
                -- this width (measured in display cells). Any highlights that extend
                -- beyond the truncation point are ignored. When set to a float
                -- between 0 and 1, it'll be treated as percentage of the width of
                -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
                -- Default 60.
                max_width = 60,
            })
        end,
    },
    {
        "giuxtaposition/blink-cmp-copilot",
        dependencies = { "copilot.lua" },
    }
}
