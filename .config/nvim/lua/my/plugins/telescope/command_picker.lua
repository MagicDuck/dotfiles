local telescope = require('telescope')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')
local utils = require('telescope.utils')

local M = {}

function M.pickKeybindOrCommand(opts)
  if opts.mode == nil then
    error('pickKeybindOrCommand: mode is required')
  end

  local results = {}
  for _, def in pairs(my.state.keyMappings[opts.mode] or {}) do
    table.insert(results, def)
  end

  for _, def in pairs(my.state.commands) do
    table.insert(results, def)
  end

  pickers
    .new({
      results_title = 'Keymap (mode ' .. opts.mode .. ')',
      prompt_title = '',
      layout_strategy = 'vertical',
      -- winblend = 10,
      layout_config = {
        width = 0.6,
        height = 0.6,
      },
      finder = finders.new_table({
        results = results,
        entry_maker = function(def)
          if def.cmd ~= nil then
            return {
              value = def,
              ordinal = def.description .. def.cmd,
              display = '󰡛' .. def.description .. '  ♘ ' .. def.cmd,
            }
          else
            return {
              value = def,
              ordinal = def.description
                .. utils.display_termcodes(def.lhs)
                .. (type(def.rhs) == 'string' and def.rhs or 'function'),
              display = '󰡜 ' .. def.description .. '  󰡘 ' .. utils.display_termcodes(def.lhs) .. ' ',
              -- utils.display_termcodes(def.lhs) .. " -> " .. def.rhs .. ")"
            }
          end
        end,
      }),
      -- sorter = sorters.get_generic_fuzzy_sorter(),
      -- sorter = sorters.fuzzy_with_index_bias(),
      sorter = sorters.get_fzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          local def = selection.value

          if def.cmd ~= nil then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(def.cmd, true, false, true), 't', true)
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(def.lhs, true, false, true), 't', true)
          end
          return actions.close(prompt_bufnr)
        end)
        return true
      end,
    })
    :find()
end

return M
