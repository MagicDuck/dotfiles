local telescope = require("telescope")
local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup({
	-- prompt_position = "top",
	defaults = {
		file_ignore_patterns = { "node_modules", "__snapshots__" },
		shorten_path = true,
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			preview_cutoff = 1, -- Preview should always show (unless previewer = false)
			prompt_position = "top",
			width = function(_, max_columns, _)
				return max_columns - 16
			end,
			height = function(_, _, max_lines)
				return max_lines - 4
			end,
			preview_height = function(_, _, max_lines)
				return math.min(max_lines - 18, math.floor((max_lines - 8) / 2))
			end,
		},
		border = true,
		color_devicons = false,
		prompt_prefix = "❯ ",
		selection_caret = "❯ ",
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-k>"] = actions.cycle_history_next,
				["<C-j>"] = actions.cycle_history_prev,
				["<C-q>"] = function(...)
					actions.send_selected_to_qflist(...)
					vim.cmd("copen")
				end,
				["<C-a>"] = actions.select_all,
				["<PageUp>"] = actions.preview_scrolling_up,
				["<PageDown>"] = actions.preview_scrolling_down,
			},
			n = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		live_grep = {
			results_title = false,
			layout_config = {
				prompt_position = "top",
			},
			mappings = {
				i = { ["<c-f>"] = actions.to_fuzzy_refine },
			},
		},
		buffers = {
			-- only_cwd = true,
			sort_mru = true,
			ignore_current_buffer = true,
			-- sort_lastused = true
		},
	},
	extensions = {
		fzf_writer = {
			minimum_grep_characters = 2,
			minimum_files_characters = 2,

			-- Disabled by default.
			-- Will probably slow down some aspects of the sorter, but can make color highlights.
			-- I will work on this more later.
			-- use_highlighter = true,
		},
		file_browser = {
			initial_mode = "normal",
		},
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			mappings = {
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					["<C-n>"] = lga_actions.quote_prompt({ postfix = " --type-add 'spec:*.spec.js' -T spec " }),
					["<C-f>"] = actions.to_fuzzy_refine,
				},
			},
			results_title = false,
			layout_config = {
				prompt_position = "top",
			},
		},
	},
})

-- telescope.load_extension("fzy_native")
telescope.load_extension("fzf")
telescope.load_extension("fzf_writer")
telescope.load_extension("ui-select")
telescope.load_extension("ultisnips")
telescope.load_extension("file_browser")
