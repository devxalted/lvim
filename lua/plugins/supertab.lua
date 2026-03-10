return {
	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
				["<CR>"] = { "fallback" },
				["<Tab>"] = { "fallback" },
				["<S-Tab>"] = { "fallback" },
				["<C-Space>"] = function(cmp)
					if cmp.is_visible() then
						return cmp.accept()
					else
						return cmp.show()
					end
				end,
			})
			return opts
		end,
	},
}
