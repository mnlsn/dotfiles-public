return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = { light = "frappe", dark = "mocha" },
				color_overrides = {
					all = {
						-- base = "#08090d",
					},
				},
				transparent_background = false,
				integrations = {
					cmp = true,
					treesitter = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					harpoon = true,
					mason = true,
					noice = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
					telescope = { enabled = true },
					lsp_trouble = true,
					which_key = true,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			style = "night",
			light_style = "day",
			on_highlights = function(hl, colors)
				hl.CursorLine = {
					bg = colors.bg_dark, --string
				}
			end,
		},
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		opts = { transparent_bg = false },
	},
	{
		"NLKNguyen/papercolor-theme",
		lazy = false,
		priority = 1000,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "folke/lsp-colors.nvim", lazy = false, priority = 1000 },
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				background = "hard",
				ui_contrast = "high",
			})
		end,
	},
	{ "sainnhe/sonokai", lazy = false, priority = 1000 },
	{ "sainnhe/edge", lazy = false, priority = 1000 },
	{ "sainnhe/gruvbox-material", lazy = false, priority = 1000 },
}
