return{
    {
        "T-b-t-nchos/Aquavium.nvim",
        dev = false,
        name = "Aquavium.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local temp_dir = vim.fn.getenv("TEMP") or vim.fn.getenv("TMP")
            local opacity_file = temp_dir .. "\\wezterm_opacity.tmp"
            local opacity
            local file = io.open(opacity_file, "r")
            if file then
                opacity = file:read("*a")
                file:close()
                opacity = tonumber(opacity)
            else
                opacity = nil
            end

            local aquavium = require("Aquavium")

            aquavium.setup({
                transparent = opacity == nil or opacity ~= 1.0,
            })

            if not vim.g.colors_name then
                vim.cmd("colorscheme Aquavium")
            end
        end,
    },
}
