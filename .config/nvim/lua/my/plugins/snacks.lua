---@module 'snacks'

return {
  {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
    },
  },
}
