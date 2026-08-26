local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	-- Disable default behaviors with more sensible
	config.adjust_window_size_when_changing_font_size = false

	config.font_size = 14.0

	config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })

	-- Disable
	config.harfbuzz_features = { "zero" }
end

return module
