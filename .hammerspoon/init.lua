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
-- network.setEthernetInterfaceName("Ethernet Adapter (en6)") -- name shown when unplugged
network.setEthernetInterfaceName("AX88179A") -- name shown when unplugged
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
  ["xm-database"] = gitlabMrs.builtin.deployUrls["xm-database"]({
    databaseName = "kramerica",
  }),
  hyrax = gitlabMrs.builtin.deployUrls.hyrax({
    slackChannel = "kessel-builds",
    fallbackTicketName = "sbadragan",
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
-- hs.loadSpoon("jira-issues")
-- spoon["jira-issues"]:setup({
--   jira_host = localConfig.jira.jira_host,
--   login = localConfig.jira.login,
--   api_token = localConfig.jira.api_token,
--   jql = "assignee=currentuser() AND resolution=Unresolved AND status not in (Rejected, Closed) AND type in (Story, Bug) ORDER BY status ASC",
-- })
-- spoon["jira-issues"]:start()

-------------------------------------------------------------------
-- Tabs
-------------------------------------------------------------------
-- hs.tabs.enableForApp(hs.application.get('Brave Browser'))

-------------------------------------------------------------------
-- Snippets
-------------------------------------------------------------------
local snippets = require("./snippets")
local xmDemoInstance = localConfig.xmDemoInstance
local ebfdDemoInstance = localConfig.ebfdDemoInstance
local cursor = "▍"
snippets.init({
  {
    description = "code block",
    example = "```\n" .. cursor .. "\n```",
    keys = { "```", { char = "return" }, { char = "return" }, "```", { char = "up" } },
  },
  {
    description = "code block from clipboard",
    example = "```\n<paste>\n```" .. cursor,
    keys = { "```\n", { mods = { "cmd" }, char = "v" }, "\n```" },
  },
  {
    description = "xmatters demo/test instance",
    example = xmDemoInstance.host
      .. " (user = "
      .. xmDemoInstance.user
      .. ", password = "
      .. xmDemoInstance.password
      .. ")"
      .. cursor,
    keys = {
      xmDemoInstance.host
      .. " (user = "
      .. xmDemoInstance.user
      .. ", password = "
      .. xmDemoInstance.password
      .. ")",
    },
  },
  {
    description = "ebfd demo/test instance",
    example = ebfdDemoInstance.host
      .. " (user = "
      .. ebfdDemoInstance.user
      .. ", password = "
      .. ebfdDemoInstance.password
      .. ")"
      .. cursor,
    keys = {
      ebfdDemoInstance.host
      .. "\n(organization = "
      .. ebfdDemoInstance.organization
      .. ", user = "
      .. ebfdDemoInstance.user
      .. ", password = "
      .. ebfdDemoInstance.password
      .. ")",
    },
  },
})

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
    key = "b",
    app = "kitty",
    window = {
      title = "combos",
      launch = function()
        kitty.launchWindow({
          title = "combos",
          command =
          "/bin/zsh -is eval vim /opt/repos/qmk_firmware/keyboards/handwired/dactyl_manuform/5x6/keymaps/MagicDuck/combos.def"
        })
      end,
    },
  },
  {
    key = "d",
    -- app = "Brave Browser",
    -- app = "Safari",
    app = "Vivaldi",
  },
  {
    key = "e",
    app = "kitty",
    window = {
      title = "terminal",
      launch = function()
        kitty.launchWindow({ title = "terminal", command = "/bin/zsh -is" })
      end,
    },
  },
  {
    key = "f",
    -- app = "Brave Browser",
    app = "Obsidian",
  },
  {
    key = "g",
    app = "Documentation",
  },
  {
    key = "h",
    app = "Postman",
  },
  {
    key = "i",
    app = "IntelliJ IDEA",
  },
  {
    key = "v",
    app = "TickTick",
  },
  {
    key = "u",
    app = "Fork",
  },
  {
    key = "j",
    app = "TablePlus",
  },
  {
    key = "k",
    app = "kitty",
    window = {
      title = "lazygit",
      launch = function()
        kitty.launchWindow({ title = "lazygit", command = "/bin/zsh -is eval lazygit" })
        -- kitty.launchWindow({ title = "notes", command = "/bin/zsh -is eval vim +VimwikiIndex" })
      end,
    },
  },
  {
    key = "l",
    app = "zoom.us",
  },
  -- {
  --   key = "n",
  --   app = "Figma",
  -- },
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
    -- app = "Firefox",
  },
  {
    key = "s",
    app = "Slack",
  },
  -- {
  --   key = "u",
  --   app = "kitty",
  --   window = {
  --     title = "notes",
  --     launch = function()
  --       kitty.launchWindow({ title = "notes", command = "/bin/zsh -is eval vim ~/notes/index.md" })
  --       -- kitty.launchWindow({ title = "notes", command = "/bin/zsh -is eval vim +VimwikiIndex" })
  --     end,
  --   },
  -- },
  {
    key = "u",
    app = "kitty",
    window = {
      title = "scratchpad",
      launch = function()
        kitty.launchWindow({ title = "scratchpad", command = "/bin/zsh -is eval vim ~/scratchpad.md" })
      end,
    },
  },
  -- v -> ticktick
  -- -- {
  --   key = "u",
  --   app = "Obsidian",
  -- },
  -- {
  --   key = "w",
  --   app = "confluence wiki",
  -- },
  {
    key = "y",
    app = "YouTube",
  },
  {
    key = "space",
    app = "kitty",
    window = {
      title = "terminal",
    },
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
      -- show name and bundle id of application corresponding to current window
      local win = hs.window.frontmostWindow()
      hs.alert.show(win:application():name() .. " | " .. win:application():bundleID())
    end,
  },
  -- {
  --   key = "n",
  --   fn = wm.focusNextAppWindow,
  -- },
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
    key = ";",
    fn = wm.moveCurrentWindowToNextScreen,
  },
  -- snippets
  {
    key = "m",
    fn = snippets.show,
    -- fn = function()
    --     hs.eventtap.keyStrokes("")
    -- end,
  },
  {
    key = "x",
    fn = function()
      local win = hs.window.frontmostWindow()
      win:close()
    end,
  },
  -- keeper password manager autofill
  -- {
  --   key = "x",
  --   fn = function()
  --     local win = hs.window.frontmostWindow()
  --     win:application():activate() -- this lets keeper know which app we are on
  --     hs.timer.doAfter(0.2, function()
  --       hs.eventtap.keyStroke({ "cmd", "shift", "alt" }, "m")
  --       hs.timer.doAfter(0.2, function()
  --         hs.eventtap.keyStroke({}, "return")
  --       end)
  --     end)
  --   end,
  -- },
  -- autoexpand snippets
  -- {
  -- 	key = "n",
  -- 	fn = function()
  -- 		hs.eventtap.keyStroke({ "option" }, "j")
  -- 	end,
  -- },

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
