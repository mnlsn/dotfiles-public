return {
	{
		enabled = true,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {
			search = {
				forward = true,
				multi_window = false,
				wrap = false,
				incremental = true,
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},
	{
		"crusj/bookmarks.nvim",
		branch = "main",
		dependencies = { "nvim-web-devicons" },
		config = function()
			local bookmarks = require("bookmarks")
			bookmarks.setup()
			require("telescope").load_extension("bookmarks")
			vim.keymap.set("n", "<Tab><Tab>", ":Telescope bookmarks<CR>", { desc = "List all bookmarks" })
			vim.keymap.set("n", "<Tab><Tab><Tab>", bookmarks.toggle_bookmarks, { desc = "Toggle bookmarks window" })
			vim.keymap.set("n", "<leader>m", bookmarks.add_bookmarks, { desc = "add line to bookmarks" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		requires = { "nvim-lua/plenary.nvim" }, -- if harpoon requires this
		config = function()
			require("harpoon").setup({})

			local function toggle_telescope_with_harpoon(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = require("telescope.config").values.file_previewer({}),
						sorter = require("telescope.config").values.generic_sorter({}),
					})
					:find()
			end
			vim.keymap.set("n", "<leader>p", function()
				local harpoon = require("harpoon")
				toggle_telescope_with_harpoon(harpoon:list())
			end, { desc = "Open harpoon window" })
		end,
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "harpoon file",
			},
			{
				"<C-p>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon quick menu",
			},
			{
				"<leader>1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "harpoon to file 1",
			},
			{
				"<leader>2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "harpoon to file 2",
			},
			{
				"<leader>3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "harpoon to file 3",
			},
		},
	},
	{
		"telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
			"debugloop/telescope-undo.nvim",
		},
		keys = {
			{
				";p",
				function()
					require("telescope.builtin").git_files({
						hidden = true,
						follow = true,
					})
				end,
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({
						find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
					})
				end,
			},
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				";f",
				function()
					local builtin = require("telescope.builtin")
					builtin.current_buffer_fuzzy_find({
						no_ignore = false,
						hidden = true,
					})
				end,
				desc = "Fuzzy find in current buffer",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({
						additional_args = { "--hidden" },
					})
				end,
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Lists open buffers",
			},
			{
				";t",
				function()
					local builtin = require("telescope.builtin")
					builtin.help_tags()
				end,
				desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";d",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers or a specific buffer",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
			{
				";u",
				"<cmd>Telescope undo<cr>",
				desc = "undo history",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					n = {},
				},
			})
			opts.pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			}
			opts.extensions = {
				file_browser = {
					theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["n"] = {
							-- your custom normal mode mappings
							["N"] = fb_actions.create,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["<C-u>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			}

			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("undo")
		end,
	},
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
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		config = function()
			require("diffview").setup({
				diff_binaries = false,
				use_icons = true,
				file_panel = {
					width = 35,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>e", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File Browser" },
		},
	},
	{
		"simonmclean/triptych.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-tree/nvim-web-devicons", -- optional
		},
		keys = {
			{ "<leader>e", "<cmd>Triptych<cr>", desc = "Toggle triptych" },
		},
		config = function()
			require("triptych").setup({
				options = {
					show_hidden = true,
					line_numbers = {
						relative = true,
					},
				},
			})
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				mapping = { "jj" },
				timeout = vim.o.timeoutlen,
				cleaer_empty_lines = true,
				keys = "<esc>",
			})
		end,
	},
	{
		"stevearc/overseer.nvim",
		keys = {
			{ ";o", "<cmd>OverseerRun<cr>", desc = "Overseer Selection" },
			{ ";O", "<cmd>OverseerToggle<cr>", desc = "Overseer Toggle UI" },
		},
		config = function()
			require("overseer").setup()
		end,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		enabled = false,
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = function()
			local opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					fish = { "fish_indent" },
					sh = { "shfmt" },
					go = { "gofmt" },
					rust = { "rustfmt" },
					gleam = { "gleam" },
					javascript = {
						{ --[[ "prettierd", ]]
							"prettier",
						},
					},
					typescript = {
						{ --[[ "prettierd", ]]
							"prettier",
						},
					},
					javascriptreact = {
						{ --[[ "prettierd", ]]
							"prettier",
						},
					},
					typescriptreact = {
						{ --[[ "prettierd", ]]
							"prettier",
						},
					},

					css = { --[[ "prettierd", ]]
						"prettier",
					},
					scss = { "prettier" },
				},
			}
			return opts
		end,
	},
	{
		"mawkler/modicator.nvim",
		dependencies = "folke/tokyonight.nvim", -- Add your colorscheme plugin here
		init = function()
			-- These are required for Modicator to work
			vim.o.cursorline = true
			vim.o.number = true
			vim.o.termguicolors = true
		end,
		opts = {
			-- Warn if any required option above is missing. May emit false positives
			-- if some other plugin modifies them, which in that case you can just
			-- ignore. Feel free to remove this line after you've gotten Modicator to
			-- work properly.
			show_warnings = false,
		},
	},
}
