local scan = require('plenary.scandir')

local function add_subdirs_of(bookmarks, dir)
  local d = vim.fn.expand(dir)
  if vim.fn.isdirectory(d) > 0 then
    vim.list_extend(bookmarks, scan.scan_dir(d, { hidden = false, depth = 1, add_dirs = true }))
  end
end

local function get_bookmarks()
  local bookmarks = {
    { 'i', '~/.config/nvim/init.lua' },
    -- '~/notes',
    -- '~/notes/.obsidian.vimrc',
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
  }

  add_subdirs_of(bookmarks, '~/repos')
  add_subdirs_of(bookmarks, '~/repos/eb')
  add_subdirs_of(bookmarks, '~/repos/frontend/libs')
  add_subdirs_of(bookmarks, '~/repos/frontend/aoc2022')

  return bookmarks
end

return get_bookmarks
