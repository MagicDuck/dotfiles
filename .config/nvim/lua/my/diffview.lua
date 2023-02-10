local actions = require("diffview.actions")

require("diffview").setup({
  keymaps = {
    -- disable_defaults = false, -- Disable the default keymaps
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      ["<C-j>"] = actions.select_next_entry, -- Open the diff for the next file
      ["<C-k>"] = actions.select_prev_entry, -- Open the diff for the previous file
    },
    file_panel = {
      ["<C-j>"] = actions.select_next_entry,
      ["<C-k>"] = actions.select_prev_entry,
      ["[x"] = actions.prev_conflict,
      ["]x"] = actions.next_conflict,
      -- TODO (sbadragan): normal! ]cdo will put the next diff in the index buffer. Then use write! to write it out
    },
    file_history_panel = {
      ["<C-j>"] = actions.select_next_entry,
      ["<C-k>"] = actions.select_prev_entry,
    },
  },
})
