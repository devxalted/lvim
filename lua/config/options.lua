-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.shiftwidth = 4
opt.expandtab = false
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" } -- hide tab chars, keep other indicators
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

-- Fix wl-clipboard stripping newlines which breaks linewise paste
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy --foreground --type text/plain",
    ["*"] = "wl-copy --foreground --primary --type text/plain",
  },
  paste = {
    ["+"] = function()
      local raw = vim.fn.system('wl-paste --type "text/plain;charset=utf-8" 2>/dev/null')
      local lines = vim.split(raw, '\n')
      if lines[#lines] == '' then
        table.remove(lines)
        return { lines, 'V' }
      end
      return { lines, 'v' }
    end,
    ["*"] = function()
      local raw = vim.fn.system('wl-paste --primary --type "text/plain;charset=utf-8" 2>/dev/null')
      local lines = vim.split(raw, '\n')
      if lines[#lines] == '' then
        table.remove(lines)
        return { lines, 'V' }
      end
      return { lines, 'v' }
    end,
  },
  cache_enabled = true,
}
