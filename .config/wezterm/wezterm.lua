-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local util = require("util")
local commands = require("commands")
local OS = util.OS
local isLinux = util.isLinux

local config = wezterm.config_builder()

-- fonts
config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font("0xProto", { weight = "Regular", stretch = "Normal", style = "Normal" })
-- config.font = wezterm.font("LXGW WenKai Mono TC")
-- config.font = wezterm.font("0xProto")
-- config.font_size = isLinux and 10 or 13.5
config.font_size = isLinux and 10 or 13.5
config.line_height = 1.35

config.window_frame = {
	border_bottom_height = "0.5cell",
}

config.window_padding = {
	left = "0.5cell",
	right = "0.5cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

-- tabs
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

-- scrollback
config.scrollback_lines = 100000

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end

	return util.basename(tab_info.active_pane.title)
	-- return tab_info.active_pane.title
end

-- color scheme
config.color_scheme = "GruvboxLight"
-- config.color_scheme = "Atelier Cave Light (base16)"
-- config.color_scheme = "Belafonte Day"
-- config.color_scheme = "Ef-Day"
-- config.color_scheme = "Equilibrium Gray Light (base16)"
-- local term_background = "#FAFAF9"
local term_background = "#E0E2EA"
config.colors = {
	background = term_background,
	tab_bar = {
		background = term_background,
	},
}
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local background = "#65737E"
	local foreground = "#F0F2F5"
	local edge_background = term_background

	if tab.is_active or hover then
		background = "#E5C07B"
		foreground = "#282C34"
	end
	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	local max = config.tab_max_width - 9
	if #title > max then
		title = wezterm.truncate_right(title, max) .. "…"
	end

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
		{ Text = " " .. (tab.tab_index + 1) .. ": " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
	}
end)

-- right status
wezterm.on("update-right-status", function(window, pane)
	local background = "#b4713d"
	local foreground = "#F0F2F5"
	local edge_background = term_background
	local edge_foreground = background

	-- Make it italic and underlined
	window:set_right_status(wezterm.format({
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " 󰡚 " .. window:active_workspace() },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
		{ Text = " " },
	}))
end)

-- keys
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }), pane)
				window:perform_action("ClearSelection", pane)
			else
				window:perform_action(wezterm.action({ SendKey = { key = "c", mods = "CTRL" } }), pane)
			end
		end),
	},
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },

	-- DEBUG overlay
	{ key = "i", mods = "CMD|SHIFT", action = wezterm.action.ShowDebugOverlay },
	-- create tab
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			util.createTab(window, pane)
		end),
	},
	-- fuzzy tabs select
	{
		key = "b",
		mods = "CMD",
		action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }),
	},
	-- prev tab
	{ key = "h", mods = "CMD", action = act.ActivateTabRelative(-1) },
	-- next tab
	{ key = "l", mods = "CMD", action = act.ActivateTabRelative(1) },
	-- move tab left
	{ key = "h", mods = "CMD|SHIFT", action = act.MoveTabRelative(-1) },
	-- move tab right
	{ key = "l", mods = "CMD|SHIFT", action = act.MoveTabRelative(1) },
	-- close tab
	{ key = "x", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },
	-- rename tab
	{
		key = "n",
		mods = "CMD",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- panes mode
	{
		key = "s",
		mods = "CMD",
		action = act.ActivateKeyTable({
			name = "splits",
			one_shot = true,
		}),
	},
	-- panes nav
	{
		key = "h",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	-- workspaces mode
	{
		key = "w",
		mods = "CMD",
		action = act.ActivateKeyTable({
			name = "workspaces",
			one_shot = true,
		}),
	},
	-- fuzzy commands
	{
		key = "a",
		mods = "CMD",
		action = act.ShowLauncherArgs({ flags = "FUZZY|COMMANDS" }),
	},
	-- fuzzy workspaces
	{
		key = "o",
		mods = "CMD",
		action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	-- lazygit
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			util.toggleTabWithCmd(window, pane, "lazygit", { "lazygit" })
		end),
	},
	-- scratch buffer
	{
		key = "u",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			util.toggleTabWithCmd(window, pane, "scratch", { "nvim", "~/scratchpad.md" })
		end),
	},
	-- scrollback buffer in vim
	{
		key = "i",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			util.openScrollbackInVIM(window, pane)
		end),
	},
	-- open links with keyboard
	{
		key = "e",
		mods = "CMD",
		action = act.QuickSelectArgs({
			label = "open",
			patterns = { "https?://\\S+" },
			action = wezterm.action_callback(function(win, pane)
				local url = win:get_selection_text_for_pane(pane)
				wezterm.open_with(url)
			end),
		}),
	},
	{
		key = "y",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette,
	},
	-- run selected command
	{
		key = "r",
		mods = "CMD",
		action = act.InputSelector({
			fuzzy = true,
			action = wezterm.action_callback(function(window, pane, id, label)
				if not id and not label then
					wezterm.log_info("cancelled")
				else
					commands.invoke_cb(window, pane, id)
				end
			end),
			title = "Select a command to run",
			choices = commands.get_choices(),
		}),
	},
}

config.key_tables = {
	splits = {
		-- split vertical
		{ key = "v", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
		-- split horizontal
		{ key = "s", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
		-- rotate
		{ key = "r", action = act.RotatePanes("Clockwise") },
		-- close pane
		{ key = "c", action = act.CloseCurrentPane({ confirm = false }) },
		-- move across panes
		{
			key = "h",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			action = act.ActivatePaneDirection("Down"),
		},
		-- resize mode
		{
			key = "r",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		},
	},
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
	workspaces = {
		-- new workspace creation
		{
			key = "n",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
		-- rename workspace
		{
			key = "r",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter new name for current workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
						-- wezterm.emit("update-right-status")

						-- window:set_right_status("bob")
					end
				end),
			}),
		},
		-- fuzzy workspace select
		{
			key = "o",
			action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{ key = "j", action = act.SwitchWorkspaceRelative(1) },
		{ key = "k", action = act.SwitchWorkspaceRelative(-1) },
	},
}

return config
