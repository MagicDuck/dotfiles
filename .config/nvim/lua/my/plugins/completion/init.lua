return {
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
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

  -- {
  --   'saghen/blink.cmp',
  --   lazy = false, -- lazy loading handled internally
  --   -- optional: provides snippets for the snippet source
  --   dependencies = 'rafamadriz/friendly-snippets',
  --
  --   -- use a release tag to download pre-built binaries
  --   version = 'v0.*',
  --   -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --
  --   opts = {
  --     highlight = {
  --       -- sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- useful for when your theme doesn't support blink.cmp
  --       -- will be removed in a future release, assuming themes add support
  --       use_nvim_cmp_as_default = true,
  --     },
  --     -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --     -- adjusts spacing to ensure icons are aligned
  --     nerd_font_variant = 'normal',
  --
  --     -- experimental auto-brackets support
  --     -- accept = { auto_brackets = { enabled = true } },
  --
  --     -- experimental signature help support
  --     trigger = { signature_help = { enabled = true } },
  --     keymap = {
  --       show = '<C-space>',
  --       hide = '<C-e>',
  --       accept = '<Tab>',
  --       select_prev = { '<Up>' },
  --       select_next = { '<Down>' },
  --
  --       show_documentation = {},
  --       hide_documentation = {},
  --       scroll_documentation_up = '<pageup>',
  --       scroll_documentation_down = '<pagedown>',
  --
  --       snippet_forward = '<end>',
  --       snippet_backward = '<home>',
  --     },
  --   },
  -- },
}
