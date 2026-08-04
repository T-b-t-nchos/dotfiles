return{
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
        vim.cmd("hi DashboardHeader gui=bold cterm=bold")

        local function make_header()
            local v = vim.version()

            local title   = "Neo - Vi IMproved"
            local version = string.format("NVIM v%d.%d.%d", v.major, v.minor, v.patch)

            local art = {
                "_____   __                      _____            ",
                "___  | / /__________     ___   ____(_)______ ___ ",
                "__   |/ /_  _ \\  __ \\    __ | / /_  /__  __ `__ \\",
                "_  /|  / /  __/ /_/ /    __ |/ /_  / _  / / / / /",
                "/_/ |_/  \\___/\\____/     _____/ /_/  /_/ /_/ /_/ ",
            }

            local max_width = 0
            for _, l in ipairs(art) do
                max_width = math.max(max_width, vim.fn.strdisplaywidth(l))
            end

            local left  = version
            local right = title

            local left_w  = vim.fn.strdisplaywidth(left)
            local right_w = vim.fn.strdisplaywidth(right)

            local dash_len = max_width - left_w - right_w - 2 + 20
            if dash_len < 1 then
                dash_len = 1
            end

            local middle = string.rep("-", dash_len)

            local combined = string.format("%s %s %s", left, middle, right)

            return vim.list_extend({
                "",
            }, vim.list_extend(art, {
                "",
                combined,
                "",
            }))
        end

        require("dashboard").setup({
            theme = "doom",
            config = {
                header = make_header(),
                header_hl = "DashboardHeader",

                --packages = { enable = false },

                center = {
                    {
                        icon = '  ',
                        icon_hl = 'String',
                        desc = 'Find Files                                          ',
                        desc_hl = 'String',

                        action = 'Telescope find_files',
                        key = 'f',
                        key_hl = 'String',
                    },
                    {
                        icon = '  ',
                        icon_hl = 'Keyword',
                        desc = 'New File                                            ',
                        desc_hl = 'Keyword',

                        action = 'enew',
                        key = 'n',
                        key_hl = 'Keyword',
                    },
                    {
                        icon = '  ',
                        icon_hl = 'Character',
                        desc = 'Recent Files                                        ',
                        desc_hl = 'Character',

                        action = 'Telescope oldfiles',
                        key = 'r',
                        key_hl = 'Character',
                    },
                    {
                        icon = '  ',
                        icon_hl = 'Float',
                        desc = 'Projects                                            ',
                        desc_hl = 'Float',

                        -- action = 'Telescope projects',
                        key = 'p',
                        key_hl = 'Float',
                    },
                    {
                        icon = '  ',
                        icon_hl = 'Boolean',
                        desc = 'Find Text                                           ',
                        desc_hl = 'Boolean',

                        action = 'Telescope oldfiles',
                        key = 'g',
                        key_hl = 'Boolean',
                    },
                    {
                        icon = '  ',
                        icon_hl = 'Statement',
                        desc = 'Dotfiles                                            ',
                        desc_hl = 'Statement',

                        action = function()
                            require("telescope.builtin").find_files({
                                cwd = "~/dotfiles/",
                            })
                        end,
                        key = 'd',
                        key_hl = 'Statement',
                    },
                    {
                        icon = '󰊳  ',
                        icon_hl = 'Operator',
                        desc = 'Lazy-nvim Update                                 ',
                        desc_hl = 'Operator',

                        action = 'Lazy update',
                        key = 'u',
                        key_hl = 'Operator',
                    },
                    {
                        icon = '󰈆  ',
                        icon_hl = 'Function',
                        desc = 'Quit                                             ',
                        desc_hl = 'Function',

                        action = 'q',
                        key = 'q',
                        key_hl = 'Function',
                    },
                },

                vertical_center = true,
            },
        })
    end,
}
