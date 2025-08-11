local M = {}

local function openLocation(loc)
  local targetBuf = vim.fn.bufnr(loc.filename)
  local targetWin = 0
  if targetBuf == -1 then
    vim.fn.win_execute(targetWin, 'e! ' .. vim.fn.fnameescape(loc.filename), true)
    targetBuf = vim.api.nvim_win_get_buf(targetWin)
  else
    vim.api.nvim_win_set_buf(targetWin, targetBuf)
  end
  pcall(vim.api.nvim_win_set_cursor, targetWin, { loc.lnum or 1, loc.col and loc.col - 1 or 0 })
end

function M.goto_definition()
  vim.lsp.buf.definition({
    on_list = function(options)
      local items = {}
      for _, item in ipairs(options.items) do
        if not vim.iter(items):find(function(it)
          return item.lnum == it.lnum
        end) then
          table.insert(items, item)
        end
      end

      if #items == 0 then
        print('no definitions found!')
        return
      end

      if #items == 1 then
        openLocation(items[1])
        return
      end

      local cwd = vim.fn.getcwd()
      vim.ui.select(items, {
        prompt = 'Select where to go:',
        format_item = function(item)
          local filename = item.filename
          if vim.startswith(filename, cwd) then
            filename = '.' .. filename:sub(#cwd + 1)
          end
          return vim.trim(item.text) .. ' -> ' .. filename .. ':' .. item.lnum .. ':' .. item.col
        end,
      }, function(choice)
        openLocation(choice)
      end)
    end,
  })
end

return M
