local is_linux = vim.fn.has('linux') == 1

return {
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    enabled = false,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'rcarriga/cmp-dap' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'onsails/lspkind-nvim' },
    },
    config = function()
      require('my.plugins.completion.cmp')
    end,
  },

  {
    'chrisgrieser/nvim-scissors',
    opts = {
      snippetDir = vim.fn.stdpath('config') .. '/snippets',
      editSnippetPopup = {
        keymaps = {
          deleteSnippet = is_linux and '<c-bs>' or '<a-bs>',
          showHelp = '?',
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
      },

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

      opts_extend = { 'sources.default' },

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
  },
}
