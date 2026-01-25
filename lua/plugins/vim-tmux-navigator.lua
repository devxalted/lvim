-- ~/.config/nvim/lua/plugins/vim-tmux-navigator.lua
-- LazyVim compatible vim-tmux-navigator configuration

return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate Left" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate Down" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate Up" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate Right" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate Previous" },
    },
    config = function()
      -- Plugin configuration options
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_preserve_zoom = 1

      -- Terminal mode mappings
      vim.keymap.set("t", "<c-h>", "<c-\\><c-n><cmd>TmuxNavigateLeft<cr>", { desc = "Navigate Left (Terminal)" })
      vim.keymap.set("t", "<c-j>", "<c-\\><c-n><cmd>TmuxNavigateDown<cr>", { desc = "Navigate Down (Terminal)" })
      vim.keymap.set("t", "<c-k>", "<c-\\><c-n><cmd>TmuxNavigateUp<cr>", { desc = "Navigate Up (Terminal)" })
      vim.keymap.set("t", "<c-l>", "<c-\\><c-n><cmd>TmuxNavigateRight<cr>", { desc = "Navigate Right (Terminal)" })
    end,
  },

  -- Optional: Vimux for sending commands to tmux panes
  {
    "preservim/vimux",
    cmd = {
      "VimuxRunCommand",
      "VimuxRunLastCommand",
      "VimuxPromptCommand",
      "VimuxInspectRunner",
      "VimuxZoomRunner",
      "VimuxCloseRunner",
    },
    keys = {
      { "<leader>vp", "<cmd>VimuxPromptCommand<cr>", desc = "Vimux: Prompt Command" },
      { "<leader>vl", "<cmd>VimuxRunLastCommand<cr>", desc = "Vimux: Run Last Command" },
      { "<leader>vi", "<cmd>VimuxInspectRunner<cr>", desc = "Vimux: Inspect Runner" },
      { "<leader>vz", "<cmd>VimuxZoomRunner<cr>", desc = "Vimux: Zoom Runner" },
      { "<leader>vc", "<cmd>VimuxCloseRunner<cr>", desc = "Vimux: Close Runner" },
    },
    config = function()
      -- Vimux configuration
      vim.g.VimuxHeight = "30"
      vim.g.VimuxOrientation = "v"
      vim.g.VimuxUseNearest = 1
    end,
  },
}

-- ================================
-- ADDITIONAL CONFIGURATION (optional)
-- ================================
-- Add this to ~/.config/nvim/lua/config/keymaps.lua or init.lua if you want additional features

--[[
-- Auto-save when leaving vim (useful for tmux switching)
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "silent! wa",
  desc = "Auto-save when losing focus",
})

-- Check for file changes when gaining focus
vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check for file changes when gaining focus",
})

-- Function to check tmux status
local function is_tmux()
  return vim.env.TMUX ~= nil
end

-- Enhanced navigation with fallback
local function enhanced_navigate(direction)
  local directions = {
    h = "Left",
    j = "Down", 
    k = "Up",
    l = "Right"
  }
  
  if is_tmux() then
    vim.cmd("TmuxNavigate" .. directions[direction])
  else
    vim.cmd("wincmd " .. direction)
  end
end

-- Debug function for troubleshooting
local function debug_tmux_nav()
  print("TMUX: " .. (vim.env.TMUX and "Yes" or "No"))
  if vim.env.TMUX then
    local pane_id = vim.fn.system('tmux display-message -p "#{pane_id}"'):gsub('\n', '')
    print("Current pane: " .. pane_id)
  end
  print("Window splits: " .. vim.fn.winnr("$"))
end

-- Optional keybindings for debugging
vim.keymap.set("n", "<leader>td", debug_tmux_nav, { desc = "Debug tmux navigation" })
--]]

-- ================================
-- INSTALLATION INSTRUCTIONS
-- ================================
--[[
SETUP STEPS FOR LAZYVIM:

1. Save this file as ~/.config/nvim/lua/plugins/vim-tmux-navigator.lua

2. Make sure your tmux.conf includes the vim-aware navigation:
   # Add to ~/.tmux.conf
   is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
       | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"

   bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
   bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
   bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
   bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

3. Reload both configs:
   tmux source-file ~/.tmux.conf
   :Lazy sync (in Neovim)

4. Test navigation with Ctrl+h/j/k/l between vim splits and tmux panes

FEATURES ENABLED:
- Seamless navigation between vim splits and tmux panes
- Terminal mode navigation support
- Auto-save on pane switch
- Zoom preservation
- Optional Vimux integration for running commands

TROUBLESHOOTING:
- If navigation doesn't work, check $TMUX environment variable
- Ensure tmux version is 1.8+ 
- Verify the vim detection pattern in tmux.conf matches your vim binary
- Use <leader>td to debug navigation status
--]]
