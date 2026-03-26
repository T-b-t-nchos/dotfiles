return {
    {
        "T-b-t-nchos/Aquavium.nvim",
        dev = false,
        name = "Aquavium.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local temp_dir = vim.env.TEMP or vim.env.TMP or vim.env.TEMPDIR or "/tmp"

            local sep = package.config:sub(1, 1)
            local opacity_file = temp_dir .. sep .. "wezterm_opacity.tmp"

            local opacity = nil
            local file = io.open(opacity_file, "r")

            if file then
                local content = file:read("*a")
                file:close()
                opacity = tonumber(content)
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
