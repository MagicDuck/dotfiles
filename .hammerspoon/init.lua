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
-- Key Bindings
-------------------------------------------------------------------

local kitty = require("./kitty")
local summonApp = require("./summonApp")
summonApp:init()
local summon = summonApp.summon
local wm = require("./windowManagement")

local superKey = { "cmd", "alt", "ctrl", "shift" }
local superKeyBindings = {
	-- app switching
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
	-- window management
	{
		key = "a",
		fn = function()
			-- show name of application corresponding to current window
			local win = hs.window.frontmostWindow()
			hs.alert.show(win:application():name())
		end,
	},
	{
		key = "n",
		fn = wm.focusNextAppWindow,
	},
	{
		key = "left",
		fn = wm.positionCurrentWindowLeftHalf,
	},
	{
		key = "right",
		fn = wm.positionCurrentWindowRightHalf,
	},
	{
		key = "up",
		fn = wm.positionCurrentWindowFullscreen,
	},
	{
		key = "down",
		fn = wm.positionCurrentWindowCentered,
	},
	{
		key = "pageup",
		fn = wm.moveCurrentWindowToNextScreen,
	},
	{
		key = "pagedown",
		fn = wm.moveCurrentWindowToNextScreen,
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
