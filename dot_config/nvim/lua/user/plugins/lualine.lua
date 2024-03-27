local function mixed_indent()
	local space_pat = [[\v^ +]]
	local tab_pat = [[\v^\t+]]
	local space_indent = vim.fn.search(space_pat, 'nwc')
	local tab_indent = vim.fn.search(tab_pat, 'nwc')
	local mixed = (space_indent > 0 and tab_indent > 0)
	local mixed_same_line
	if not mixed then
		mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
		mixed = mixed_same_line > 0
	end
	-- Return "Tab" or "Spaces: <count>"
	if not mixed then
		if tab_indent > 0 then
			return 'Tab'
		else
			return 'Spaces: ' .. '?'
		end
	end
	if mixed_same_line ~= nil and mixed_same_line > 0 then
		return 'MI:' .. mixed_same_line
	end
	local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
	local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
	if space_indent_cnt > tab_indent_cnt then
		return 'MI:' .. tab_indent
	else
		return 'MI:' .. space_indent
	end
end

local function window()
	return vim.api.nvim_win_get_number(0)
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number | nil hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
	return function(str)
		local win_width = vim.fn.winwidth(0)
		if hide_width and win_width < hide_width then
			return ''
		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
			return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
		end
		return str
	end
end

return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-lua/lsp-status.nvim',
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			local custom_fname = require('lualine.components.filename'):extend()
			local highlight = require 'lualine.highlight'
			local default_status_colors = { saved = '#9ece6a', modified = '#9d7cd8' }

			function custom_fname:init(options)
				custom_fname.super.init(self, options)
				self.status_colors = {
					saved = highlight.create_component_highlight_group(
						{ bg = default_status_colors.saved }, 'filename_status_saved', self.options),
					modified = highlight.create_component_highlight_group(
						{ bg = default_status_colors.modified }, 'filename_status_modified', self.options),
				}
				if self.options.color == nil then self.options.color = '' end
			end

			function custom_fname:update_status()
				local data = custom_fname.super.update_status(self)
				data = highlight.component_format_highlight(vim.bo.modified
					and self.status_colors.modified
					or self.status_colors.saved) .. data
				return data
			end

			require('lualine').setup {
				options = {
					icons_enabled = true,
					-- theme = 'tokyonight',
					theme = 'vscode',
					section_separators = '',
					component_separators = '',
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = {
						'branch',
						'diff',
						'diagnostics',
					},
					lualine_c = {
						{ 'filename', },
						{ require("nvim-treesitter").statusline, fmt = trunc(90, 30, 50, false) },
					},
					lualine_x = {
						{ mixed_indent },
						'encoding',
						{
							'fileformat',
							icons_enabled = true,
							symbols = {
								unix = ' LF',
								dos = ' CRLF',
								mac = ' CR',
							},
						},
						'filetype',
					},
					lualine_y = {
						{ window },
						'progress',
					},
					lualine_z = { 'location' },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = { 'fugitive', 'toggleterm', 'nvim-tree' },
			}
		end
	},
}
