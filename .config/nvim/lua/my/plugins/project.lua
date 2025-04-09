return {
  {
    'echasnovski/mini.misc',
    config = function()
      -- set up CWD depending on current file
      require('mini.misc').setup_auto_root(function(name, path)
        for _, n in ipairs({ '.git', '.obsidian' }) do
          if name == n then
            return true
          end
        end

        if path:match('%.config/nvim') then
          return true
        end

        return false
      end)
    end,
  },
}
