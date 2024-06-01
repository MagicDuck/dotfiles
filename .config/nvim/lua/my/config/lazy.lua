local M = {}

function M.load(opts)
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath })
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    spec = opts.spec,
    defaults = {
      -- should plugins be lazy-loaded?
      lazy = false,

      -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
      -- have outdated releases, which may break your Neovim install.
      version = false, -- always use the latest git commit
      -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { 'dayfox', 'habamax' } },
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = false,
    },
    custom_keys = {
      -- you can define custom key maps here.
      -- To disable one of the defaults, set it to false

      -- disable defaults
      -- open lazygit log
      ['<localleader>l'] = false,
      -- open a terminal for the plugin dir
      ['<localleader>t'] = false,
    },
    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          -- "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          -- "tarPlugin",
          'tohtml',
          'tutor',
          -- "zipPlugin",
        },
      },
    },
  })
end

return M
