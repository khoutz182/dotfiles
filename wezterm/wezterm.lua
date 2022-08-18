
local wezterm = require('wezterm')
local action = wezterm.action

local mykeys = {}

for i = 1, 8 do
	table.insert(mykeys, {
		key = tostring(i),
		mods = 'ALT',
		action = action.ActivateTab(i - 1),
	})
end

return {
	color_scheme = 'Catppuccin Macchiato',

	leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000},
	keys = mykeys,

	window_padding = {
		left = 2,
		right = 2,
		top = 1,
		bottom = 1,
	},

	use_fancy_tab_bar = false,

	check_for_updates = false,
}
