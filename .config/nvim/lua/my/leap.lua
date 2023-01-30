local leap = require('leap')
M = {}

function M.jump_bidirectional()
  leap.leap { target_windows = { vim.fn.win_getid() } }
end

return M

