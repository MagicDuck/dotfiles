local M = {}

M.open = function(opts)
  if opts.mode == nil then
    error('mode is required')
  end

  local items = {}
  for _, def in pairs(my.state.keyMappings[opts.mode] or {}) do
    table.insert(items, {
      text = '󰡜 ' .. def.description .. '  󰡘 ' .. def.lhs .. ' ',
      value = def,
    })
  end

  for _, def in pairs(my.state.commands) do
    table.insert(items, {
      text = '󰡛' .. def.description .. '  ♘ ' .. def.cmd,
      value = def,
    })
  end

  Snacks.picker.pick({
    items = items,
    format = 'text',
    title = 'Bookmarks',
    layout = {
      -- preset = 'dropdown',
      preset = 'ivy',
      preview = false,
      ---@diagnostic disable-next-line: missing-fields
      layout = {
        width = 0,
      },
    },
    confirm = function(picker, item)
      picker:close()

      local def = item.value
      if def.cmd ~= nil then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(def.cmd, true, false, true), 't', true)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(def.lhs, true, false, true), 't', true)
      end
    end,
  })
end

return M
