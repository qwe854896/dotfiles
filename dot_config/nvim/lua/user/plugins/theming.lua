return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup {
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
			-- vim.cmd("colorscheme tokyonight")
		end
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode").setup {
				transparent = true,
				italic_comments = false,
				underline_links = true,
				disable_nvimtree_bg = true,
			}
			vim.cmd("colorscheme vscode")

			-- Hide semantic highlights for functions
			vim.api.nvim_set_hl(0, '@lsp.type.function', {})
			-- Hide all semantic highlights
			for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
				vim.api.nvim_set_hl(0, group, {})
			end
		end
	}
}
