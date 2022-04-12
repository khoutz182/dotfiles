
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

require('telescope').setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			width = 0.87,
			height = 0.80
			preview_cutoff = 120
		},
		mappings = {
			i = {
				["<esc>"] = actions.close
				["<M-p>"] = action_layout.toggle_preview
			},
			n = {
				["<M-p>"] = action_layout.toggle_preview
			},
		},
		file_ignore_patterns = { "node_modules" },
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
})
