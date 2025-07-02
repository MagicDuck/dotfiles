---@module 'snacks'

return {
  {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      -- profiler = { enabled = true },
      -- image = { enabled = true, doc = { max_width = 200, max_height = 40 } },
    },
  },
}
