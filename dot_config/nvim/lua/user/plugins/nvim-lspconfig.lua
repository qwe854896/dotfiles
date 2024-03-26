local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	}
}

M.config = function()
	local lspconfig = require('lspconfig')
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	-- Setup servers
	lspconfig.lua_ls.setup {
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- LuaJIT in the case of Neovim
					version = 'LuaJIT',
					path = vim.split(package.path, ';')
				},
				diagnostics = {
					globals = { 'vim' }
				}
			}
		},
		on_attach = function(client)
			client.server_capabilities.semanticTokensProvider = nil
		end
	}
	lspconfig.clangd.setup {
		capabilities = capabilities,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
		on_attach = function(client)
			client.server_capabilities.semanticTokensProvider = nil
		end
	}
	lspconfig.pyright.setup {
		capabilities = capabilities,
		on_attach = function(client)
			client.server_capabilities.semanticTokensProvider = nil
		end
	}

	-- Global mappings
	local keyset = vim.keymap.set

	keyset('n', '<leader>e', vim.diagnostic.open_float)
	keyset('n', '[d', vim.diagnostic.goto_prev)
	keyset('n', ']d', vim.diagnostic.goto_next)
	keyset('n', '<leader>q', vim.diagnostic.setloclist)

	-- Use LspAttach autocommand to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('UserLspConfig', {}),
		callback = function(ev)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set('n', '<leader>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
			vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
				vim.lsp.buf.format { async = true }
			end, opts)
		end,
	})
end

return M
