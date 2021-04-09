local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", {silent=true, noremap=true})

vim.g.nvim_tree_bindings = {
  -- ["u"] = ":lua require'some_module'.some_function()<cr>",

  -- default mappings
  -- ["<CR>"]           = tree_cb("edit"),
  -- ["o"]              = tree_cb("edit"),
  -- ["<2-LeftMouse>"]  = tree_cb("edit"),
  -- ["<2-RightMouse>"] = tree_cb("cd"),
  -- ["<C-]>"]          = tree_cb("cd"),
  -- ["<C-v>"]          = tree_cb("vsplit"),
  -- ["<C-x>"]          = tree_cb("split"),
  -- ["<C-t>"]          = tree_cb("tabnew"),
    ["<BS>"]           = "",
  -- ["<S-CR>"]         = tree_cb("close_node"),
  -- ["<Tab>"]          = tree_cb("preview"),
  -- ["I"]              = tree_cb("toggle_ignored"),
  -- ["H"]              = tree_cb("toggle_dotfiles"),
  -- ["R"]              = tree_cb("refresh"),
  -- ["a"]              = tree_cb("create"),
  -- ["d"]              = tree_cb("remove"),
  -- ["r"]              = tree_cb("rename"),
  -- ["<C-r>"]          = tree_cb("full_rename"),
  -- ["x"]              = tree_cb("cut"),
  -- ["c"]              = tree_cb("copy"),
  -- ["p"]              = tree_cb("paste"),
  -- ["[c"]             = tree_cb("prev_git_item"),
  -- ["]c"]             = tree_cb("next_git_item"),
  -- ["-"]              = tree_cb("dir_up"),
  -- ["q"]              = tree_cb("close"),
}
