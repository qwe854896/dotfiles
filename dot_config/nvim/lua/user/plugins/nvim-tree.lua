return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				disable_netrw = true,
				hijack_netrw = true,
				update_focused_file = {
					enable = true,
					update_cwd = true,
				},
				view = {
					width = 30,
				},
			})

			-- Keymaps
			local keyset = vim.keymap.set
			keyset("n", "<leader>t", "<CMD>NvimTreeToggle<CR>", { silent = true })
		end,
	},
}
