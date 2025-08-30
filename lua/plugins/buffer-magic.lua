return {
  "buffer-magic",
  dir = ".",
  name = "buffer-magic",
  dev = true,
  lazy = false,
  priority = 1000,
  opts = {
    auto_close_neotree = true,
    auto_save_modified = true,
    cleanup_on_buf_enter = true,
    cleanup_on_win_closed = true,
    auto_close_windows = true,
  },
  config = function(_, opts)
    -- Default configuration
    local default_config = {
      auto_close_neotree = true,
      auto_save_modified = true,
      cleanup_on_buf_enter = true,
      cleanup_on_win_closed = true,
      auto_close_windows = true,
    }

    local config = vim.tbl_deep_extend("force", default_config, opts or {})

    -- Utility to delete all non-visible, listed buffers
    local function delete_hidden_buffers()
      local visible = {}
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        visible[vim.api.nvim_win_get_buf(win)] = true
      end

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Only touch listed and loaded buffers not visible in any window
        if not visible[buf] and vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
          -- Save if modified before deleting
          if config.auto_save_modified and vim.api.nvim_buf_get_option(buf, "modified") then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd("write")
            end)
          end
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end

    -- Setup autocmds
    local augroup = vim.api.nvim_create_augroup("BufferMagic", { clear = true })

    -- BufReadPost autocmd
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = augroup,
      callback = function(args)
        -- Always close Neo-tree when a buffer is opened (if enabled)
        if config.auto_close_neotree then
          vim.cmd("silent! Neotree close")
        end

        local current = args.buf
        -- Save current buffer if modified (if enabled)
        if config.auto_save_modified and vim.api.nvim_buf_get_option(current, "modified") then
          vim.cmd("write")
        end

        -- Gather list of buffers currently visible in any window
        local visible = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          visible[vim.api.nvim_win_get_buf(win)] = true
        end

        -- Delete all loaded, listed buffers not visible in any window
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if not visible[buf] and vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end,
    })

    -- BufEnter autocmd (if enabled)
    if config.cleanup_on_buf_enter then
      vim.api.nvim_create_autocmd("BufEnter", {
        group = augroup,
        callback = function()
          -- Schedule so buffer switch completes before cleaning up
          vim.schedule(delete_hidden_buffers)
        end,
      })
    end

    -- WinClosed autocmd (if enabled)
    if config.cleanup_on_win_closed then
      vim.api.nvim_create_autocmd("WinClosed", {
        group = augroup,
        callback = function()
          vim.schedule(delete_hidden_buffers)
        end,
      })
    end

    -- BufDelete autocmd (if enabled)
    if config.auto_close_windows then
      vim.api.nvim_create_autocmd("BufDelete", {
        group = augroup,
        callback = function(args)
          local bufnr = args.buf
          -- For every window, if it's displaying this buffer, close the window
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == bufnr then
              -- Avoid closing last window (which would quit Neovim)
              if #vim.api.nvim_list_wins() > 1 then
                vim.api.nvim_win_close(win, true)
              end
            end
          end
        end,
      })
    end

    -- Store utility function globally for manual access
    _G.BufferMagic = {
      delete_hidden_buffers = delete_hidden_buffers,
      config = config,
    }
  end,
}
