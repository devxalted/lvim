return {
	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
				["<CR>"] = { "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-Space>"] = { "select_and_accept", "show", "fallback" },
			})
			opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
				list = {
					selection = {
						preselect = false,
					},
				},
			})
			return opts
		end,
	},
}
