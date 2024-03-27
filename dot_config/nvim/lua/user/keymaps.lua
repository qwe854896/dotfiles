local keyset = vim.keymap.set

-- Fast escape from insert mode
keyset("i", "jj", "<ESC>", { silent = true })

-- Move pages and center the cursor
-- keyset("n", "<C-d>", "<C-d>zz")
-- keyset("n", "<C-u>", "<C-u>zz")
-- keyset("n", "n", "nzzzv")
-- keyset("n", "N", "Nzzzv")

-- Window navigation
keyset("n", "<C-h>", "<C-w>h")
keyset("n", "<C-j>", "<C-w>j")
keyset("n", "<C-k>", "<C-w>k")
keyset("n", "<C-l>", "<C-w>l")

-- Split and Vsplit
keyset("n", "<leader>h", "<C-w>s")
keyset("n", "<leader>v", "<C-w>v")

-- Close buffer
keyset("n", "<leader>bd", ":bp|bd#<CR>")
