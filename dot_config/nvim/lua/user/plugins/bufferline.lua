local M =
{
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons'
}

M.config = function()
	local bufferline = require('bufferline')
	-- lighten up bufferline background
	bufferline.setup(
		{
			options = {
				active = true,
				options = {
					separator_style = "slant",
				},
				highlights = {
					fill = {
						bg = "#252d52",
					},

					separator_selected = {
						fg = "#252d52",
					},

					separator_visible = {
						fg = "#252d52",
					},

					separator = {
						fg = "#252d52",
					},

					buffer_visible = {
						fg = "#9696ca",
						bold = false,
					},

					buffer_selected = {
						fg = "#eeeeee",
						bold = false,
					},

					tab_selected = {
						bold = false,
					},
				},
			},
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
