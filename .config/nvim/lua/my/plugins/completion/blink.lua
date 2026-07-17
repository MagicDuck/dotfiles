return {
  'saghen/blink.cmp',
  -- lazy = false, -- lazy loading handled internally
  lazy = true,
  dependencies = { 'rafamadriz/friendly-snippets' },

  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = 'rounded' } },
      menu = { border = 'rounded' },
    },
    signature = { enabled = true, window = { border = 'single' } },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    keymap = {
      preset = 'super-tab',
      ['<end>'] = { 'snippet_forward', 'fallback' },
      ['<home>'] = { 'snippet_backward', 'fallback' },

      --   ['<C-d>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
      --   ['<Up>'] = { 'select_prev', 'fallback' },
      --   ['<Down>'] = { 'select_next', 'fallback' },
      --
      ['<pageup>'] = { 'scroll_documentation_up', 'fallback' },
      ['<pagedown>'] = { 'scroll_documentation_down', 'fallback' },
    },
  },
}
