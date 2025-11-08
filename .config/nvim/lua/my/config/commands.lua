my.command({
  description = 'search: find term and open results in quickfix',
  cmd = ':RgSearch ',
})
my.command({
  description = 'search: pick a color scheme',
  cmd = ':Colors<CR>',
})
my.command({
  description = 'git: search in commits',
  cmd = ':Commits<CR>',
})
my.command({
  description = 'git: search in buffer commits',
  cmd = ':BCommits<CR>',
})
my.command({
  description = 'terminal: open at current buffer dir',
  cmd = ":lua require('my/terminal').openTerminalAtCurrentBufferLocation()<CR>",
})
my.command({
  description = 'edit snippets',
  cmd = ':EditSnippets<CR>',
})
my.command({
  description = 'git: open selection online',
  cmd = ':GBrowseMain<CR>',
})

vim.api.nvim_create_user_command('EditBookmarkAsTab', function()
  require('my.config.bookmarks').open_bookmark('tabnew')
end, {})

vim.api.nvim_create_user_command('EditBookmark', function()
  require('my.config.bookmarks').open_bookmark('edit')
end, {})

vim.api.nvim_create_user_command('GBrowseMain', function(params)
  local branch = vim.trim(vim.fn.system('basename $(git rev-parse --abbrev-ref origin/HEAD)'))
  local range = params.line1 .. (params.range > 1 and ',' .. params.line2 or '')
  vim.cmd(range .. 'GBrowse origin/' .. branch .. ':' .. vim.fn.expand('%'))
end, { range = true })
