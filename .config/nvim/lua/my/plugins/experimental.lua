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
  inst:when_ready(function()
    inst:goto_input('replacement')
  end)
end, { desc = 'grug-far: Search using @/ register value or visual selection' })

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my-grug-far-custom-keybinds', { clear = true }),
  pattern = { 'grug-far' },
  callback = function()
    vim.keymap.set('ca', 'w', function()
      local inst = require('grug-far').get_instance(0)
      inst:sync_all()
    end, { buffer = true })
  end,
})

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
        local selection_lines = require('grug-far').get_current_visual_selection_lines(true)

        local prefills = {}
        if selection_lines == nil then
          local search = vim.fn.getreg('/')
          -- surround with \b if "word" search (such as when pressing `*`)
          if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
            search = '\\b' .. search:sub(3, -3) .. '\\b'
          elseif search and vim.startswith(search, '\\V') then
            search = search:sub(3)
          end
          prefills.search = search
        end

        local inst = require('grug-far').open({
          prefills = prefills,
        })
        inst:when_ready(function()
          inst:goto_input('replacement')
        end)
      end, { desc = 'grug-far: Search using @/ register value or visual selection' })

      vim.keymap.set({ 'n', 'x' }, '<leader>sa', function()
        ---@type grug.far.OptionsOverride
        local opts = {}
        local entry = require('grug-far').get_last_history_entry()
        if entry ~= nil then
          opts.prefills = entry
          opts.engine = entry.engine
          opts.replacementInterpreter = entry.replacementInterpreter
        end

        require('grug-far').open(opts)
      end, { desc = 'grug-far: Search within opened buffers files' })
    end,
  },
}
