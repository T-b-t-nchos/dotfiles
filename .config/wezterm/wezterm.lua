-- +--------------------------------------------- --- -- - -  -
-- | WezTerm config File
-- +--------------------------------------------- -- - - --  -  -
--
-- USER-CONFIG LIST
-- |
-- | - "$env:WEZTERM_OPENGL" ... Use OpenGL
-- | - "$env:WEZTERM_WEBGPU_PWR_PREF" ... WebGPU Power Preference (H/L)
-- | - "$env:WEZTERM_FONTID" ... Font ID (Number, default is 0)
-- |
-- +----

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

require("configs.options").apply(config)
require("configs.appearance").apply(config)
require("configs.appearance").setup()
require("configs.font").apply(config)
require("configs.tab").setup()

config.keys = require("configs.keybinds").keys
config.key_tables = require("configs.keybinds").key_tables
config.disable_default_key_bindings = true

return config
