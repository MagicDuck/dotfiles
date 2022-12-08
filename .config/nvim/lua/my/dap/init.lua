require('my/dap/dapui')
require('my/dap/debug-configurations')
local dap = require('dap')

local M = {}
-- reloads configs and then continues
function M.reload_continue()
  if dap.status() == '' then
    package.loaded['my/dap/debug-configurations'] = nil
  end
  require('my/dap/debug-configurations')
  dap.continue()
end

-- debug adapters
-- Note: the java adapter is set up in jdtls.lua

-- TODO (sbadragan): things that we can add here:
-- -> can we start ondemand dev in cloud in debug mode and hot reoad changes?

return M
