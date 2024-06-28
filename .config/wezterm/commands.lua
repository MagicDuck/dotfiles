local M = {}

local function spawn_tab_with(window, tabName, cmds, dir)
  local newTab, newPane = window:mux_window():spawn_tab({
    args = { "zsh", "-i" },
  })
  newTab:set_title(tabName)
  if dir then
    newPane:send_text("cd " .. dir .. "\n")
  end
  if cmds then
    for _, cmd in ipairs(cmds) do
      newPane:send_text(cmd .. "\n")
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
      spawn_tab_with(window, "scratch", {}, dir)
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
  {
    label = "qmk flash dactyl",
    cb = function(window)
      spawn_tab_with(window, "qmk-flash-dactyl", {
        "cd /opt/repos/qmk_firmware",
        "qmk-flash-dactyl",
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
