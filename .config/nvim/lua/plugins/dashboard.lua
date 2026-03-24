return{
  "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
        vim.cmd("hi DashboardHeader gui=bold cterm=bold")

        -- local function make_header()
        --     local v = vim.version()
        --
        --     local header_width = vim.fn.strdisplaywidth(
        --         "--------------------------------------- Neo - Vi IMproved"
        --     )
        --
        --     local version = string.format("NVIM v%d.%d.%d", v.major, v.minor, v.patch)
        --     local version_width = vim.fn.strdisplaywidth(version)
        --
        --     local padding = header_width - version_width
        --     if padding < 0 then
        --         padding = 0
        --     end
        --
        --     local right_aligned_version = string.rep(" ", padding) .. version
        --
        --     return {
        --         "",
        --         -- "---------------------------------------------------------",
        --         "_____   __                      _____            ",
        --         "___  | / /__________     ___   ____(_)______ ___ ",
        --         "__   |/ /_  _ \\  __ \\    __ | / /_  /__  __ `__ \\",
        --         "_  /|  / /  __/ /_/ /    __ |/ /_  / _  / / / / /",
        --         "/_/ |_/  \\___/\\____/     _____/ /_/  /_/ /_/ /_/ ",
        --         "",
        --         "--------------------------------------- Neo - Vi IMproved",
        --         right_aligned_version,
        --         "",
        --     }
        -- end

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

            local dash_len = max_width - left_w - right_w - 2 + 6
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
            theme = "hyper",
            config = {
                header = make_header(),
                header_hl = "DashboardHeader",

                --packages = { enable = false },

                shortcut = {
                    { desc = ' New File', group = 'String', action = 'enew', key = 'n'},
                    { desc = ' Recent Files', group = 'Keyword', action = 'Telescope oldfiles', key = 'r' },
                    { desc = '󰊳 Lazy-nvim Update', group = 'Character', action = 'Lazy update', key = 'u' },
                },

                mru = { enable = false },

                footer = function ()
                    return {
                        ""
                    }
                end,
            },
        })
    end,
}
