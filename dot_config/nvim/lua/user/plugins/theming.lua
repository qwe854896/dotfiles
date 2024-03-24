return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup(
				{
					style = "night",
					terminal_colors = true,
					styles = {
						comments = { italic = true },
						keywords = { italic = true },
						functions = {},
						variables = {},
						sidebars = "dark",
						floats = "dark",
					},
					lualine_bold = true,
				}
			)
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup(
				{
					options = {
						icons_enabled = true,
						theme = 'tokyonight',
						section_separators = { '', '' },
						component_separators = { '', '' },
					},
				}
			)
		end
	},
}
