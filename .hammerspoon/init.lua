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
-- TODO: add app resizing as well so we can get rid of yabai
-------------------------------------------------------------------
