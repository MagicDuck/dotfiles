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
  local app = hs.application.find(appName)
  if (app and app:isFrontmost()) then
    app:hide()
  else
    hs.application.open(appName)
  end
end

-- show name of application corresponding to current window
hs.hotkey.bind(superKey, "a", function()
  local win = hs.window.focusedWindow()
  hs.alert.show(win:application():name())
end)

hs.hotkey.bind(superKey, "d", function() switchToApp('Brave Browser') end)
hs.hotkey.bind(superKey, "e", function() switchToApp('IntelliJ IDEA') end)
hs.hotkey.bind(superKey, "i", function() switchToApp('Parallels Desktop') end)
hs.hotkey.bind(superKey, "j", function() switchToApp('TickTick') end)
hs.hotkey.bind(superKey, "k", function() switchToApp('Fork') end)
hs.hotkey.bind(superKey, "l", function() switchToApp('zoom.us') end)
hs.hotkey.bind(superKey, "m", function() switchToApp('Monosnap') end)
hs.hotkey.bind(superKey, "o", function() switchToApp('Microsoft Outlook') end)
hs.hotkey.bind(superKey, "r", function() switchToApp('Google Chrome') end)
hs.hotkey.bind(superKey, "s", function() switchToApp('Slack') end)
hs.hotkey.bind(superKey, "u", function() switchToApp('Bear') end)
hs.hotkey.bind(superKey, "return", function() switchToApp('kitty') end)
hs.hotkey.bind({"cmd"}, "return", function() switchToApp('kitty') end)


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

hs.hotkey.bind(superKey, "[", function()
  local win = hs.window.focusedWindow()
  win:moveToScreen(getNextScreen(win))
end)

hs.hotkey.bind(superKey, "]", function()
  local win = hs.window.focusedWindow()
  win:moveToScreen(getNextScreen(win))
end)


-------------------------------------------------------------------
-- Window position/resizing
-------------------------------------------------------------------

hs.hotkey.bind(superKey, "left", function()
  local win = hs.window.focusedWindow()
  win:moveToUnit('[0,0 50x100]', 0)
end)

hs.hotkey.bind(superKey, "right", function()
  local win = hs.window.focusedWindow()
  win:moveToUnit('[50,0 50x100]', 0)
end)

hs.hotkey.bind(superKey, "up", function()
  local win = hs.window.focusedWindow()
  win:moveToUnit('[0,0 100x100]', 0)
end)

hs.hotkey.bind(superKey, "down", function()
  local win = hs.window.focusedWindow()
  win:moveToUnit('[10,10 80x80]', 0)
end)
