local M = {}

local wezterm = require("wezterm")
local state = require("config_state")


local function get_temp_dir()
    if state.IS_WINDOWS then
        return os.getenv("TEMP") or os.getenv("TMP")
    else
        return os.getenv("TMPDIR") or "/tmp"
    end
end
M.temp_dir = get_temp_dir()

M.OPACITY_FILE = nil

if M.temp_dir then
    local sep = state.IS_WINDOWS and "\\" or "/"
    M.OPACITY_FILE = M.temp_dir .. sep .. "wezterm_opacity.tmp"
end

if M.OPACITY_FILE then
    local f = io.open(M.OPACITY_FILE, "r")
    if f then
        local content = f:read("*a")
        f:close()
        state.opacity_state = tonumber(content) or 0.7
    end
end

return M
