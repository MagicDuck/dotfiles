local function getBookmarks(startify)
  local list = {}
  local bookmarks = require('my.config.bookmarks')
  for _, bookmark in pairs(bookmarks.get_bookmarks()) do
    local shortcut
    local path
    if type(bookmark) == 'table' then
      shortcut = bookmark[1]
      path = bookmark[2]
    else
      shortcut = '-'
      path = bookmark
    end
    local button = startify.file_button(path, shortcut)
    table.insert(list, button)
  end

  return list
end

local function getFortune()
  local handle = io.popen('fortune -s')
  local fortune = ''
  if handle ~= nil then
    fortune = handle:read('*a')
    handle:close()
  end

  return fortune
end

return {
  {
    'goolord/alpha-nvim',
    lazy = true,
    event = { 'VimEnter' },
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-lualine/lualine.nvim' },
      { 'BlakeJC94/alpha-nvim-fortune' },
    },
    config = function()
      -- require('alpha').setup(require('alpha.themes.startify').config)

      local alpha = require('alpha')
      local startify = require('alpha.themes.startify')
      local header = {
        -- [[                                   __                ]],
        -- [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
        -- [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        -- [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        -- [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        -- [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      local headerArt = [[
     |\_/|
     | @ @   Woof!
     |   <>              _
     |  _/\------____ ((| |))
     |               `--' |
 ____|_       ___|   |___.'
/_/_____/____/_______| ]]
      for _, line in pairs(vim.fn.split(headerArt, '\n')) do
        table.insert(header, '     ' .. line)
      end

      local fortune = require('alpha.fortune')
      local fortune_result = fortune()
      local fortune_lines = type(fortune_result) == 'table' and fortune_result or vim.split(fortune_result, '\n')
      -- for _, line in pairs(vim.split(fortune(), '\n')) do
      for _, line in pairs(fortune_lines) do
        table.insert(header, '    ' .. line)
      end
      -- for _, line in pairs(vim.fn.split(getFortune(), "\n")) do
      --   table.insert(header, "    " .. line)
      -- end

      startify.section.header.val = header
      startify.section.top_buttons.val = {
        -- startify.button("e", "  New file", ":enew <BAR> startinsert <CR>"),
      }

      startify.nvim_web_devicons.enabled = true
      -- startify.nvim_web_devicons.highlight = false
      -- startify.nvim_web_devicons.highlight = 'Keyword'

      startify.section.bottom_buttons.val = {
        startify.button('q', '  Quit NVIM', ':qa<CR>'),
      }

      -- ignore filetypes in MRU
      startify.mru_opts.ignore = function(path, ext)
        local default_mru_ignore = { 'gitcommit' }
        return (string.find(path, 'COMMIT_EDITMSG')) or (vim.tbl_contains(default_mru_ignore, ext))
      end

      startify.config.layout = {
        { type = 'padding', val = 1 },
        startify.section.header,
        -- { type = "padding", val = 2 },
        startify.section.top_buttons,
        { -- mru
          type = 'group',
          val = {
            { type = 'padding', val = 1 },
            { type = 'text', val = 'MRU', opts = { hl = 'SpecialComment' } },
            { type = 'padding', val = 1 },
            {
              type = 'group',
              val = function()
                return { startify.mru(0) }
              end,
            },
          },
        },
        { -- bookmarks
          type = 'group',
          val = {
            { type = 'padding', val = 1 },
            { type = 'text', val = 'Bookmarks', opts = { hl = 'SpecialComment' } },
            { type = 'padding', val = 1 },
            {
              type = 'group',
              val = getBookmarks(startify),
            },
          },
        },
        { type = 'padding', val = 1 },
        startify.section.bottom_buttons,
        startify.section.footer,
      }

      alpha.setup(startify.config)
    end,
  },
}
