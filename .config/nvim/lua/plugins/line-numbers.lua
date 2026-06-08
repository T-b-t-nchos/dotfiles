return {
    "shrynx/line-numbers.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
        enabled = true,     -- or false to disable by default
        mode = "both",      -- "relative", "absolute", "both", "none"
        format = "rel_abs", -- or "rel_abs"
        separator = " ",
        number_fallback = true,
        relativenumber_fallback = true,
        statuscolumn_fallback = "",
        rel_highlight = { link = "EndOfBuffer" },
        abs_highlight = { link = "LineNr" },
        current_rel_highlight = { link = "EndOfBuffer" },
        current_abs_highlight = { link = "CursorLineNr" },
    },
}
