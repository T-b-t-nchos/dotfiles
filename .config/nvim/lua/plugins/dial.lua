return {
    "monaqa/dial.nvim",
    lazy = true,
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group{
            -- default augends used when no group name is specified
            default = {
                -- numbers
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.integer.alias.binary,
                augend.integer.alias.octal,

                -- dates
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%Y-%m-%d"],
                augend.date.alias["%m/%d/%Y"],
                augend.date.alias["%d.%m.%Y"],

                -- time
                augend.date.alias["%H:%M"],
                augend.date.alias["%H:%M:%S"],

                -- boolean
                augend.constant.alias.bool,

                -- common toggles
                augend.constant.new({
                    elements = { "true", "false" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "on", "off" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "yes", "no" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "enable", "disable" },
                    word = true,
                    cyclic = true,
                }),

                -- logical operators
                augend.constant.new({
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                }),

                -- weekday
                augend.constant.new({
                    elements = {
                        "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday",
                    },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = {
                        "Mon","Tue","Wed","Thu","Fri","Sat","Sun",
                    },
                    word = true,
                    cyclic = true,
                }),

                -- markdown checkbox
                augend.constant.new({
                    elements = { "[ ]", "[x]" },
                    word = false,
                    cyclic = true,
                }),

                -- git rebase todo commands
                augend.constant.new({
                    elements = {
                        "pick",
                        "reword",
                        "edit",
                        "squash",
                        "fixup",
                        "exec",
                        "drop",
                        "break",
                        "label",
                        "reset",
                        "merge",
                    },
                    word = true,
                    cyclic = true,
                }),

                -- semantic version
                augend.semver.alias.semver,
            },
        }
    end,
}
