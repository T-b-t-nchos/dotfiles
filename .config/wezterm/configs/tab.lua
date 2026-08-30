local M = {}

local wezterm = require("wezterm")

function M.setup()
    local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
    local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
    wezterm.on('format-tab-title', function(tab, _, _, _, _, max_width)
        local background = '#303030'
        local foreground = '#aaaaaa'
        local edge_background = 'none'
        if tab.is_active then
            background = '#1b1b1b'
            --background = '#079202'
            foreground = '#FFFFFF'
        end
        local edge_foreground = background
        local title = '   ' .. wezterm.truncate_right(tab.active_pane.title,max_width - 1) .. '   '
        return {
            {Background = {Color = edge_background}},
            {Foreground = {Color = edge_foreground}}, {Text = SOLID_LEFT_ARROW},
            {Background = {Color = background}},
            {Foreground = {Color = foreground}}, {Text = title},
            {Background = {Color = edge_background}},
            {Foreground = {Color = edge_foreground}}, {Text = SOLID_RIGHT_ARROW}
        }
    end)
end

return M
