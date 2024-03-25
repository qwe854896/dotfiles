return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require('toggleterm').setup{
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				autochdir = false,
				persist_mode = true,
				direction = 'horizontal',
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = 'curved',
				}
			}
	  end,
	},
}
