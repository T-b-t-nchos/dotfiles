-- +--------------------------------------------- --- -- - -  -
-- | WezTerm config File 
-- +--------------------------------------------- -- - - --  -  -
--
-- USER-CONFIG LIST
-- |
-- | - "$env:WEZTERM_OPENGL" ... Use OpenGL
-- | 
-- +----

local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local IS_WINDOWS = wezterm.target_triple:find('windows', 1, true) ~= nil

-----------------------------------------------
--- settings value
local opacity_state = 0.7
local function get_temp_dir()
    if IS_WINDOWS then
        return os.getenv("TEMP") or os.getenv("TMP")
    else
        return os.getenv("TMPDIR") or "/tmp"
    end
end
local temp_dir = get_temp_dir()
local opacity_file = nil
if temp_dir then
    local sep = IS_WINDOWS and "\\" or "/"
    opacity_file = temp_dir .. sep .. "wezterm_opacity.tmp"
end
if opacity_file then
    local f = io.open(opacity_file, "r")
    if f then
        local content = f:read("*a")
        f:close()
        opacity_state = tonumber(content) or 0.7
    end
end
-----------------------------------------------

config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

config.keys = require('keybinds').keys
config.key_tables = require('keybinds').key_tables
config.disable_default_key_bindings = true

if IS_WINDOWS then
    config.default_prog = { "pwsh.exe" }
else
    config.default_prog = { "bash", "-l" }
end

config.automatically_reload_config = true

config.initial_cols = 120
config.initial_rows = 28

local front_end = "WebGpu"

if os.getenv("WEZTERM_OPENGL") == "1" then
    front_end = "OpenGL"
end

config.front_end = front_end
--config.window_background_opacity = 0.50
--config.macos_window_background_blur = 20
config.window_background_opacity = opacity_state

if IS_WINDOWS then
    --config.win32_system_backdrop = 'Acrylic'
    config.window_decorations = 'INTEGRATED_BUTTONS'
else
    config.window_decorations = 'NONE'
    config.enable_wayland = false
end

config.font_size = 11.0
config.font = wezterm.font('Moralerspace Radon HW')
config.use_ime = true

config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 480
config.animation_fps = 120

if IS_WINDOWS then
    config.launch_menu = {
        {
            label = "PowerShell",
            args = { "pwsh.exe" },
            set_environment_variables = {
                MSYSTEM = nil,
                MSYS = nil,
                MSYS2_PATH_TYPE = nil,
            },
        },
        { label = "Cmd", args = { "cmd.exe" } },
        { label = "Git Bash", args = { "C:/Program Files/git/bin/bash.exe" } },
        { label = "WSL Bash", args = { "bash", "-l" } },
        { label = "NeoVim (native)", args = { "nvim" } },
    }
else
    -- Linux / Ubuntu
    config.launch_menu = {
        { label = "Bash", args = { "bash", "-l" } },
        { label = "NeoVim", args = { "nvim" } },
    }
end

config.window_background_gradient = {colors = {'#000000'}}

config.window_frame = {
    inactive_titlebar_bg = 'none',
    active_titlebar_bg = 'none'
}
config.color_scheme = 'Custom Dimidium'
config.color_schemes = {
    ['Custom Dimidium'] = {
        foreground = "#ccc",
        background = "#141414",

        cursor_bg = '#eee',
        cursor_fg = 'none',
        cursor_border = 'none',

        ansi = {
            "#000000", -- black
            "#cf494c", -- red
            "#60b442", -- green
            "#db9c11", -- yellow
            "#0575d8", -- blue
            "#af5ed2", -- magenta
            "#1db6bb", -- cyan
            "#bab7b6", -- white
        },

        brights = {
            "#817e7e", -- bright black
            "#ff643b", -- bright red
            "#37e57b", -- bright green
            "#fccd1a", -- bright yellow
            "#688dfd", -- bright blue
            "#ed6fe9", -- bright magenta
            "#32e0fb", -- bright cyan
            "#dee3e4", -- bright white
        },
    },
}


config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.colors = {tab_bar = {inactive_tab_edge = 'none'}}
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
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

-- switch opacity
wezterm.on("toggle-opacity", function(window, _)
    local overrides = window:get_config_overrides() or {}

    if opacity_state == 1.0 then
        opacity_state = 0.7
    else
        opacity_state = 1.0
    end

    overrides.window_background_opacity = opacity_state
    window:set_config_overrides(overrides)

    if opacity_file then
        local f = io.open(opacity_file, "w")
        if f then
            f:write(tostring(opacity_state))
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
    if opacity_file then
        os.remove(opacity_file)
    end
    return true
end)

return config
