local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
  shorten_path = true,
  -- prompt_position = "top",
  layout_strategy = "center",
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
      n = {
        ["<esc>"] = actions.close
      }
    },
    extensions = {
      fzf_writer = {
        minimum_grep_characters = 2,
        minimum_files_characters = 2

        -- Disabled by default.
        -- Will probably slow down some aspects of the sorter, but can make color highlights.
        -- I will work on this more later.
        -- use_highlighter = true,
      }
    }
  }
}

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("fzf_writer")
