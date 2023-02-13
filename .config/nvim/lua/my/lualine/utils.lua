local M = {}

function M.createSpaceComponent(color)
  return { function() return " " end, padding = 0, color = color }
end

function M.createLeftCap(color)
  return { function() return '' end, padding = 0, color = color }
end

function M.createRightCap(color)
  return { function() return '' end, padding = 0, color = color }
end

return M
