local M = { }

local wezterm = require("wezterm")
local state = require("config_state")
local c_io = require("config_io")


function M.apply(config)
    config.automatically_reload_config = true

    config.initial_cols = 144
    config.initial_rows = 32

    local front_end = "WebGpu"

    local pwr = "HighPerformance"
    local pwrpref = state.WEZTERM_WEBGPU_PWR_PREF
    if pwrpref == "H" then
        pwr = "HighPerformance"
    elseif pwrpref == "L" then
        pwr = "LowPower"
    end
    config.webgpu_power_preference = pwr

    if state.WEZTERM_OPENGL then
        front_end = "OpenGL"
    end

    config.front_end = front_end
    --config.window_background_opacity = 0.50
    --config.macos_window_background_blur = 20
    config.window_background_opacity = state.opacity_state

    if state.IS_WINDOWS then
        --config.win32_system_backdrop = 'Acrylic'
        config.window_decorations = 'INTEGRATED_BUTTONS'
    else
        config.window_decorations = 'NONE'
        config.enable_wayland = false
    end


    config.default_cursor_style = 'BlinkingBar'
    config.cursor_blink_rate = 480
    config.animation_fps = 120


    config.window_background_gradient =
    {colors = {'#000e1e'}}

    config.window_frame = {
        inactive_titlebar_bg = 'none',
        active_titlebar_bg = 'none'
    }
    config.color_scheme = 'Aquatermium'
    config.color_scheme_dirs = {
        "./colors",
    }

    config.show_new_tab_button_in_tab_bar = false
    config.show_close_tab_button_in_tabs = false
    config.colors = {tab_bar = {inactive_tab_edge = 'none'}}
    config.window_frame = {
        -- font = config.font,
        font_size = 9,
        -- font_rules = config.font_rules,
        active_titlebar_bg = 'none',
        inactive_titlebar_bg = 'none',
    }
end

function M.setup()
    -- switch opacity
    wezterm.on("toggle-opacity", function(window, _)
        local overrides = window:get_config_overrides() or {}

        if state.opacity_state == 1.0 then
            state.opacity_state = 0.7
        else
            state.opacity_state = 1.0
        end

        overrides.window_background_opacity = state.opacity_state
        window:set_config_overrides(overrides)

        if c_io.OPACITY_FILE then
            local f = io.open(c_io.OPACITY_FILE, "w")
            if f then
                f:write(tostring(state.opacity_state))
                f:close()
            end
        end
    end)

    wezterm.on('user-var-changed', function(window, pane, name, value)
        local overrides = window:get_config_overrides() or {}
        if name == "ZEN_MODE" then
            local incremental = value:find("+")
            local number_value = tonumber(value)
            if incremental ~= nil then
                while (number_value > 0) do
                    window:perform_action(wezterm.action.IncreaseFontSize, pane)
                    number_value = number_value - 1
                end
                overrides.enable_tab_bar = false
            elseif number_value < 0 then
                window:perform_action(wezterm.action.ResetFontSize, pane)
                overrides.font_size = nil
                overrides.enable_tab_bar = true
            else
                overrides.font_size = number_value
                overrides.enable_tab_bar = false
            end
        end
        window:set_config_overrides(overrides)
    end)

    wezterm.on("window_close_requested", function(_, _)
        if c_io.OPACITY_FILE then
            os.remove(c_io.OPACITY_FILE)
        end
        return true
    end)
end

return M
