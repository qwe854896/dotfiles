return {
	"github/copilot.vim",
	"RRethy/vim-illuminate",
	"ThePrimeagen/vim-be-good",
	"JoosepAlviste/nvim-ts-context-commentstring",
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
	{
		"karb94/neoscroll.nvim",
		config = function()
			require('neoscroll').setup {
				easing_function = "quadratic",
			}
			local keyset = vim.keymap.set
			keyset("n", "n", "n:lua require('neoscroll').zz(300)<CR>", { silent = true })
			keyset("n", "N", "N:lua require('neoscroll').zz(300)<CR>", { silent = true })
		end
	},
	{
		"LunarVim/bigfile.nvim",
		config = function()
			require('bigfile').setup {
				filesize = 2,
				pattern = { "*" },
				features = {
					"treesitter",
					"illuminate",
					"indent_blankline",
					"syntax",
					"filetype",
					"vimopts",
					"matchparen",
				}
			}
		end
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require('project_nvim').setup {
			}
			require('telescope').load_extension('projects')

			local keyset = vim.keymap.set
			keyset("n", "<leader>fp", "<CMD>lua require('telescope').extensions.projects.projects{}<CR>", { silent = true })
		end
	}
}
