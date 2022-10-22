local galaxyline = require("galaxyline")
local condition = require("galaxyline.condition")
local colors = require("my/galaxyline/colors")
local icons = require("my/galaxyline/icons")
local get_git_branch = require("galaxyline.providers.vcs").get_git_branch

-- shorten lines for these filetypes
galaxyline.short_line_list = {
	"LuaTree",
	"floaterm",
	"dbui",
	"startify",
	"term",
	"nerdtree",
	"fugitive",
	"fugitiveblame",
}

local modes = {
	n = { "NORMAL", colors.green },
	v = { "VISUAL", colors.cyan },
	V = { "V-LINE", colors.cyan },
	[""] = { "V-BLOCK", colors.cyan },
	s = { "SELECT", colors.orange },
	S = { "S-LINE", colors.orange },
	[""] = { "S-BLOCK", colors.orange },
	i = { "INSERT", colors.yellow },
	R = { "REPLACE", colors.red },
	c = { "COMMAND", colors.blue },
	r = { "PROMPT", colors.brown },
	["!"] = { "EXTERNAL", colors.purple },
	t = { "TERMINAL", colors.purple },
}

local get_vim_mode_style = function()
	local vim_mode = vim.fn.mode()
	return modes[vim_mode]
end

local get_filename = function()
	return vim.fn.expand("%:h:t") .. "/" .. vim.fn.expand("%:t")
end

local file_readonly = function(readonly_icon)
	if vim.bo.filetype == "help" then
		return ""
	end
	local icon = readonly_icon or ""
	if vim.bo.readonly == true then
		return " " .. icon .. " "
	end
	return ""
end

local current_file_name_provider = function()
	local file = get_filename()
	if vim.fn.empty(file) == 1 then
		return ""
	end
	if string.len(file_readonly()) ~= 0 then
		return file .. file_readonly()
	end
	local icon = ""
	if vim.bo.modifiable then
		if vim.bo.modified then
			return file .. " " .. icon .. "  "
		end
	end
	return file .. " "
end

local sectionCount = {
	left = 0,
	mid = 0,
	right = 0,
	short_line_left = 0,
	short_line_right = 0,
}

local nextSectionNum = function(sectionKind)
	local num = sectionCount[sectionKind] + 1
	sectionCount[sectionKind] = num
	return num
end

local addSection = function(sectionKind, section)
	local num = nextSectionNum(sectionKind)
	local id = sectionKind .. "_" .. num .. "_" .. section.name
	-- note: this is needed since id's get mapped to highlights name `Galaxy<Id>`
	if section.useNameAsId == true then
		id = section.name
	end
	galaxyline.section[sectionKind][num] = {
		[id] = section,
	}
end

local addSections = function(sectionKind, sections)
	for _, section in pairs(sections) do
		addSection(sectionKind, section)
	end
end

local string_provider = function(str)
	return function()
		return str
	end
end

local createSpaceSection = function(color)
	return {
		name = "whitespace",
		provider = string_provider(" "),
		highlight = { color, color },
	}
end

addSections("left", {
	createSpaceSection(colors.base04),
	{
		name = "ViMode",
		useNameAsId = true,
		provider = function()
			-- auto change color according the vim mode
			local modeStyle = get_vim_mode_style()
			vim.api.nvim_command("hi GalaxyViMode guibg=" .. modeStyle[2])
			return icons.sep.space .. modeStyle[1] .. icons.sep.space
		end,
		highlight = { colors.light01, colors.base02, "bold" },
	},
	{
		name = "ViModeRightCap",
		useNameAsId = true,
		provider = function()
			local modeStyle = get_vim_mode_style()
			vim.api.nvim_command("hi GalaxyViModeRightCap guifg=" .. modeStyle[2])
			return icons.sep.right
		end,
		highlight = { colors.base02, colors.bg_active },
	},
	createSpaceSection(colors.bg_active),
	{
		name = "fileLeftCap",
		provider = string_provider(icons.sep.left),
		condition = condition.buffer_not_empty,
		highlight = { colors.base02, colors.bg_active },
		separator = " ",
		separator_highlight = { colors.base02, colors.base02 },
	},
	{
		name = "fileIcon",
		provider = { "FileIcon" },
		condition = condition.buffer_not_empty,
		highlight = { colors.base07, colors.base02 },
		separator = " ",
		separator_highlight = { colors.base07, colors.base02 },
	},
	{
		name = "fileName",
		provider = current_file_name_provider,
		condition = condition.buffer_not_empty,
		highlight = { colors.base07, colors.base02 },
		separator = " ",
		separator_highlight = { colors.base07, colors.base02 },
	},
	{
		name = "diagnostic",
		provider = "DiagnosticError",
		icon = icons.sep.space .. icons.diagnostic.error,
		condition = condition.check_active_lsp,
		highlight = { colors.light01, colors.orange },
	},
	{
		icon = " ",
		name = "lineColumn",
		provider = "LineColumn",
		condition = condition.buffer_not_empty,
		highlight = { colors.light01, colors.base04, "bold" },
		separator = " ",
		separator_highlight = { colors.base04, colors.base04 },
	},
	{
		icon = " ",
		name = "linePercent",
		provider = "LinePercent",
		condition = condition.buffer_not_empty,
		highlight = { colors.light01, colors.yellow },
	},
	{
		name = "fileRightCap",
		provider = string_provider(icons.sep.right),
		condition = condition.buffer_not_empty,
		highlight = { colors.yellow, colors.bg_active },
	},
	createSpaceSection(colors.bg_active),
})

