local M = {}

local function get_lazygit(dir)
  local Terminal = require('toggleterm.terminal').Terminal
  return Terminal:new({
    cmd = 'lazygit',
    direction = 'float',
    -- direction = 'tab',
    float_opts = {
      border = 'double',
    },
    start_in_insert = true,
    dir = dir,
    -- function to run on opening the terminal
    on_open = function(term)
      vim.schedule(function()
        vim.cmd('startinsert!')
      end)
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        't',
        '<C-g>',
        '<C-\\><C-n><cmd>close<cr>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-d>', '<C-O><cmd>tabprev<cr>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-f>', '<C-O><cmd>tabnext<cr>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', { noremap = true, silent = true })
    end,
  })
end

local lazygit_by_cwd = {}
function M.toggle_lazygit()
  local cwd = vim.fn.getcwd()
  if not lazygit_by_cwd[cwd] then
    lazygit_by_cwd[cwd] = get_lazygit(cwd)
  end

  lazygit_by_cwd[cwd]:toggle()
end

-- local lazygit_buf_by_cwd = {}
-- function M.toggle_lazygit()
--   local cwd = vim.fn.getcwd()
--   local lazygit_buf = lazygit_buf_by_cwd[cwd]
--   if not lazygit_buf then
--     vim.cmd('tabnew')
--     vim.cmd.tcd(cwd)
--     vim.cmd('term lazygit')
--     lazygit_buf = vim.api.nvim_get_current_buf()
--     lazygit_buf_by_cwd[cwd] = lazygit_buf
--
--     vim.schedule(function()
--       vim.cmd('startinsert!')
--     end)
--     vim.api.nvim_buf_set_keymap(
--       lazygit_buf,
--       't',
--       '<C-g>',
--       '<C-\\><C-n><cmd>close<cr>',
--       { noremap = true, silent = true }
--     )
--     vim.api.nvim_buf_set_keymap(lazygit_buf, 't', '<C-d>', '<C-O><cmd>tabprev<cr>', { noremap = true, silent = true })
--     vim.api.nvim_buf_set_keymap(lazygit_buf, 't', '<C-f>', '<C-O><cmd>tabnext<cr>', { noremap = true, silent = true })
--     vim.api.nvim_buf_set_keymap(lazygit_buf, 't', '<esc>', '<esc>', { noremap = true, silent = true })
--   end
--
--   local lazygit_win = vim.fn.bufwinid(lazygit_buf)
--   local lazygit_tab = lazygit_win > -1 and vim.api.nvim_win_get_tabpage(lazygit_win) or nil
--   if lazygit_tab == vim.api.nvim_get_current_tabpage() then
--     vim.cmd('close')
--   elseif lazygit_tab then
--     vim.api.nvim_set_current_tabpage(lazygit_tab)
--   else
--     vim.cmd('tabnew')
--     vim.cmd.tcd(cwd)
--     vim.api.nvim_set_current_buf(lazygit_buf)
--   end
-- end

return M
