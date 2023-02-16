local M = {}

--------------------------------------------------------------------------------
-- Summon App / Toggle App Visibility
--------------------------------------------------------------------------------

local currentlyFocusedWindow
local currentlyFocusedAppName
local lastFocusedWindow

function M.init()
  currentlyFocusedWindow = hs.window.focusedWindow() or hs.window.frontmostWindow()
  currentlyFocusedAppName = currentlyFocusedWindow and currentlyFocusedWindow:application():name() or nil
  lastFocusedWindow = nil
end

local function updateFocusState(window)
  if currentlyFocusedWindow == nil or (window:id() ~= currentlyFocusedWindow:id()) then
    lastFocusedWindow = currentlyFocusedWindow
    currentlyFocusedWindow = window
    currentlyFocusedAppName = window:application():name()
    print('-- Focused: (App: "' .. currentlyFocusedAppName .. '", Window: "' .. window:title() .. '")')
    -- if lastFocusedWindow and window:title() == "Peek preview" and currentlyFocusedAppName == "deno" then
    --   local prevWin = lastFocusedWindow
    --   local previewWin = currentlyFocusedWindow
    --   print("--gets here");
    --
    --   prevWin:focus()
    --   previewWin:raise()
    -- end
  end
end

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, updateFocusState)

-- hs.window.filter.default:subscribe(hs.window.filter.windowUnfocused, function(window, appName)
-- 	lastFocusedWindow = window
-- 	-- print('-- Last Focused Window: "' .. window:title() .. '"')
-- end)

local function launchOrFocusWindow(app, window)
  local win = app:findWindow(window.title)
  if win == nil then
    if window.launch ~= nil then
      window.launch()
    end
  else
    win:focus()
    updateFocusState(win)
  end
end

function M.focusPrevWindow()
  if lastFocusedWindow == nil then
    currentlyFocusedWindow:application():hide()
  else
    lastFocusedWindow:focus()
    updateFocusState(lastFocusedWindow)
  end
end

function M.summon(appName, window)
  -- print(
  -- 	"-- summoning '"
  -- 		.. appName
  -- 		.. "' ,currently focuseed: '"
  -- 		.. (currentlyFocusedAppName or "nil")
  -- 		.. "', cur win title:"
  -- 		.. currentlyFocusedWindow:title()
  -- 		.. ", last focused win:",
  -- 	(lastFocusedWindow or "nil")
  -- )
  if appName ~= currentlyFocusedAppName then
    local app = hs.application.get(appName)
    local wasAlreadyOpened = false
    if app == nil then
      app = hs.application.open(appName)
      wasAlreadyOpened = true
    end
    if window == nil then
      if not wasAlreadyOpened then
        hs.application.open(appName)
      end
    else
      launchOrFocusWindow(app, window)
    end
  else
    if window == nil then
      M.focusPrevWindow()
    else
      if currentlyFocusedWindow:title() == window.title then
        M.focusPrevWindow()
      else
        local app = hs.application.get(appName)
        launchOrFocusWindow(app, window)
      end
    end
  end
end

return M
