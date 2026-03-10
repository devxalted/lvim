-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Force reload current buffer
vim.keymap.set("n", "<leader>rr", ":checktime<CR>", { desc = "Reload current buffer" })

-- Force reload all buffers
vim.keymap.set("n", "<leader>rR", ":bufdo checktime<CR>", { desc = "Reload all buffers" })

-- Duplicate current line below, move to it, enter insert mode at end of line
vim.keymap.set("n", "<leader>D", function()
	local line = vim.api.nvim_get_current_line()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row, row, false, { line })
	vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
	vim.cmd("startinsert!")
end, { desc = "Duplicate line below and insert" })
