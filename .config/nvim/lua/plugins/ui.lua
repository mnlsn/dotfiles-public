return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						-- '.git',
						-- '.DS_Store',
						-- 'thumbs.db',
					},
					never_show = {},
				},
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				-- your configuration comes here
				view_options = {
					show_hidden = true,
				},
				float = {
					max_width = 60,
					max_height = 30,
				},
				columns = {
					"icon",
					"size",
				},
			})
		end,
		keys = {
			{ "=", "<CMD>Oil --float <CR>", desc = "Open parent directory" },
		},
	},
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
		config = function(plugin, opts)
			local notify = require("notify")
			opts.background_colour = "#181825"
			notify.setup(opts)
		end,
	},

	-- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				-- globalstatus = false,
				theme = "auto",
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
  ███▄    █ ▓█████  ██▓      ██████  ▒█████   ███▄    █ 
 ██ ▀█   █ ▓█   ▀ ▓██▒    ▒██    ▒ ▒██▒  ██▒ ██ ▀█   █ 
▓██  ▀█ ██▒▒███   ▒██░    ░ ▓██▄   ▒██░  ██▒▓██  ▀█ ██▒
▓██▒  ▐▌██▒▒▓█  ▄ ▒██░      ▒   ██▒▒██   ██░▓██▒  ▐▌██▒
▒██░   ▓██░░▒████▒░██████▒▒██████▒▒░ ████▓▒░▒██░   ▓██░
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▓  ░▒ ▒▓▒ ▒ ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒ 
░ ░░   ░ ▒░ ░ ░  ░░ ░ ▒  ░░ ░▒  ░ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░
   ░   ░ ░    ░     ░ ░   ░  ░  ░  ░ ░ ░ ▒     ░   ░ ░ 
         ░    ░  ░    ░  ░      ░      ░ ░           ░ 

]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
}
