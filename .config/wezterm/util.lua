local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

function M.get_cmd_out(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

M.OS = M.get_cmd_out("uname")
M.isLinux = M.OS == "Linux"

function M.toggleTabWithCmd(window, pane, tabName, args)
	for _, tab in ipairs(window:mux_window():tabs_with_info()) do
		if tab.tab:get_title() == tabName then
			if tab.is_active then
				window:perform_action(act.ActivateLastTab, pane)
			else
				tab.tab:activate()
			end
			return
		end
	end

	local newTab = window:mux_window():spawn_tab({
		args = { "/bin/zsh", "-is", "eval", table.unpack(args) },
		cwd = pane:get_current_working_dir(),
	})
	newTab:set_title(tabName)
end

function M.get_active_tab_index(window)
	for _, item in ipairs(window:mux_window():tabs_with_info()) do
		if item.is_active then
			return item.index
		end
	end

	return 0
end

function M.openScrollbackInVIM(window, pane)
	local active_tab_index = M.get_active_tab_index(window)

	local text = pane:get_lines_as_escapes(pane:get_dimensions().scrollback_rows)
	-- Create a temporary file to pass to vim
	local name = os.tmpname()
	local f = io.open(name, "w+")
	if f then
		f:write(text)
		f:flush()
		f:close()
	else
		return
	end

	local newTab = window:mux_window():spawn_tab({
		args = {
			"/opt/homebrew/bin/nvim",
			"-u",
			"~/.config/nvim/init_as_pager.lua",
			"-c",
			"silent te cat " .. name .. "  - ",
			"-c",
			"normal G",
		},
		cwd = pane:get_current_working_dir(),
	})
	newTab:set_title("scrollback")

	window:perform_action(act.MoveTab(active_tab_index + 1), pane)

	-- Wait "enough" time for vim to read the file before we remove it.
	-- The window creation and process spawn are asynchronous wrt. running
	-- this script and are not awaitable, so we just pick a number.
	--
	-- Note: We don't strictly need to remove this file, but it is nice
	-- to avoid cluttering up the temporary directory.
	wezterm.sleep_ms(1000)
	os.remove(name)
end

function M.createTab(window, pane)
	local mux_window = window:mux_window()
	local current_index = M.get_active_tab_index(window)

	mux_window:spawn_tab({})
	-- Move the new active tab to the right of the previously active tab
	window:perform_action(act.MoveTab(current_index + 1), pane)
end

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function M.basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

return M
