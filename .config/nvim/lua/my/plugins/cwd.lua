return {
  {
    'echasnovski/mini.misc',
    config = function()
      -- Disable conflicting option
      vim.o.autochdir = false

      -- Create autocommand
      local set_root = vim.schedule_wrap(function(data)
        if data.buf ~= vim.api.nvim_get_current_buf() then
          return
        end
        local root = require('mini.misc').find_root(data.buf, function(name, path)
          for _, n in ipairs({ '.git', '.obsidian' }) do
            if name == n then
              return true
            end
          end

          if path:match('%.config/nvim/?$') then
            return true
          end

          return false
        end)
        if root == nil then
          return
        end
        -- set window chdir
        vim.cmd.lchdir({ args = { root }, mods = { silent = true } })
      end)

      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        group = vim.api.nvim_create_augroup('MiniMiscAutoRoot', {}),
        nested = true,
        callback = set_root,
        desc = 'Find root and change current directory',
      })
    end,
  },
}
