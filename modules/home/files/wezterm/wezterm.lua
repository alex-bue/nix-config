-- Pull in the wezterm API
local wezterm = require 'wezterm'

local appearance = require 'appearance'
local fonts = require 'fonts'
local keybinds = require 'keybinds'
-- TODO local workspaces = require 'workspaces'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
appearance.apply_to_config(config)
fonts.apply_to_config(config)
keybinds.apply_to_config(config)
-- TODO workspaces.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
