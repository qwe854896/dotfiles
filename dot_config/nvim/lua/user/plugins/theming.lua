return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup(
				{
					style = "night",
					styles = {
						comments = { italic = false },
						keywords = { italic = false },
						functions = { italic = false },
						variables = { italic = false },
						sidebars = "dark",
						floats = "dark",
					},
					lualine_bold = true,
				}
			)
			vim.cmd("colorscheme tokyonight")
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
					sections = {
						lualine_a = { 'mode' },
						lualine_b = { 'branch', 'diff', 'diagnostics' },
						lualine_c = { 'filename', 'nvim_treesitter#statusline' },
						lualine_x = { 'encoding', 'fileformat', 'filetype' },
						lualine_y = { 'progress' },
						lualine_z = { 'location' },
					},
				}
			)
		end
	},
}
