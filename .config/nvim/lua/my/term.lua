local M = {}

local function get_lazygit(dir)
  local Terminal = require('toggleterm.terminal').Terminal
  return Terminal:new({
    cmd = 'lazygit',
    -- direction = 'float',
    direction = 'tab',
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
function M.open_lazygit()
  local cwd = vim.fn.getcwd()
  if not lazygit_by_cwd[cwd] then
    lazygit_by_cwd[cwd] = get_lazygit(cwd)
  end

  lazygit_by_cwd[cwd]:toggle()
end

return M
