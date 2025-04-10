---@module 'snacks'

local is_linux = vim.fn.has('linux') == 1

local function ins_mod_special(key)
  return is_linux and '<c-' .. key .. '>' or '<a-' .. key .. '>'
end

return {
  {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      picker = {
        enabled = false,
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
              [ins_mod_special('bs')] = {
                function()
                  vim.cmd('normal! db')
                end,
                mode = { 'n', 'i' },
              },
              [ins_mod_special('del')] = {
                function()
                  vim.cmd('normal! de')
                end,
                mode = { 'n', 'i' },
              },
              [ins_mod_special('left')] = {
                function()
                  vim.cmd('normal! b')
                end,
                mode = { 'n', 'i' },
              },
              [ins_mod_special('right')] = {
                function()
                  vim.cmd('normal! w')
                end,
                mode = { 'n', 'i' },
              },
              [ins_mod_special('up')] = {
                function()
                  vim.cmd('normal! ^')
                end,
                mode = { 'n', 'i' },
              },
              [ins_mod_special('down')] = {
                function()
                  vim.cmd('normal! $')
                end,
                mode = { 'n', 'i' },
              },
            },
          },
        },
      },
    },
  },
}
