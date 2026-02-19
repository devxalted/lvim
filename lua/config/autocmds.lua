-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- OSC 52 clipboard for mosh + tmux (iPad/remote clipboard)
-- Hook into TextYankPost to send yanked text to iPad clipboard
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    local text = vim.fn.getreg('"')
    if text and #text > 0 then
      local handle = io.popen(os.getenv('HOME') .. '/.local/bin/osc52-copy', 'w')
      if handle then
        handle:write(text)
        handle:close()
      end
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent update")
    end
  end,
})

-- Enhanced auto-reload for LazyVim
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Auto-reload files when they change on disk
vim.opt.autoread = true
vim.opt.updatetime = 250 -- Faster update time for better responsiveness

-- Auto-reload when file changes externally
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- More comprehensive file change detection
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup("auto_read"),
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Notify when file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = augroup("file_changed"),
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})
