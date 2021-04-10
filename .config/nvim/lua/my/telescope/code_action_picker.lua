local telescope = require("telescope")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local utils = require("telescope.utils")

local M = {}

telescope.setup {
  shorten_path = true,
  -- prompt_position = "top",
  layout_strategy = "center",
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
      n = {
        ["<esc>"] = actions.close
      }
    },
    extensions = {
      fzf_writer = {
        minimum_grep_characters = 2,
        minimum_files_characters = 2

        -- Disabled by default.
        -- Will probably slow down some aspects of the sorter, but can make color highlights.
        -- I will work on this more later.
        -- use_highlighter = true,
      }
    }
  }
}

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("fzf_writer")

function M.pickKeybind(mode)
  local results = {}
  for lhs, def in pairs(my.state.Mappings[mode] or {}) do
    table.insert(
      results,
      {
        lhs = lhs,
        rhs = def.rhs,
        description = def.description
      }
    )
  end

  pickers.new(
    {
      results_title = "Keymap (mode " .. mode .. ")",
      prompt_title = "",
      layout_strategy = "vertical",
      -- winblend = 10,
      layout_config = {
        width_padding = 0.20,
        height_padding = 0.3
      },
      finder = finders.new_table {
        results = results,
        entry_maker = function(line)
          return {
            value = line,
            ordinal = line.description ..
              utils.display_termcodes(line.lhs) .. line.rhs,
            display = line.description ..
              "    ( " ..
                utils.display_termcodes(line.lhs) .. " -> " .. line.rhs .. " )"
          }
        end
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(
          function()
            local selection = action_state.get_selected_entry()
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes(
                selection.value.lhs,
                true,
                false,
                true
              ),
              "t",
              true
            )
            return actions.close(prompt_bufnr)
          end
        )
        return true
      end
    }
  ):find()
end

M.getCodeActionFinder = function(codeActions)
  local finder =
    finders.new_table {
    results = codeActions,
    entry_maker = function(codeAction)
      return {
        value = codeAction,
        ordinal = codeAction.title,
        display = codeAction.title
      }
    end
  }

  return finder
end

M.getCodeActionPicker = function(opts)
  return pickers.new(
    {},
    {
      prompt_title = "Select Code Action",
      results_title = "Code Actions",
      layout_strategy = "vertical",
      winblend = 20,
      layout_config = {
        width_padding = 0.28,
        height_padding = 0.3
      },
      finder = M.getCodeActionFinder({}),
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.close:enhance(
          {
            post = function()
              opts.onActionPickerClose()
            end
          }
        )

        actions.select_default:replace(
          function()
            local selection = action_state.get_selected_entry()
            local action_chosen = selection.value

            local ret = actions.close(prompt_bufnr)

            -- textDocument/codeAction can return either Command[] or CodeAction[].
            -- If it is a CodeAction, it can have either an edit, a command or both.
            -- Edits should be executed first
            if action_chosen.edit or type(action_chosen.command) == "table" then
              if action_chosen.edit then
                vim.lsp.util.apply_workspace_edit(action_chosen.edit)
              end
              if type(action_chosen.command) == "table" then
                vim.lsp.buf.execute_command(action_chosen.command)
              end
            else
              vim.lsp.buf.execute_command(action_chosen)
            end

            return ret
          end
        )
        return true
      end
    }
  )
end

return M
