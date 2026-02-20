return {
  "ThePrimeagen/99",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp", -- for completion source
  },
  config = function()
    local _99 = require("99")
    _99.setup({
      provider = _99.ClaudeCodeProvider,
      completion = {
        source = "cmp", -- use nvim-cmp (already configured in supertab.lua)
      },
    })
  end,
  keys = {
    { "<leader>9v", mode = "v", desc = "99: AI request on selection" },
    { "<leader>9x", desc = "99: Cancel request" },
    { "<leader>9s", desc = "99: Search" },
  },
}
