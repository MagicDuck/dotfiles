return {
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "rcarriga/cmp-dap" },
      -- { "quangnguyen30192/cmp-nvim-ultisnips" },
      { 'saadparwaiz1/cmp_luasnip' },
      { "onsails/lspkind-nvim" },
    },
    config = function()
      require('my.plugins.completion.cmp')
    end
  },

  -- {
  --   'ms-jpq/coq_nvim',
  --   branch = 'coq',
  --   lazy = false,
  --   build = ":COQdeps",
  --   dependencies = {
  --     { 'ms-jpq/coq.artifacts',  branch = 'artifacts' },
  --     { 'ms-jpq/coq.thirdparty', branch = '3p' },
  --   },
  --   init = function()
  --     -- https://github.com/ms-jpq/coq_nvim/blob/4337cb19c7bd922fa9b374456470a753dc1618d4/config/defaults.yml#L1C1-L1C1
  --     vim.g.coq_settings = {
  --       auto_start = 'shut-up',
  --       completion = {
  --         always = false,
  --         skip_after = { ';', ',', ':', '[', ']', '{', '}', ' ' },
  --       },
  --       keymap = {
  --         pre_select = true,
  --         recommended = true,
  --         -- jump_to_mark = ""
  --         -- recommended = false,
  --         -- manual_complete = '<tab>',
  --         -- jump_to_mark = '',
  --         -- bigger_preview = '',
  --       },
  --       display = {
  --         preview = {
  --           positions = { west = 3, east = 4, north = nil, south = nil }
  --         },
  --         -- pum = {
  --         --   fast_close = false,
  --         -- },
  --       },
  --     }
  --   end
  -- },
}
