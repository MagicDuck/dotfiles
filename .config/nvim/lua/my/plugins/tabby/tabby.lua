local mycolors = require('my.plugins.theme.mycolors')
local highlights = mycolors.get_my_highlights()

local theme = {
  -- You can use highlights as string or do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  fill = highlights.MyTabLineFill,
  head = highlights.MyTabLine,
  current_tab = highlights.MyTabLineSel,
  tab = highlights.MyTabLine,
  win = highlights.MyTabLine,
  tail = highlights.MyTabLine,
}

require('tabby.tabline').set(function(line)
  return {
    {
      { '  ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep('', hl, theme.fill),
        tab.is_current() and ' ' or ' ',
        tab.in_jump_mode() and tab.jump_key() or tab.number(),
        vim.fs.basename(vim.fn.getcwd(tab.current_win().id, tab.id)) .. ' - ' .. tab.name(),
        -- tab.close_btn(''), -- show a close button
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    -- shows list of windows in tab
    -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
    --   return {
    --     line.sep('', theme.win, theme.fill),
    --     win.is_current() and '' or '',
    --     win.buf_name(),
    --     line.sep('', theme.win, theme.fill),
    --     hl = theme.win,
    --     margin = ' ',
    --   }
    -- end),
    {
      line.sep('', theme.tail, theme.fill),
      { '  ', hl = theme.tail },
    },
    hl = theme.fill,
  }
end)
