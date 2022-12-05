local dap = require('dap')

-- debug adapters
-- Note: the java adapter is set up in jdtls.lua

-- debug configurations
-- useful Cookbook here: https://github.com/mfussenegger/nvim-dap/wiki/Cookbook
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) local process",
    -- pid = require('dap.utils').pick_process,
    processId = "${command:pickProcess}",
    hostName = "localhost",
    port = 9598
  },
}

-- TODO (sbadragan): fixup
-- ran the following commands to attach to remote process and it worked
-- Telescope dap configurations  --> then pick a process using the selector
-- lua require'dap'.toggle_breakpoint()
-- lua P(require("dap").status())
-- lua require'dap'.terminate()
