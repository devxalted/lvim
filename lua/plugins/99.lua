return {
  "ThePrimeagen/99",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local _99 = require("99")
    _99.setup({
      provider = _99.Providers.ClaudeCodeProvider,
    })
    vim.keymap.set("v", "<leader>9v", function() _99.visual() end, { desc = "99: AI request on selection" })
    vim.keymap.set("n", "<leader>9x", function() _99.stop_all_requests() end, { desc = "99: Cancel request" })
    vim.keymap.set("n", "<leader>9s", function() _99.search() end, { desc = "99: Search" })
  end,
  keys = {
    { "<leader>9v", mode = "v", desc = "99: AI request on selection" },
    { "<leader>9x", desc = "99: Cancel request" },
    { "<leader>9s", desc = "99: Search" },
  },
}
