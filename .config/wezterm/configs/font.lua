local M = {}

local wezterm = require("wezterm")
local state = require("config_state")

function M.apply(config)
    local fontid = state.WEZTERM_FONTID

    if fontid == "0" or fontid == nil then
        config.font_size = 10.0
        config.font = wezterm.font('Moralerspace Radon HW')
    elseif fontid == "1" then
        config.font_size = 12.0
        config.font = wezterm.font('PC98NXbs')
        config.font_rules = {
            {
                intensity = "Bold",
                font = wezterm.font("PC98NXbs", { weight = "Bold" }),
            },
            {
                italic = true,
                font = wezterm.font("PC98NXbs"),
            },
        }
    end

    config.use_ime = true
end

return M
