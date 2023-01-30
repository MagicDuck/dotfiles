local actions = require "fzf-lua.actions"

require('fzf-lua').setup({
  winopts = {
    height  = 0.90,
    width   = 0.90,
    preview = {
      layout   = 'vertical',
      vertical = 'up:50%',
    }
  },
  keymap = {
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"] = "abort",
      -- ["ctrl-u"]    = "unix-line-discard",
      ["ctrl-j"] = "half-page-down",
      ["ctrl-k"] = "half-page-up",
      -- ["ctrl-a"] = "beginning-of-line",
      -- ["ctrl-e"] = "end-of-line",
      ["ctrl-a"] = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      -- ["f3"]          = "toggle-preview-wrap",
      -- ["f4"]          = "toggle-preview",
      -- ["shift-down"]  = "preview-page-down",
      -- ["shift-up"]    = "preview-page-up",
    },
    -- These override the default tables completely
    -- delete or modify is sufficient
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<C-h>"]      = "toggle-help",
      -- ["<F2>"]       = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      -- ["<F3>"]       = "toggle-preview-wrap",
      -- ["<F4>"]       = "toggle-preview",
      -- page preview
      ["<PageDown>"] = "preview-page-down",
      ["<PageUp>"]   = "preview-page-up",
      -- ["<S-left>"] = "preview-page-reset",
    }
  },
  -- see https://github.com/junegunn/fzf/wiki/Color-schemes#color-configuration
  fzf_colors = {
    ["fg"]      = { "fg", "Normal" },
    ["bg"]      = { "bg", "Normal" },
    ["hl"]      = { "fg", "Comment" },
    ["fg+"]     = { "fg", "Normal" },
    ["bg+"]     = { "bg", "FzfLuaCurrentLine" },
    ["hl+"]     = { "fg", "Statement" },
    -- ["info"]    = { "fg", "PreProc" },
    -- ["prompt"]  = { "fg", "Conditional" },
    ["pointer"] = { "fg", "Normal" },
    ["marker"]  = { "fg", "Keyword" },
    -- ["spinner"] = { "fg", "Label" },
    -- ["header"]  = { "fg", "Comment" },
    ["gutter"]  = { "bg", "Normal" },
  },
})

