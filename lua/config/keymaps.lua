-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Force reload current buffer
vim.keymap.set("n", "<leader>rr", ":checktime<CR>", { desc = "Reload current buffer" })

-- Force reload all buffers
vim.keymap.set("n", "<leader>rR", ":bufdo checktime<CR>", { desc = "Reload all buffers" })
