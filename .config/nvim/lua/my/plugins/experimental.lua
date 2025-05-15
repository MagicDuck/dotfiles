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

      --- testing stuff
      vim.keymap.set({ 'n', 'x' }, '<leader>ss', function()
        local search = vim.fn.getreg('/')
        -- surround with \b if "word" search (such as when pressing `*`)
        if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
          search = '\\b' .. search:sub(3, -3) .. '\\b'
        end
        local inst = require('grug-far').open({
          prefills = {
            search = search,
          },
        })
        inst:goto_input('replacement')
      end, { desc = 'grug-far: Search using @/ register value or visual selection' })
    end,
  },
}
