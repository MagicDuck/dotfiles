local geo = {}
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
  --   dir = '~/repos/blink.cmp/',
  --   name = 'blink.cmp',
  --   -- 'saghen/blink.cmp',
  --   lazy = false, -- lazy loading handled internally
  --   dependencies = 'rafamadriz/friendly-snippets',
  --
  --   -- use a release tag to download pre-built binaries
  --   version = '*',
  --   -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     highlight = {
  --       -- sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- useful for when your theme doesn't support blink.cmp
  --       -- will be removed in a future release, assuming themes add support
  --       use_nvim_cmp_as_default = false,
  --     },
  --     -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --     -- adjusts spacing to ensure icons are aligned
  --     nerd_font_variant = 'normal',
  --
  --     -- experimental auto-brackets support
  --     -- accept = { auto_brackets = { enabled = true } },
  --
  --     -- experimental signature help support
  --     trigger = {
  --       signature_help = { enabled = false },
  --       completion = {
  --         show_in_snippet = true,
  --       },
  --     },
  --
  --     windows = {
  --       autocomplete = {
  --         border = 'rounded',
  --         winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:PmenuSel,Search:None',
  --       },
  --       ghost_text = {
  --         enabled = false,
  --       },
  --     },
  --
  --     sources = {
  --       completion = {
  --         -- remember to enable your providers here
  --         enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
  --       },
  --     },
  --
  --     keymap = {
  --       ['<C-d>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
  --       ['<C-e>'] = { 'hide' },
  --
  --       -- TODO: probably change this
  --       -- ['<Tab>'] = {
  --       --   function(cmp)
  --       --     if cmp.is_in_snippet() then
  --       --       return cmp.accept()
  --       --     else
  --       --       return cmp.select_and_accept()
  --       --     end
  --       --   end,
  --       --   'snippet_forward',
  --       --   'fallback',
  --       -- },
  --       -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --       ['<Tab>'] = {
  --         function(cmp)
  --           if cmp.is_in_snippet() then
  --             return cmp.accept()
  --           else
  --             return cmp.select_and_accept()
  --           end
  --         end,
  --         'fallback',
  --       },
  --       ['<end>'] = { 'snippet_forward', 'fallback' },
  --       ['<home>'] = { 'snippet_backward', 'fallback' },
  --
  --       ['<Up>'] = { 'select_prev', 'fallback' },
  --       ['<Down>'] = { 'select_next', 'fallback' },
  --       ['<C-p>'] = { 'select_prev', 'fallback' },
  --       ['<C-n>'] = { 'select_next', 'fallback' },
  --
  --       ['<pageup>'] = { 'scroll_documentation_up', 'fallback' },
  --       ['<pagedown>'] = { 'scroll_documentation_down', 'fallback' },
  --     },
  --   },
  -- },
}
