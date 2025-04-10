local root = vim.fn.fnamemodify('~/.nvim_repro', ':p')
-- set stdpaths to use .repro
for _, name in ipairs({ 'config', 'data', 'state', 'cache' }) do
  vim.env[('XDG_%s_HOME'):format(name:upper())] = root .. '/' .. name
end
-- bootstrap lazy
local lazypath = root .. '/plugins/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.maplocalleader = ','
-- install plugins
local plugins = {
  -- do not remove the colorscheme!
  'folke/tokyonight.nvim',
  {
    dir = '~/repos/grug-far.nvim',
    name = 'grug-far',
    -- "MagicDuck/grug-far.nvim",
    config = function()
      require('grug-far').setup({})
    end,
  },
  -- add any other pugins here
}

require('lazy').setup(plugins, {
  root = root .. '/plugins',
})

-- add anything else here
vim.opt.cursorline = true
-- vim.opt.termguicolors = true
-- do not remove the colorscheme!
-- vim.cmd([[colorscheme tokyonight]])
