local M = {}

local addTextAboveCurrentLine = function(newText)
  local pos = vim.fn.getpos(".")
  local lineNum = pos[2]
  local bufnr = vim.fn.bufnr("%")
  local line = vim.fn.getbufline(bufnr, lineNum)[1]
  local prefix = string.match(line, "^%s*")
  vim.fn.appendbufline(bufnr, lineNum - 1, prefix .. newText)
end

local feedKeys = function(keyCombo)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keyCombo, true, false, true), "t", true)
end

M.addTodoCommentToLineAbove = function()
  addTextAboveCurrentLine("TODO (sbadragan):")
  feedKeys("k<leader>cA<space>")
end

return M
