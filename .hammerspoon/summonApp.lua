local M = {}

--------------------------------------------------------------------------------
-- Summon App / Toggle App Visibility
--------------------------------------------------------------------------------

local currentlyFocusedAppName
local currentlyFocusedWindow
local lastFocusedWindow
-- local initializeWinFn = {}

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
	currentlyFocusedWindow = window
	currentlyFocusedAppName = appName
	-- print('-- Focused: (App: "' .. appName .. '", Window: "' .. window:title() .. '")')
end)

hs.window.filter.default:subscribe(hs.window.filter.windowUnfocused, function(window, appName)
	lastFocusedWindow = window
	-- print('-- Last Focused Window: "' .. window:title() .. '"')
end)

-- hs.application.watcher.new(function(appName, eventType, app)
-- 	print("event type", eventType, appName)
-- 	if eventType == hs.application.watcher.launched then
-- 		print("app launched", appName)
-- 		if initializeWinFn[appName] ~= nil then
-- 			print("initing main window for", appName)
-- 			initializeWinFn[appName](app:mainWindow())
-- 		end
-- 	end
-- end):start()

function M.summon(appName, initWinFn)
	-- initializeWinFn[appName] = initWinFn
	print("-- summoning '" .. appName .. "' ,currently focuseed: '" .. (currentlyFocusedAppName or "nil") .. "'")
	-- if currentlyFocusedAppName == appName and not next(hs.application.find(appName):allWindows()) then
	-- 	hs.application.open(appName)
	if currentlyFocusedAppName ~= appName then
		hs.application.open(appName)
	else
		if lastFocusedWindow then
			lastFocusedWindow:focus()
		else
			currentlyFocusedWindow:application():hide()
		end
	end
end

return M
