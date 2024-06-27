-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- fonts
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.5
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
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
  local background = "#65737E"
  local foreground = "#F0F2F5"
  local edge_background = "#FAFAF9"

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

-- color scheme
config.color_scheme = "GruvboxLight"
config.colors = {
  background = "#FAFAF9",
  tab_bar = {
    background = "#FAFAF9",
  },
}
config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

-- keys
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
  -- prev tab
  { key = "h", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
  -- next tab
  { key = "l", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },
  -- move tab left
  { key = "h", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
  -- move tab right
  { key = "l", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(1) },
  -- close tab
  { key = "x", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
  -- rename tab
  {
    key = "n",
    mods = "CMD",
    action = wezterm.action.PromptInputLine({
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
    key = "p",
    mods = "CMD",
    action = wezterm.action.ActivateKeyTable({
      name = "splits",
      one_shot = true,
    }),
  },
  -- panes nav
  {
    key = "h",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "j",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
}

config.key_tables = {
  splits = {
    -- split vertical
    { key = "v", action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
    -- split horizontal
    { key = "s", action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
    -- rotate
    { key = "r", action = wezterm.action.RotatePanes("Clockwise") },
    -- close pane
    { key = "c", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
    -- resize mode
    {
      key = "r",
      action = wezterm.action.ActivateKeyTable({
        name = "resize_pane",
        one_shot = false,
      }),
    },
  },
  resize_pane = {
    { key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
    { key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
    { key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
    { key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

    -- Cancel the mode by pressing escape
    { key = "Escape", action = "PopKeyTable" },
  },
}

return config
