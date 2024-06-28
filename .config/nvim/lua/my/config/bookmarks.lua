local scan = require('plenary.scandir')

local function get_bookmarks()
  local bookmarks = {
    { 'i', '~/.config/nvim/init.lua' },
    '~/notes',
    '~/.config/nvim/base-config/keys.vim',
    '~/.config/karabiner.edn',
    '~/.config/kitty/kitty.conf',
    '~/.tmux.conf',
    '~/.hammerspoon/init.lua',
    '~/.config/wezterm/wezterm.lua',
    '~/.config/zellij/config.kdl',
    '~/.zshrc',
    '/opt/repos/frontend/libs/spark/src/common/scss/mixins/_colors.scss',
    '/opt/repos/frontend/libs/spark/src/common/scss/mixins/_fonts.scss',
    '~/notes/.obsidian.vimrc',
    '/Users/stephanbadragan/Library/Application Support/lazygit/config.yml',
    '/opt/repos/frontend/reactUi',
    '/opt/repos/customer-config-ui-feature-definition/features.json',
    '/opt/repos/xm-api/src/main/java/com/xmatters/xm/repositories/FeatureToggleRepository.java',
    '/opt/repos/qmk_firmware/keyboards/handwired/dactyl_manuform/5x6/keymaps/MagicDuck/keymap.c',
  }
  vim.list_extend(bookmarks, scan.scan_dir('/opt/repos', { hidden = false, depth = 1, add_dirs = true }))
  vim.list_extend(bookmarks, scan.scan_dir('/opt/repos/eb', { hidden = false, depth = 1, add_dirs = true }))
  vim.list_extend(bookmarks, scan.scan_dir('/opt/repos/frontend/libs', { hidden = false, depth = 1, add_dirs = true }))
  vim.list_extend(bookmarks, scan.scan_dir('/opt/repos/aoc2022', { hidden = false, depth = 1, add_dirs = true }))

  return bookmarks
end

return get_bookmarks
