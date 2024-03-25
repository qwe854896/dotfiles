local M =
{
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons'
}

M.config = function()
	vim.opt.termguicolors = true
	require('bufferline').setup {
		options = {
			diagnostics = "coc",
			offsets = {
				{
					filetype = "NvimTree",
					text = "",
				},
			},
			separator_style = "slant",
			always_show_bufferline = true,
			color_icons = true,
			show_tab_indicators = true,
		},
	}

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

	local keyset = vim.keymap.set

	-- switch through visible buffers with shift-l/h
	keyset("n", "<S-l>", "<CMD>lua ChangeTab('next')<CR>", {})
	keyset("n", "<S-h>", "<CMD>lua ChangeTab('prev')<CR>", {})

	-- switch through pressing <leader><ordinal>
	for i = 1, 9 do
		keyset("n", "<leader>" .. i, "<CMD> lua require(\"bufferline\").go_to_buffer(" .. i .. ", true)<CR>",
			{ silent = true })
	end
end

return M
