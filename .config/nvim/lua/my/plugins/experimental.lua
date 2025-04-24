-- for setup-less loading
-- vim.opt.rtp:prepend('/opt/repos/grug-far.nvim')
return {
  {
    dir = '~/repos/grug-far.nvim',
    name = 'grug-far',
    lazy = false,
    config = function()
      local grugFar = require('grug-far')
      grugFar.setup({
        helpLine = {
          enabled = false,
        },
      })

      vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
        grugFar.open({ visualSelectionUsage = 'operate-within-range' })
      end, { desc = 'grug-far: Search inside current range' })

      vim.keymap.set({ 'n', 'x' }, '<leader>sp', function()
        grugFar.open({
          prefills = {
            paths = vim.fn.expand('%'),
          },
        })
      end, { desc = 'grug-far: Search in current file path' })
    end,
  },
}
