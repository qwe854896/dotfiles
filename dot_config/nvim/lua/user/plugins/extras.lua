return {
	"github/copilot.vim",
	"ThePrimeagen/vim-be-good",
	{
		'ojroques/nvim-osc52',
		config = function()
			require('osc52').setup()
			local function copy()
				if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
					require('osc52').copy_register('"')
				end
			end

			vim.api.nvim_create_autocmd('TextYankPost', { callback = copy })
		end
	},
	{
		'alker0/chezmoi.vim',
		lazy = false,
		init = function()
			-- This option is required.
			vim.g['chezmoi#use_tmp_buffer'] = true
			-- add other options here if needed.
		end,
	},
}
