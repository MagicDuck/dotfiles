local M = {}

M.openTerminalAtCurrentBufferLocation = function()
  local currentBufferPath = vim.fn.expand("%:p:h")
  vim.cmd(
    "FloatermNew --height=0.8 --width=0.8 --wintype=float --name=terminal --position=center --autoclose=2 --cwd=" ..
      currentBufferPath
  )
end

return M
