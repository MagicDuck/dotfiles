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
        -- showCompactInputs = true,
        -- showInputsTopPadding = false,
        -- showInputsBottomPadding = false,
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
        inst:when_ready(function()
          inst:goto_input('replacement')
        end)
      end, { desc = 'grug-far: Search using @/ register value or visual selection' })

      vim.keymap.set({ 'n', 'x' }, '<leader>sa', function()
        -- get list of unique paths corresponding to opened buffers
        local paths = {}
        local cwd = vim.fn.getcwd()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
          local buflisted = vim.api.nvim_get_option_value('buflisted', { buf = buf })
          local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf })
          local path = vim.api.nvim_buf_get_name(buf)
          if buftype == '' and buflisted and filetype ~= '' and path then
            local relpath = vim.fs.relpath(cwd, path)
            if relpath then
              table.insert(paths, vim.fn.fnameescape(relpath))
            end
          end
        end
        paths = vim.fn.uniq(vim.fn.sort(paths))

        require('grug-far').open({
          prefills = {
            paths = table.concat(paths, '\n'),
          },
        })
      end, { desc = 'grug-far: Search within opened buffers files' })
    end,
  },
}
