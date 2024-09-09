return {
  {
    dir = '/opt/repos/grug-far.nvim',
    name = 'grug-far',
    lazy = false,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      local grugFar = require('grug-far')
      grugFar.setup({
        keymaps = {
          -- openNextLocation = { n = '<down>' },
          -- openPrevLocation = { n = '<up>' },
        },
        -- searchOnInsertLeave = true,
        -- engine = 'astgrep',
        -- engines = {
        --   astgrep = {
        --     path = '/Users/stephanbadragan/astgrep/sg',
        --   },
        -- },
      })

      vim.keymap.set({ 'n', 'x' }, '<leader>sw', function()
        grugFar.open({
          prefills = {
            paths = vim.fn.expand('%'),
          },
        })
      end, { desc = 'grug-far: Search on current file' })

      local gfInstance
      local count = 1
      vim.keymap.set('n', '<leader>sg', function()
        local prefills = {
          search = 'something ' .. count .. '\nother thing',
          replacement = 'replacement\nrep2\nrep3',
          filesFilter = 'filesFilter\nf2\nf3',
          flags = 'flags\nflgs2\nflags3',
          paths = 'paths\np1\np2',
        }
        -- local prefills = { search = 'grug', replacement = 'curly' }

        if not grugFar.has_instance(gfInstance) then
          gfInstance = grugFar.open({ prefills = prefills })
        else
          grugFar.open_instance(gfInstance)
          grugFar.update_instance_prefills(gfInstance, prefills, true)
        end

        count = count + 1
      end)
    end,
  },
}
