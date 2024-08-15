local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

local function spawn_tab_with(window, tabName, cmds, dir, suspend_last)
  local newTab, newPane = window:mux_window():spawn_tab({
    args = { "zsh", "-i" },
  })
  newTab:set_title(tabName)
  if dir then
    newPane:send_text("cd " .. dir .. "\n")
  end
  if cmds then
    for i, cmd in ipairs(cmds) do
      local suspend = i == #cmds and suspend_last
      newPane:send_text(cmd .. (suspend and "" or "\n"))
    end
  end

  return newTab, newPane
end

local choices = {
  {
    label = "vim",
    cb = function(window)
      spawn_tab_with(window, "vim", {
        "vim",
      })
    end,
  },
  {
    label = "frontend-dev",
    cb = function(window)
      local dir = "/opt/repos/frontend"
      spawn_tab_with(window, "misc", {}, dir)
      local vimTab = spawn_tab_with(window, "vim", {
        "vim src/Application/ApplicationShell/ApplicationShell.jsx",
      }, dir)
      spawn_tab_with(window, "webpack", {
        "pnpm dev",
      }, dir)

      vimTab:activate()
    end,
  },
  {
    label = "frontend-webpack",
    cb = function(window)
      local dir = "/opt/repos/frontend"
      spawn_tab_with(window, "frontend-webpack", {
        "pnpm dev",
      }, dir)
    end,
  },
  {
    label = "frontend-test-changed",
    cb = function(window)
      local dir = "/opt/repos/frontend"
      spawn_tab_with(window, "frontend-test-changed", {
        "pnpm react-ui:test -- --changedSince=origin/main",
      }, dir)
    end,
  },
  {
    label = "frontend-test",
    cb = function(window)
      spawn_tab_with(window, "frontend-test", {}, "/opt/repos/frontend/reactUi")
    end,
  },
  {
    label = "ondemand",
    cb = function(window)
      spawn_tab_with(window, "ondemand", {}, "/opt/repos/ondemand")
    end,
  },
  -- {
  --   label = "qmk flash dactyl",
  --   cb = function(window)
  --     spawn_tab_with(window, "qmk-flash-dactyl", {
  --       "cd /opt/repos/qmk_firmware",
  --       "qmk-flash-dactyl",
  --     })
  --   end,
  -- },
  {
    label = "qmk flash cyboard",
    cb = function(window)
      spawn_tab_with(window, "qmk-flash-cyboard", {
        "cd /opt/repos/vial-qmk",
        "qmk-flash-cyboard",
      })
    end,
  },
  {
    label = "vim-diff",
    cb = function(window)
      spawn_tab_with(window, "vim-diff", {
        "vim -c 'enew | vsplit | enew |' -c diffthis -c 'startinsert | wincmd h | startinsert'",
      })
    end,
  },
  {
    label = "grug-far-dev",
    cb = function(window)
      local dir = "/opt/repos/grug-far.nvim"

      spawn_tab_with(window, "misc", {}, dir)
      local vimTab = spawn_tab_with(window, "vim", {
        "vim lua/grug-far.lua",
      }, dir)
      spawn_tab_with(window, "live_test", {
        "vim -c GrugFar",
      }, dir, true)
      spawn_tab_with(window, "unit_test", {
        "make test file=tests/test_history.lua update_screenshots=true",
      }, dir, true)

      vimTab:activate()
    end,
  },
}

M.get_choices = function()
  local cs = {}
  for i, choice in ipairs(choices) do
    table.insert(cs, { label = choice.label, id = "" .. i })
  end

  return cs
end

M.invoke_cb = function(window, pane, id)
  choices[tonumber(id)].cb(window, pane)
end

return M
