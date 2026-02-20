-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.shiftwidth = 4
opt.expandtab = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.timeoutlen = 1000
opt.ttimeoutlen = 0

-- vim.g.gruvbox_baby_telescope_theme = 1
-- vim.g.gruvbox_baby_transparent_mode = 1

-- ~/.config/nvim/lua/config/options.lua

-- Enhanced file watching for external changes
vim.opt.autoread = true
vim.opt.updatetime = 100 -- Very fast updates
vim.opt.timeoutlen = 300

-- Better handling of external file changes
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Ensure LazyVim notifications work well with file changes
vim.g.autoread_keep_scroll_position = true
