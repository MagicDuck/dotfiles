return {
  {
    dir = '~/repos/grug-far.nvim',
    name = 'grug-far',
    lazy = false,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      local grugFar = require('grug-far')
      grugFar.setup({
        helpLine = {
          enabled = false,
        },
        engines = {
          astgrep = {
            -- path = '/Users/stephanbadragan/astgrep/sg',
          },
        },
      })

      -- local last_inputs = {}
      -- vim.keymap.set({ 'n', 'x' }, '<leader>sw', function()
      --   local prefills = vim.deepcopy(last_inputs)
      --   prefills.search = vim.fn.expand('<cword>')
      --
      --   grugFar.open({
      --     onUnload = function(instanceName)
      --       last_inputs = grugFar.get_instance_inputs(instanceName)
      --     end,
      --     prefills = prefills,
      --   })
      -- end, { desc = 'grug-far: search, using last options' })

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
