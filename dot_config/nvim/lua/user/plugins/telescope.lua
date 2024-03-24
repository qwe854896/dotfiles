return {
	{
		"nvim-telescope/telescope.nvim",
		tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function ()
			require('telescope').setup {
				defaults = {
					file_ignore_patterns = { "node_modules", ".git" },
					prompt_prefix = "🔍 ",
					selection_caret = "❯ ",
					layout_config = {
						prompt_position = "top",
						horizontal = {
							width_padding = 0.1,
							height_padding = 0.1,
							preview_width = 0.6,
						},
						vertical = {
							width_padding = 0.05,
							height_padding = 1,
							preview_height = 0.5,
						},
					},
					mappings = {
						i = {
							["<esc>"] = require('telescope.actions').close,
						},
					},
				},
			}
		end,
	},
}
