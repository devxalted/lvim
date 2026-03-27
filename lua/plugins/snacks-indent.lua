return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        indent = {
          hl = {
            "SnacksIndent1",
            "SnacksIndent2",
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
          },
        },
        scope = {
          hl = "SnacksIndentScope",
        },
      },
    },
    init = function()
      -- Set rainbow colors after colorscheme loads (gruvbox-friendly)
      local function set_hl()
        local colors = {
          "#cc241d", "#d79921", "#98971a", "#689d6a",
          "#458588", "#b16286", "#d65d0e", "#928374",
        }
        for i, color in ipairs(colors) do
          vim.api.nvim_set_hl(0, "SnacksIndent" .. i, { fg = color })
        end
        vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#ebdbb2" })
      end
      set_hl()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
    end,
  },
}
