local telescope = require('telescope')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')
local utils = require('telescope.utils')

local M = {}

function M.pickBookmark(command, bookmarks)
  if bookmarks == nil then
    error('pickBookmark: bookmarks are required')
  end

  local results = {}
  for _, bookmark in pairs(bookmarks) do
    local path
    if type(bookmark) == 'table' then
      path = bookmark[2]
    else
      path = bookmark
    end
    table.insert(results, { path = path })
  end

  pickers
    .new({
      results_title = 'Bookmarks',
      prompt_title = '',
      layout_strategy = 'vertical',
      -- winblend = 10,
      layout_config = {
        width = 0.6,
        height = 0.6,
      },
      finder = finders.new_table({
        results = results,
        entry_maker = function(bookmark)
          return {
            value = bookmark,
            ordinal = bookmark.path,
            display = ' ♙ ' .. bookmark.path,
          }
        end,
      }),
      -- sorter = sorters.get_generic_fuzzy_sorter(),
      -- sorter = sorters.fuzzy_with_index_bias(),
      sorter = sorters.get_fzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          local bookmark = selection.value

          actions.close(prompt_bufnr)

          vim.cmd(command .. ' ' .. bookmark.path)
          if vim.fn.isdirectory(vim.fn.expand(bookmark.path)) > 0 then
            vim.cmd.lchdir({ args = { bookmark.path }, mods = { silent = true } })
          end
        end)
        return true
      end,
    })
    :find()
end

return M
