local function augroup(name)
  return vim.api.nvim_create_augroup('my_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank({ on_visual = false })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'PlenaryTestPopup',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Enable syntax highlight in .conf files
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead' }, {
  group = augroup('syntax_highlight_conf_files'),
  pattern = { '*.conf' },
  callback = function()
    vim.bo.filetype = 'dosini'
  end,
})

-- Enable syntax highlight in Jenkinsfile files
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead' }, {
  group = augroup('syntax_highlight_conf_files'),
  pattern = { 'Jenkinsfile' },
  callback = function()
    vim.bo.filetype = 'groovy'
  end,
})

-- Wrap diffs
vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup('diff_wrap'),
  callback = function()
    if vim.wo.diff then
      vim.wo.wrap = true
    end
  end,
})

-- force format options (disable auto-comment)
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup('force_formatoptions'),
  callback = function()
    -- vim.bo.formatoptions = "jqlnt" -- disable auto-comments
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

-- start in insert mode at end of line in git commit
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  group = augroup('gitcommit_start_end_of_line'),
  pattern = { 'COMMIT_EDITMSG' },
  callback = function()
    vim.cmd('goto 1')
    vim.cmd('startinsert!')
  end,
})

-- open help in vertical split on right always
-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup('help_window_right'),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then
      vim.cmd.wincmd('L')
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('commentstring_kdl'),
  pattern = { 'kdl' },
  callback = function()
    vim.opt.commentstring = '// %s'
  end,
  desc = 'Change commentstring for kdl files',
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('test'),
  pattern = { 'grug-far' },
  callback = function()
    vim.keymap.set('n', '<localleader>w', function()
      local state = unpack(require('grug-far').toggle_flags({ '--fixed-strings' }))
      vim.notify('grug-far: toggled --fixed-strings ' .. (state and 'ON' or 'OFF'))
    end, { buffer = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('grug-far-keybindings', { clear = true }),
  pattern = { 'grug-far' },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-enter>', '<localleader>o<localleader>c', {})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('test-js-lint', { clear = true }),
  pattern = { 'javascript' },
  callback = function(params)
    vim.api.nvim_create_autocmd({ 'BufWritePre', 'BufLeave', 'WinLeave', 'FocusLost' }, {
      buffer = buf,
      callback = function()
        error('this is an error')
      end,
    })
  end,
})

-- absolute number in insert mode, relative otherwise
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   group = augroup("insert_mode_absolute_numbers"),
--   callback = function()
--     vim.opt.relativenumber = false;
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   group = augroup("other_mode_relative_numbers"),
--   callback = function()
--     vim.opt.relativenumber = true;
--   end,
-- })