addSections("right", {
	{
		name = "leftCap",
		provider = string_provider(icons.sep.left),
		highlight = { colors.base02, colors.bg_active },
	},
	{
		name = "gitBranch",
		icon = icons.git,
		provider = function()
			return vim.fn.FugitiveHead(10)
		end,
		-- provider = "GitBranch", -- very slow  on rebase
		condition = function()
			local remainingWidth = vim.fn.winwidth(0) - get_filename():len()
			return (remainingWidth >= 83) and condition.check_git_workspace()
		end,
		highlight = { colors.base07, colors.base02 },
		separator = " ",
		separator_highlight = { colors.base07, colors.base02 },
	},
	{
		name = "lsp_status",
		provider = string_provider(icons.lsp),
		condition = condition.check_active_lsp,
		highlight = { colors.base07, colors.base02 },
		separator = " ",
		separator_highlight = { colors.base07, colors.base02 },
	},
	createSpaceSection(colors.base02),
	createSpaceSection(colors.base04),
})

addSections("short_line_left", {
	createSpaceSection(colors.base03),
	{
		name = "viMode",
		provider = function()
			local modeStyle = get_vim_mode_style()
			return icons.sep.space .. modeStyle[1] .. icons.sep.space
		end,
		highlight = { colors.base05, colors.base02, "bold" },
	},
	{
		name = "viModeRightCap",
		provider = string_provider(icons.sep.right),
		highlight = { colors.base02, colors.bg_active },
	},
	createSpaceSection(colors.bg_active),
	{
		name = "fileLeftCap",
		provider = string_provider(icons.sep.left),
		condition = condition.buffer_not_empty,
		highlight = { colors.base02, colors.bg_active },
		separator = " ",
		separator_highlight = { colors.base02, colors.base02 },
	},
	{
		name = "fileIcon",
		provider = { "FileIcon" },
		condition = condition.buffer_not_empty,
		highlight = { colors.base07, colors.base02 },
		separator = " ",
		separator_highlight = { colors.base07, colors.base02 },
	},
	{
		name = "fileName",
		provider = "FileName",
		condition = condition.buffer_not_empty,
		highlight = { colors.base07, colors.base02 },
		separator = " ",
		separator_highlight = { colors.base07, colors.base02 },
	},
	{
		icon = " ",
		name = "lineColumn",
		provider = "LineColumn",
		condition = condition.buffer_not_empty,
		highlight = { colors.light01, colors.base04, "bold" },
		separator = " ",
		separator_highlight = { colors.base04, colors.base04 },
	},
	{
		name = "fileRightCap",
		provider = string_provider(icons.sep.right),
		condition = condition.buffer_not_empty,
		highlight = { colors.base04, colors.bg_active },
	},
	createSpaceSection(colors.bg_active),
})

addSections("short_line_right", {
	{
		name = "leftCap",
		provider = string_provider(icons.sep.left),
		highlight = { colors.base02, colors.bg_active },
	},
	createSpaceSection(colors.base02),
	createSpaceSection(colors.base03),
})
