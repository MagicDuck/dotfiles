local M = {}

function M.createSpaceComponent(color)
  return { function() return " " end, padding = 0, color = { bg = color } }
end

return M
