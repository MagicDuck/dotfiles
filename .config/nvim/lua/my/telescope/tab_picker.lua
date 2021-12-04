local telescope = require("telescope")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local utils = require("telescope.utils")

local M = {}

function M.pickTab()
  local results = {}
  for i = 1, vim.fn.tabpagenr("$"), 1 do
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local winBufName = vim.fn.bufname(buflist[winnr])
    local tabName = vim.fn.fnamemodify(winBufName, ":t")

    table.insert(
      results,
      {
        tabName = tabName,
        tabIndex = i
      }
    )
  end

  pickers.new(
    {
      results_title = "Pick a tab to go to",
      prompt_title = "",
      layout_strategy = "vertical",
      -- winblend = 10,
      layout_config = {
        width = 0.6,
        height = 0.6
      },
      finder = finders.new_table {
        results = results,
        entry_maker = function(def)
          return {
            value = def,
            ordinal = def.tabName .. def.tabIndex,
            display = "♖ [" .. def.tabIndex .. "] " .. def.tabName
          }
        end
      },
      -- sorter = sorters.get_generic_fuzzy_sorter(),
      -- sorter = sorters.fuzzy_with_index_bias(),
      sorter = sorters.get_fzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(
          function()
            local selection = action_state.get_selected_entry()
            local def = selection.value

            actions.close(prompt_bufnr)

            -- go to tabIndex
            vim.cmd(def.tabIndex .. "tabnext")

            return
          end
        )
        return true
      end
    }
  ):find()
end

return M
