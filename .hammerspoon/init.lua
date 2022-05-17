hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- window accessibility api timeout - messes up window switching
-- hs.window.timeout(0.05)

-------------------------------------------------------------------
-- Local config
-------------------------------------------------------------------
local localConfig = require("./localConfig")

-------------------------------------------------------------------
-- IPC config, so we can call hammerspoon from CLI "hs" command
-------------------------------------------------------------------
require("hs.ipc")
hs.ipc.cliInstall()

-------------------------------------------------------------------
-- Network, auto-switch WIFI off when wired is on and vice-versa
-------------------------------------------------------------------
local network = require("./network")
network.setEthernetInterfaceName("AX88179A")
local networkWatcher = hs.network.configuration.open()
networkWatcher:monitorKeys()
networkWatcher:setCallback(network.handleNetworkChange)
networkWatcher:start()

-------------------------------------------------------------------
-- Gitlab
-------------------------------------------------------------------
local gitlabMrs = hs.loadSpoon("gitlab-merge-requests")
local deployUrls = {
	frontend = gitlabMrs.builtin.deployUrls.frontend({ hostname = "stephanbcorp.dev.xmatters.com" }),
	spark = gitlabMrs.builtin.deployUrls.spark(),
	ondemand = gitlabMrs.builtin.deployUrls.ondemand({
		slackChannel = "kessel-builds",
		versionSuffix = "sb",
		fallbackVersion = "0.x.sbadragan",
	}),
	["xM-API"] = gitlabMrs.builtin.deployUrls["xM-API"]({
		slackChannel = "kessel-builds",
		versionSuffix = "sb",
		fallbackVersion = "0.x.sbadragan",
	}),
}

gitlabMrs:setup({
	gitlab_host = localConfig.gitlab.gitlab_host,
	token = localConfig.gitlab.token,
	username = localConfig.gitlab.username,
	deployUrls = deployUrls,
})
gitlabMrs:start()

-------------------------------------------------------------------
-- JIRA
-------------------------------------------------------------------
hs.loadSpoon("jira-issues")
spoon["jira-issues"]:setup({
	jira_host = localConfig.jira.jira_host,
	login = localConfig.jira.login,
	api_token = localConfig.jira.api_token,
	jql = "assignee=currentuser() AND resolution=Unresolved AND status not in (Rejected, Closed) AND type in (Story, Bug) ORDER BY status ASC",
})
spoon["jira-issues"]:start()

-------------------------------------------------------------------
-- constants
-------------------------------------------------------------------
local superKey = { "cmd", "alt", "ctrl", "shift" }

-------------------------------------------------------------------
-- app switching
-------------------------------------------------------------------
local function switchToApp(appName, initializeWinFn)
	local app = hs.application.get(appName)
	if app then
		if app:isFrontmost() then
			--app:hide()
			local orderedWindows = hs.window.orderedWindows()
			local currentWindow = orderedWindows[1]
			for _, win in pairs(orderedWindows) do
				if win:application():name() ~= app:name() and win:screen():id() == currentWindow:screen():id() then
					win:focus()
					return
				end
			end
			if orderedWindows[2] then
				orderedWindows[2]:focus()
			end
		else
			hs.application.open(appName)
		end
	else
		hs.application.open(appName, 2, true)
		if initializeWinFn ~= nil then
			local newWin = hs.window.frontmostWindow()
			initializeWinFn(newWin)
		end
	end
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
		if win:id() ~= 0 then
			table.insert(ids, win:id())
		end
	end
	table.sort(ids)

	-- get next windows id
	local currentWinIndex = -1
	for index, id in ipairs(ids) do
		if id == currentWindow:id() then
			currentWinIndex = index
			break
		end
	end
	local nextWinIndex = (currentWinIndex % #ids) + 1
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
		if screen == currentScreen then
			currentScreenIndex = index
			break
		end
	end
	local nextScreenIndex = (currentScreenIndex % #screens) + 1
	return screens[nextScreenIndex]
end

-------------------------------------------------------------------
-- Key Bindings
-------------------------------------------------------------------

local kitty = require("./kitty")
local summonApp = require("./summonApp")
summonApp:init()
local summon = summonApp.summon

local superKeyBindings = {
	{
		key = "a",
		fn = function()
			-- show name of application corresponding to current window
			local win = hs.window.frontmostWindow()
			hs.alert.show(win:application():name())
		end,
	},
	{
		key = "d",
		app = "Brave Browser",
	},
	{
		key = "e",
		app = "kitty",
		window = {
			title = "terminal",
		},
	},
	{
		key = "i",
		app = "IntelliJ IDEA",
	},
	{
		key = "k",
		app = "Fork",
	},
	{
		key = "l",
		app = "zoom.us",
	},
	{
		key = "m",
		app = "Figma",
	},
	{
		key = "o",
		app = "Microsoft Outlook",
	},
	{
		key = "p",
		app = "Finder",
	},
	{
		key = "r",
		app = "Google Chrome",
	},
	{
		key = "s",
		app = "Slack",
	},
	{
		key = "u",
		app = "kitty",
		window = {
			title = "notes",
			launch = function()
				kitty.launchWindow({ title = "notes", command = "/usr/local/bin/zsh -is eval vim +VimwikiIndex" })
			end,
		},
	},
	{
		key = "w",
		app = "TickTick",
	},
	{
		key = "return",
		app = "kitty",
		window = {
			title = "terminal",
		},
	},
	-- superkey + z - launches next meeting from Meeter Pro
}

hs.fnutils.each(superKeyBindings, function(binding)
	hs.hotkey.bind(superKey, binding.key, function()
		if binding.fn then
			binding.fn()
		else
			summon(binding.app, binding.window)
		end
	end)
end)

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
	positionWindowLeftHalf(win)
end)

-- move window to right side of screen
hs.hotkey.bind(superKey, "right", function()
	local win = hs.window.frontmostWindow()
	positionWindowRightHalf(win)
end)

-- maximize window
hs.hotkey.bind(superKey, "up", function()
	local win = hs.window.frontmostWindow()
	positionWindowFullscreen(win)
end)

-- centered and 80% size window
hs.hotkey.bind(superKey, "down", function()
	local win = hs.window.frontmostWindow()
	positionWindowCentered(win)
end)
