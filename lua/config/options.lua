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
