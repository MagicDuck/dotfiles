require("todo").setup({
	merge_keywords = false,
	keywords = {
		TODO = { icon = " ", color = "todo" },
	},
	highlight = {
		-- highlights before the keyword (typically comment characters)
		before = "", -- "fg", "bg", or empty
		-- highlights of the keyword
		-- wide is the same as bg, but also highlights the colon
		keyword = "fg", -- "fg", "bg", "wide", or empty
		-- highlights after the keyword (TODO text)
		after = "", -- "fg", "bg", or empty
		-- pattern can be a string, or a table of regexes that will be checked
		-- vim regex
		pattern = [[.*<(KEYWORDS) \(sbadragan\)\s*:]],
		comments_only = true, -- highlight only inside comments using treesitter
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	},
	-- list of named colors
	-- a list of hex colors or highlight groups, will use the first available one in the list on RHS
	colors = {
		todo = { "MyTodo" },
		default = { "Identifier", "#7C3AED" },
	},
	search = {
		-- don't replace the (KEYWORDS) placeholder
		pattern = [[\b(KEYWORDS) \(sbadragan\):]], -- ripgrep regex
	},
})
