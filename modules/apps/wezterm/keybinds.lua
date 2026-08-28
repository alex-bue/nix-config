local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

function module.apply_to_config(config)
	config.keys = {
		-- -- Move scrollback
		-- { key = 'K', mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },
		-- { key = 'J', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
		-- { key = 'U', mods = 'CTRL|SHIFT', action = act.ScrollByPage(-1) },
		-- { key = 'D', mods = 'CTRL|SHIFT', action = act.ScrollByPage(1) },
		--
		-- -- Pane:
		-- -- Rotate panes
		-- { key = 'J', mods = 'CTRL|SHIFT|SUPER', action = act.RotatePanes 'Clockwise' },
		-- { key = 'K', mods = 'CTRL|SHIFT|SUPER', action = act.RotatePanes 'CounterClockwise' },
		--
		-- -- Resize panes
		-- { key = 'H', mods = 'CTRL|SHIFT|ALT|SUPER', action = act.AdjustPaneSize{ 'Left', 1 } },
		-- { key = 'L', mods = 'CTRL|SHIFT|ALT|SUPER', action = act.AdjustPaneSize{ 'Right', 1 } },
		-- { key = 'K', mods = 'CTRL|SHIFT|ALT|SUPER', action = act.AdjustPaneSize{ 'Up', 1 } },
		-- { key = 'J', mods = 'CTRL|SHIFT|ALT|SUPER', action = act.AdjustPaneSize{ 'Down', 1 } },
		--
		-- -- New panes
		-- { key = 'Enter', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
		-- { key = 'Enter', mods = 'CTRL|SHIFT|SUPER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
		--
		-- -- Close pane
		-- { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
		--
	}
end

return module
