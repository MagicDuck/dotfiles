local M = {}

-------------------------------------------------------------------
-- Positioning/sizing windows
-------------------------------------------------------------------

function M.positionCurrentWindowLeftHalf()
	hs.window.frontmostWindow():moveToUnit("[0,0 50x100]", 0)
end
function M.positionCurrentWindowRightHalf()
	hs.window.frontmostWindow():moveToUnit("[50,0 50x100]", 0)
end
function M.positionCurrentWindowFullscreen()
	hs.window.frontmostWindow():moveToUnit("[0,0 100x100]", 0)
end
function M.positionCurrentWindowCentered()
	hs.window.frontmostWindow():moveToUnit("[10,10 80x80]", 0)
end

-------------------------------------------------------------------
-- Moving between app windows
-------------------------------------------------------------------

local function getNextAppWindow(currentWindow)
	local allWindows = hs.fnutils.filter(currentWindow:application():allWindows(), function(w)
		return w:id() ~= 0
	end)
	-- sort by window id
	table.sort(allWindows, function(a, b)
		return a:id() < b:id()
	end)
	local win = hs.fnutils.find(allWindows, function(w)
		return currentWindow:id() == w:id()
	end)
	local currentWinIndex = hs.fnutils.indexOf(allWindows, win) or -1

	local nextWinIndex = (currentWinIndex % #allWindows) + 1
	local nextWin = allWindows[nextWinIndex]

	return nextWin
end

function M.focusNextAppWindow()
	local currentWindow = hs.window.frontmostWindow()
	local nextWindow = getNextAppWindow(currentWindow)
	nextWindow:focus()
end

-------------------------------------------------------------------
-- Moving windows between screens
-------------------------------------------------------------------

local function getNextScreen(win, increment)
	local screens = hs.screen.allScreens()
	local currentScreen = win:screen()
	local currentScreenIndex = -1
	for index, screen in ipairs(screens) do
		if screen == currentScreen then
			currentScreenIndex = index
			break
		end
	end
	local nextScreenIndex = ((currentScreenIndex - 1 + increment) % #screens) + 1
	return screens[nextScreenIndex]
end

function M.moveCurrentWindowToNextScreen()
	local currentWindow = hs.window.frontmostWindow()
	currentWindow:moveToScreen(getNextScreen(currentWindow, 1))
end

function M.moveCurrentWindowToPrevScreen()
	local currentWindow = hs.window.frontmostWindow()
	currentWindow:moveToScreen(getNextScreen(currentWindow, -1))
end

return M

-- old stuff just in case
-- local function switchToApp(appName, initializeWinFn)
-- 	local app = hs.application.get(appName)
-- 	if app then
-- 		if app:isFrontmost() then
-- 			--app:hide()
-- 			local orderedWindows = hs.window.orderedWindows()
-- 			local currentWindow = orderedWindows[1]
-- 			for _, win in pairs(orderedWindows) do
-- 				if win:application():name() ~= app:name() and win:screen():id() == currentWindow:screen():id() then
-- 					win:focus()
-- 					return
-- 				end
-- 			end
-- 			if orderedWindows[2] then
-- 				orderedWindows[2]:focus()
-- 			end
-- 		else
-- 			hs.application.open(appName)
-- 		end
-- 	else
-- 		hs.application.open(appName, 2, true)
-- 		if initializeWinFn ~= nil then
-- 			local newWin = hs.window.frontmostWindow()
-- 			initializeWinFn(newWin)
-- 		end
-- 	end
-- end
