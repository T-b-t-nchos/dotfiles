local M = {}

local wezterm = require("wezterm")


M.IS_WINDOWS = wezterm.target_triple:find('windows', 1, true) ~= nil

M.WEZTERM_WEBGPU_PWR_PREF = os.getenv("WEZTERM_WEBGPU_PWR_PREF")    -- H or L
M.WEZTERM_OPENGL = os.getenv("WEZTERM_OPENGL") == "1"               -- true or false
M.WEZTERM_FONTID = os.getenv("WEZTERM_FONTID")                      -- 0 ~ 1


M.opacity_state = 0.7


return M
