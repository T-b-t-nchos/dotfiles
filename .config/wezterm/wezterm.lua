local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-----------------------------------------------
--- settings value
local opacity_state = 0.7
-----------------------------------------------

config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

config.keys = require('keybinds').keys
config.key_tables = require('keybinds').key_tables
config.disable_default_key_bindings = true

config.default_prog = {'pwsh'}

config.automatically_reload_config = true

config.initial_cols = 120
config.initial_rows = 28

config.front_end = 'WebGpu'
--config.window_background_opacity = 0.50
--config.macos_window_background_blur = 20
config.window_background_opacity = opacity_state
--config.win32_system_backdrop = 'Acrylic'
config.window_decorations = 'INTEGRATED_BUTTONS'

config.font_size = 11.0
config.font = wezterm.font('Moralerspace Radon HW')
config.use_ime = true

config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 480

config.launch_menu = {
    {
    label = 'PowerShell',
    args = {'pwsh.exe'},
    set_environment_variables = {
            MSYSTEM = nil,
            MSYS = nil,
            MSYS2_PATH_TYPE = nil
        }
    },
  {label = 'Cmd', args = {'cmd.exe', ''}},
  {label = 'Git Bash', args = {'C:/Program Files/git/bin/bash.exe'}},
  {label = 'WSL Bash', args = {'bash', '-l'}},
  {label = 'NeoVim (native)', args = {'nvim'}},
}

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
config.show_close_tab_button_in_tabs = true
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
wezterm.on("toggle-opacity", function(window, pane)
  local overrides = window:get_config_overrides() or {}

  if opacity_state == 1.0 then
    opacity_state = 0.7
  else
    opacity_state = 1.0
  end

  overrides.window_background_opacity = opacity_state
  window:set_config_overrides(overrides)
end)

return config
