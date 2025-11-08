---@module 'snacks'

local is_linux = vim.fn.has('linux') == 1

local function insert_modifier_key(key)
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
      -- profiler = { enabled = true },
      -- image = { enabled = true, doc = { max_width = 200, max_height = 40 } },
      ---@type snacks.picker.Config
      picker = {
        layout = {
          preset = 'dropdown', -- "ivy"
          ---@diagnostic disable-next-line: missing-fields
          layout = {
            width = 0.6,
          },
        },
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
              [insert_modifier_key('bs')] = {
                function()
                  vim.cmd('normal! db')
                end,
                mode = 'i',
              },
              [insert_modifier_key('del')] = {
                function()
                  vim.cmd('normal! de')
                end,
                mode = 'i',
              },

              [insert_modifier_key('left')] = {
                function()
                  vim.cmd('normal! b')
                end,
                mode = 'i',
              },

              [insert_modifier_key('right')] = {
                function()
                  vim.cmd('normal! w')
                end,
                mode = 'i',
              },

              [insert_modifier_key('up')] = {
                function()
                  vim.cmd('normal! ^')
                end,
                mode = 'i',
              },

              [insert_modifier_key('down')] = {
                function()
                  vim.cmd('normal! $')
                end,
                mode = 'i',
              },
              ['<PageUp>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
              ['<PageDown>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
              ['<C-j>'] = { 'history_forward', mode = { 'i', 'n' } },
              ['<C-k>'] = { 'history_back', mode = { 'i', 'n' } },
            },
          },
        },
      },
    },
  },
  { 'Neurarian/snacks-luasnip.nvim' },
}
