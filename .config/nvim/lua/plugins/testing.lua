return {
	{
		"David-Kunz/jester",
		keys = {
			{
				"<leader>tc",
				":lua require('jester').run()<CR>",
				desc = "Run Jest test under cursor",
			},
			{
				"<leader>tf",
				":lua require('jester').run_file()<CR>",
				desc = "Run Jest test file",
			},
		},
	},
}
