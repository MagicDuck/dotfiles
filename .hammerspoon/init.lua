hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-------------------------------------------------------------------
-- IPC config, so we can call hammerspoon from CLI "hs" command
-------------------------------------------------------------------
require("hs.ipc")
hs.ipc.cliInstall()

-------------------------------------------------------------------
-- constants
-------------------------------------------------------------------
local superKey = {"cmd", "alt", "ctrl", "shift"}

-------------------------------------------------------------------
-- app switching
-------------------------------------------------------------------

local function switchToApp(appName, initializeWinFn)
  local app = hs.application.get(appName)
  if (app and app:isFrontmost()) then
    --app:hide()
    local orderedWindows = hs.window.orderedWindows()
    local currentWindow = orderedWindows[1]
    for _, win in pairs(orderedWindows) do
      if
        win:application():name() ~= app:name() and
          win:screen():id() == currentWindow:screen():id()
       then
        win:focus()
        return
      end
    end
    if (orderedWindows[2]) then
      orderedWindows[2]:focus()
    end
  else
    hs.application.open(appName)
    if initializeWinFn ~= nil then
      local newWin = hs.window.frontmostWindow()
      initializeWinFn(newWin)
    end
  end
end

local function str_split_space(str)
  local parts = {}
  for i in string.gmatch(str, "%S+") do
    print(i)
    table.insert(parts, i)
  end

  return parts
end

local function kittyDo(cmd, cb)
  local task =
    hs.task.new(
    "/usr/local/bin/kitty",
    cb,
    str_split_space("@ --to unix:/tmp/mykitty " .. cmd)
  )
  task:start()
end

local function positionWindowLeftHalf(win)
  win:moveToUnit("[0,0 50x100]", 0)
end
local function positionWindowRightHalf(win)
  win:moveToUnit("[50,0 50x100]", 0)
end
local function positionWindowFullscreen(win)
  win:moveToUnit("[0,0 100x100]", 0)
end
local function positionWindowCentered(win)
  win:moveToUnit("[10,10 80x80]", 0)
end

local function closeInitialKittyWindow()
  kittyDo(
    "close-window --match=title:kitty",
    function(exitCode)
      if (exitCode ~= 0) then
        print("Could not close initial kitty window")
      end
    end
  )
end

local function switchToKittyWindow(windowTitle, windowCommand, initializeWinFn)
  local win = hs.window.frontmostWindow()
  if (win:title() == windowTitle) then
    -- window already focused, focus prev in stack
    local orderedWindows = hs.window.orderedWindows()
    if (orderedWindows[2]) then
      orderedWindows[2]:focus()
    end
    return
  end

  local function launchWindow()
    kittyDo(
      "launch --type=os-window --title=" .. windowTitle .. " " .. windowCommand,
      function(exitCode)
        if (exitCode ~= 0) then
          print(
            "Could not launch kitty window: " ..
              windowTitle .. " with command: " .. windowCommand
          )
          return
        end
        if initializeWinFn ~= nil then
          local newWin = hs.window.frontmostWindow()
          initializeWinFn(newWin)
        end
        closeInitialKittyWindow()
      end
    )
  end

  local app = hs.application.get("kitty")
  if (app == nil) then
    hs.application.open("kitty", 3) -- wait max 3s
  end

  kittyDo(
    "focus-window --match=title:" .. windowTitle,
    function(exitCode, stdout, stderr)
      print("cmd", "focus-window --match=title:" .. windowTitle)
      if (exitCode ~= 0) then
        -- not found, try launching
        launchWindow()
      end
    end
  )
end

-------------------------------------------------------------------
-- Moving between app windows
-------------------------------------------------------------------

local function table_shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

local function window_sort(w1, w2)
  return w1:id() < w2:id()
end

