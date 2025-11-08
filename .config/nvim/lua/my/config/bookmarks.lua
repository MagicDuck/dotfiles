local scan = require('plenary.scandir')
local M = {}

local function add_subdirs_of(bookmarks, dir)
  local d = vim.fn.expand(dir)
  if vim.fn.isdirectory(d) > 0 then
    vim.list_extend(bookmarks, scan.scan_dir(d, { hidden = false, depth = 1, add_dirs = true }))
  end
end

function M.get_bookmarks()
  local bookmarks = {
    { 'i', '~/.config/nvim/init.lua' },
    '~/notes',
    '~/notes/.obsidian.vimrc',
    '~/.config/nvim/lua/my/config/keymaps.lua',
    '~/.config/karabiner.edn',
    '~/.config/kitty/kitty.conf',
    '~/.tmux.conf',
    '~/.hammerspoon/init.lua',
    '~/.config/wezterm/wezterm.lua',
    '~/.config/zellij/config.kdl',
    '~/.zshrc',
    '~/app_window_toggler',
    '/opt/repos/frontend/libs/spark/src/common/scss/mixins/_colors.scss',
    '/opt/repos/frontend/libs/spark/src/common/scss/mixins/_fonts.scss',
    '~/Library/Application Support/lazygit/config.yml',
    '/opt/repos/frontend/reactUi',
    '/opt/repos/customer-config-ui-feature-definition/features.json',
    '/opt/repos/xm-api/src/main/java/com/xmatters/xm/repositories/FeatureToggleRepository.java',
    -- '/opt/repos/qmk_firmware/keyboards/handwired/dactyl_manuform/5x6/keymaps/MagicDuck/keymap.c',
    '/opt/repos/vial-qmk/keyboards/cyboard/dactyl/manuform_number_row/keymaps/sbadragan/keymap.c',
    '/opt/repos/eb/eb-ui-360/src/EBMui/theme/index.ts',
    '~/app_window_toggler/contents/code/main.js',
    '~/.config/yazi/yazi.toml',
    '~/OneDrive - Everbridge/notes/.obsidian/snippets/font.css',
  }

  add_subdirs_of(bookmarks, '~/repos')
  add_subdirs_of(bookmarks, '~/repos/eb')
  add_subdirs_of(bookmarks, '~/repos/frontend/libs')
  add_subdirs_of(bookmarks, '~/repos/frontend/aoc2022')

  return bookmarks
end

M.open_bookmark = function(command)
  Snacks.picker.pick({
    items = vim
      .iter(M.get_bookmarks())
      :map(function(bookmark)
        local path
        if type(bookmark) == 'table' then
          path = bookmark[2]
        else
          path = bookmark
        end
        return { text = path, value = path }
      end)
      :totable(),
    format = 'text',
    title = 'Bookmarks',
    layout = {
      -- preset = 'dropdown',
      preset = 'ivy',
      preview = false,
      ---@diagnostic disable-next-line: missing-fields
      layout = {
        width = 0,
      },
    },
    confirm = function(picker, item)
      picker:close()

      local path = item.value
      vim.cmd(command .. ' ' .. path)
      if vim.fn.isdirectory(vim.fn.expand(path)) > 0 then
        vim.cmd.lchdir({ args = { path }, mods = { silent = true } })
      end
    end,
  })
end

return M
