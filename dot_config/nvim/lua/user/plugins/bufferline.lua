local M =
{
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons'
}

M.config = function()
	local bufferline = require('bufferline')
	bufferline.setup(
		{
			options = {
				mode = "normal",
				separator_style = "slant",
				always_show_bufferline = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true,
			},
			-- highlights = {
			-- 	separator = {
			-- 		guifg = "#073642",
			-- 		guibg = "#002b36",
			-- 	},
			-- 	separator_selected = {
			-- 		guifg = "#073642",
			-- 	},
			-- 	background = {
			-- 		guifg = "#657b83",
			-- 		guibg = "#002b36",
			-- 	},
			-- 	buffer_selected = {
			-- 		guifg = "#fdf6e3",
			-- 		gui = "bold",
			-- 	},
			-- 	fill = {
			-- 		guibg = "#073642",
			-- 	},
			-- },
		}
	)

	-- open empty splits
	vim.api.nvim_set_keymap("n", "<leader>|", "<CMD>vsplit +enew<CR>", {})
	vim.api.nvim_set_keymap("n", "<leader>_", "<CMD>split +enew<CR>", {})

	-- since we open empty splits - clean them up as we cycle through open buffers
	function ChangeTab(motion)
		local last_buffer_id = vim.fn.bufnr()
		local last_buffer_name = vim.fn.expand("%")

		if motion == "next" then
			vim.cmd([[BufferLineCycleNext]])
		elseif motion == "prev" then
			vim.cmd([[BufferLineCyclePrev]])
		else
			error("Invalid motion: " .. motion)
			return
		end

		if last_buffer_name == "" then
			vim.cmd("bd " .. last_buffer_id)
		end
	end

	-- switch through visible buffers with shift-l/h
	vim.api.nvim_set_keymap("n", "<S-l>", "<CMD>lua ChangeTab('next')<CR>", {})
	vim.api.nvim_set_keymap("n", "<S-h>", "<CMD>lua ChangeTab('prev')<CR>", {})
end

return M
