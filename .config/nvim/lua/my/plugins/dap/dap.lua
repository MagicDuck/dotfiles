require('my/plugins/dap/debug-configurations')
local dap = require('dap')

-- reloads configs and then continues
local function reload_continue()
  if dap.status() == '' then
    package.loaded['my/dap/debug-configurations'] = nil
  end
  require('my/dap/debug-configurations')
  dap.continue()
end

vim.api.nvim_create_user_command('MyDapReloadContinue', reload_continue, {})

-- debug adapters
-- Note: the java adapter is set up in jdtls.lua
