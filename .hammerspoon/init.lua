hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-------------------------------------------------------------------
-- constants
-------------------------------------------------------------------
local superKey = {"cmd", "alt", "ctrl", "shift"}

-------------------------------------------------------------------
-- app switching
-------------------------------------------------------------------

local function switchToApp(appName)
  local win = hs.window.frontmostWindow()
  local currentScreen = win:screen()
  local app = hs.application.find(appName)
  if (app and app:isFrontmost()) then
    app:hide()
  else
    hs.application.open(appName)
  end
end

-------------------------------------------------------------------
-- Moving between app windows
-------------------------------------------------------------------

function table_shallow_copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function window_sort(w1, w2)
  return w1:id() < w2:id()
end

-- TODO: this is really slow for some reason
local function getNextAppWindow(currentWindow)
  local app = currentWindow:application()
  local allWindows = app:allWindows()

  -- get a list of sorted window ids
  local ids = {}
  for k, win in pairs(allWindows) do
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

hs.hotkey.bind(superKey, "a", function()
  -- show name of application corresponding to current window
  local win = hs.window.frontmostWindow()
  hs.alert.show(win:application():name())
end)

-- superKey + b - cycle through windows of current app

hs.hotkey.bind(superKey, "d", function() switchToApp('Brave Browser') end)
hs.hotkey.bind(superKey, "e", function() switchToApp('IntelliJ IDEA') end)
hs.hotkey.bind(superKey, "f", function() switchToApp('Finder') end)
hs.hotkey.bind(superKey, "i", function() switchToApp('Parallels Desktop') end)
hs.hotkey.bind(superKey, "j", function() switchToApp('kittyvim') end)
--hs.hotkey.bind(superKey, "j", function()
--  local currentWindow = hs.window.frontmostWindow()
--  local nextWin = getNextAppWindow(currentWindow)
--  nextWin:focus()
--end)
hs.hotkey.bind(superKey, "k", function() switchToApp('Fork') end)
hs.hotkey.bind(superKey, "l", function() switchToApp('zoom.us') end)
hs.hotkey.bind(superKey, "m", function() switchToApp('Mail') end)
hs.hotkey.bind(superKey, "o", function() switchToApp('Fantastical') end)
hs.hotkey.bind(superKey, "r", function() switchToApp('Google Chrome') end)
hs.hotkey.bind(superKey, "s", function() switchToApp('Slack') end)
hs.hotkey.bind(superKey, "u", function() switchToApp('Bear') end)
hs.hotkey.bind(superKey, "v", function() switchToApp('Monosnap') end)
hs.hotkey.bind(superKey, "w", function() switchToApp('TickTick') end)
-- superkey + z - launches next meeting from Meeter Pro

hs.hotkey.bind(superKey, "return", function() switchToApp('kitty') end)
hs.hotkey.bind({"cmd"}, "return", function() switchToApp('kitty') end)

-- move window to other screen
hs.hotkey.bind(superKey, "[", function()
  local win = hs.window.frontmostWindow()
  win:moveToScreen(getNextScreen(win))
end)

-- move window to other screen
hs.hotkey.bind(superKey, "]", function()
  local win = hs.window.frontmostWindow()
  win:moveToScreen(getNextScreen(win))
end)

-- move window to left side of screen
hs.hotkey.bind(superKey, "left", function()
  local win = hs.window.frontmostWindow()
  win:moveToUnit('[0,0 50x100]', 0)
end)

-- move window to right side of screen
hs.hotkey.bind(superKey, "right", function()
  local win = hs.window.frontmostWindow()
  win:moveToUnit('[50,0 50x100]', 0)
end)

-- maximize window
hs.hotkey.bind(superKey, "up", function()
  local win = hs.window.frontmostWindow()
  win:moveToUnit('[0,0 100x100]', 0)
end)

-- centered and 80% size window
hs.hotkey.bind(superKey, "down", function()
  local win = hs.window.frontmostWindow()
  win:moveToUnit('[10,10 80x80]', 0)
end)

