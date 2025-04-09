-- TODO (sbadragan): remove
-- vim.opt.rtp:prepend('/opt/repos/grug-far.nvim')
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
      })

      vim.keymap.set({ 'n', 'x' }, '<leader>ss', function()
        local grug = require('grug-far')
        local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
        local filters = {}
        if ext and ext ~= '' then
          table.insert(filters, '*.' .. ext)
        end

        local search = vim.fn.getreg('/')
        -- surround with \b if "word" search (such as when pressing `*`)
        if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
          search = '\\b' .. search:sub(3, -3) .. '\\b'
        end

        grug.open({
          transient = true,
          prefills = {
            search = search,
            filesFilter = table.concat(filters, '\n'),
            flags = '--hidden --glob !.git/',
          },
        })
      end, { desc = 'grug-far: Search using @/ value or visual selection' })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('grug-far-personal', { clear = true }),
        pattern = { 'grug-far' },
        callback = function()
          vim.keymap.set({ 'n' }, '<localleader>1', function()
            require('grug-far').goto_first_input()
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<localleader>2', function()
            require('grug-far').goto_input('replacement')
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<localleader>3', function()
            require('grug-far').goto_next_input()
          end, { buffer = true })
          vim.keymap.set({ 'n' }, '<localleader>4', function()
            require('grug-far').goto_prev_input()
          end, { buffer = true })
        end,
      })

      vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
        grugFar.open({ visualSelectionUsage = 'operate-within-range' })
      end, { desc = 'grug-far: Search on current file' })

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
  -- {
  --   'brenton-leighton/multiple-cursors.nvim',
  --   version = '*', -- Use the latest tagged version
  --   opts = {}, -- This causes the plugin setup function to be called
  --   keys = {
  --     -- { '<C-j>', '<Cmd>MultipleCursorsAddDown<CR>', mode = { 'n', 'x' }, desc = 'Add cursor and move down' },
  --     -- { '<C-k>', '<Cmd>MultipleCursorsAddUp<CR>', mode = { 'n', 'x' }, desc = 'Add cursor and move up' },
  --     --
  --     -- { '<C-Up>', '<Cmd>MultipleCursorsAddUp<CR>', mode = { 'n', 'i', 'x' }, desc = 'Add cursor and move up' },
  --     -- { '<C-Down>', '<Cmd>MultipleCursorsAddDown<CR>', mode = { 'n', 'i', 'x' }, desc = 'Add cursor and move down' },
  --     --
  --     -- { '<C-LeftMouse>', '<Cmd>MultipleCursorsMouseAddDelete<CR>', mode = { 'n', 'i' }, desc = 'Add or remove cursor' },
  --     --
  --     -- {
  --     --   '<Leader>m',
  --     --   '<Cmd>MultipleCursorsAddVisualArea<CR>',
  --     --   mode = { 'x' },
  --     --   desc = 'Add cursors to the lines of the visual area',
  --     -- },
  --     --
  --     -- { '<Leader>a', '<Cmd>MultipleCursorsAddMatches<CR>', mode = { 'n', 'x' }, desc = 'Add cursors to cword' },
  --     -- {
  --     --   '<Leader>A',
  --     --   '<Cmd>MultipleCursorsAddMatchesV<CR>',
  --     --   mode = { 'n', 'x' },
  --     --   desc = 'Add cursors to cword in previous area',
  --     -- },
  --
  --     {
  --       '<c-n>',
  --       '<Cmd>MultipleCursorsAddJumpNextMatch<CR>',
  --       mode = { 'n', 'x' },
  --       desc = 'Add cursor and jump to next cword',
  --     },
  --     -- { '<Leader>D', '<Cmd>MultipleCursorsJumpNextMatch<CR>', mode = { 'n', 'x' }, desc = 'Jump to next cword' },
  --     --
  --     -- { '<Leader>l', '<Cmd>MultipleCursorsLock<CR>', mode = { 'n', 'x' }, desc = 'Lock virtual cursors' },
  --   },
  -- },
}