-- TODO: this is really slow for some reason
local function getNextAppWindow(currentWindow)
  local app = currentWindow:application()
  local allWindows = app:allWindows()

  -- get a list of sorted window ids
  local ids = {}
  for _, win in pairs(allWindows) do
    if (win:id() ~= 0) then
      table.insert(ids, win:id())
    end
  end
  table.sort(ids)

  -- get next windows id
  local currentWinIndex = -1
  for index, id in ipairs(ids) do
    if (id == currentWindow:id()) then
      currentWinIndex = index
      break
    end
  end
  local nextWinIndex = (currentWinIndex % (#ids)) + 1
  local nextWinId = ids[nextWinIndex]

  local nextWin = hs.window.find(nextWinId)
  return nextWin
end

-------------------------------------------------------------------
-- Moving windows between screens
-------------------------------------------------------------------

local function getNextScreen(win)
  local screens = hs.screen.allScreens()
  local currentScreen = win:screen()
  local currentScreenIndex = -1
  for index, screen in ipairs(screens) do
    if (screen == currentScreen) then
      currentScreenIndex = index
      break
    end
  end
  local nextScreenIndex = (currentScreenIndex % (#screens)) + 1
  return screens[nextScreenIndex]
end

-------------------------------------------------------------------
-- Key Bindings
-------------------------------------------------------------------

hs.hotkey.bind(
  superKey,
  "a",
  function()
    -- show name of application corresponding to current window
    local win = hs.window.frontmostWindow()
    hs.alert.show(win:application():name())
  end
)

-- superKey + b - cycle through windows of current app

hs.hotkey.bind(
  superKey,
  "d",
  function()
    switchToApp("Brave Browser", positionWindowFullscreen)
  end
)
-- hs.hotkey.bind(
--   superKey,
--   "e",
--   function()
--     switchToApp("IntelliJ IDEA")
--   end,
--   positionWindowFullscreen
-- )
-- hs.hotkey.bind(
--   superKey,
--   "f",
--   function()
--     switchToKittyWindow(
--       "neovim",
--       "/usr/local/bin/zsh -is eval vim",
--       positionWindowFullscreen
--     )
--   end
-- )
hs.hotkey.bind(
  superKey,
  "i",
  function()
    switchToKittyWindow(
      "gitui",
      "/usr/local/bin/zsh -is eval gitui -d ~/frontend",
      positionWindowCentered
    )
  end
)
--hs.hotkey.bind(superKey, "j", function()
--  local currentWindow = hs.window.frontmostWindow()
--  local nextWin = getNextAppWindow(currentWindow)
--  nextWin:focus()
--end)
hs.hotkey.bind(
  superKey,
  "k",
  function()
    switchToApp("Fork", positionWindowCentered)
  end
)
hs.hotkey.bind(
  superKey,
  "l",
  function()
    switchToApp("zoom.us")
  end
)
hs.hotkey.bind(
  superKey,
  "m",
  function()
    switchToApp("Mail", positionWindowFullscreen)
  end
)
hs.hotkey.bind(
  superKey,
  "n",
  function()
    switchToApp("Monosnap")
  end
)
hs.hotkey.bind(
  superKey,
  "o",
  function()
    switchToApp("Fantastical", positionWindowCentered)
  end
)
hs.hotkey.bind(
  superKey,
  "p",
  function()
    switchToApp("Finder")
  end
)
hs.hotkey.bind(
  superKey,
  "r",
  function()
    switchToApp("Google Chrome", positionWindowFullscreen)
  end
)
hs.hotkey.bind(
  superKey,
  "s",
  function()
    switchToApp("Slack", positionWindowFullscreen)
  end
)
-- hs.hotkey.bind(
--   superKey,
--   "u",
--   function()
--     switchToApp("Bear")
--   end
-- )
hs.hotkey.bind(
  superKey,
  "u",
  function()
    switchToKittyWindow(
      "notes",
      "/usr/local/bin/zsh -is eval vim +VimwikiIndex",
      positionWindowRightHalf
    )
  end
)
hs.hotkey.bind(
  superKey,
  "w",
  function()
    switchToApp("TickTick", positionWindowFullscreen)
  end
)
-- superkey + z - launches next meeting from Meeter Pro

-- hs.hotkey.bind(superKey, "return", function() switchToKittyWindow('kitty', '/usr/local/bin/zsh') end)
-- hs.hotkey.bind({"cmd"}, "return", function() switchToKittyWindow('kitty', '/usr/local/bin/zsh') end)
-- hs.hotkey.bind(
--   superKey,
--   "return",
--   function()
--     switchToApp("kitty")
--   end
-- )
-- hs.hotkey.bind(
--   {"cmd"},
--   "return",
--   function()
--     switchToApp("kitty")
--   end
-- )
hs.hotkey.bind(
  superKey,
  "e",
  function()
    switchToKittyWindow(
      "terminal",
      "/usr/local/bin/zsh -is",
      positionWindowRightHalf
    )
  end
)
hs.hotkey.bind(
  superKey,
  "space",
  function()
    switchToKittyWindow(
      "terminal",
      "/usr/local/bin/zsh -is",
      positionWindowRightHalf
    )
  end
)
hs.hotkey.bind(
  {"cmd"},
  "return",
  function()
    switchToKittyWindow(
      "terminal",
      "/usr/local/bin/zsh -is",
      positionWindowRightHalf
    )
  end
)

-- move window to other screen
hs.hotkey.bind(
  superKey,
  "[",
  function()
    local win = hs.window.frontmostWindow()
    win:moveToScreen(getNextScreen(win))
  end
)

-- move window to other screen
hs.hotkey.bind(
  superKey,
  "]",
  function()
    local win = hs.window.frontmostWindow()
    win:moveToScreen(getNextScreen(win))
  end
)

-- move window to left side of screen
hs.hotkey.bind(
  superKey,
  "left",
  function()
    local win = hs.window.frontmostWindow()
    positionWindowLeftHalf(win)
  end
)

-- move window to right side of screen
hs.hotkey.bind(
  superKey,
  "right",
  function()
    local win = hs.window.frontmostWindow()
    positionWindowRightHalf(win)
  end
)

-- maximize window
hs.hotkey.bind(
  superKey,
  "up",
  function()
    local win = hs.window.frontmostWindow()
    positionWindowFullscreen(win)
  end
)

-- centered and 80% size window
hs.hotkey.bind(
  superKey,
  "down",
  function()
    local win = hs.window.frontmostWindow()
    positionWindowCentered(win)
  end
)
