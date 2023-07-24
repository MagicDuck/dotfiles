local dap = require('dap')

-- debug adapters
-- Note: the java adapter is set up in jdtls.lua

-- debug configurations
-- useful Cookbook here: https://github.com/mfussenegger/nvim-dap/wiki/Cookbook
-- vscode docs here: https://code.visualstudio.com/docs/java/java-debugging
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) local ondemand webui process",
    -- pid = require('dap.utils').pick_process,
    processId = "${command:pickProcess}",
    hostName = "localhost",
    port = 9598,
    -- projectName = "${workspaceFolderBasename}"
    -- it seems  to need the specific project name in order to function correctly when evaluating expressions in repl, etc.
    projectName = "webui"
  },
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) local process ",
    processId = "${command:pickProcess}",
    hostName = "localhost",
    port = 9598,
    projectName = "${workspaceFolderBasename}"
  },
  -- launching stuff directly did not work for me cause gradle
  -- {
  --   type = 'java',
  --   request = 'launch',
  --   name = "Debug (Launch) ondemand - webui dev in cloud",
  --   -- hostName = "localhost",
  --   -- port = 9598,
  --   projectName = "webui"
  -- },
}

dap.configurations.rust = {
  {
    name = "Launch and debug rust binary for Advent of Code",
    type = 'codelldb',
    request = 'launch',
    program = function()
      -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      return 'target/debug/${workspaceFolderBasename}'
    end,
    cwd = '${workspaceFolder}',
    args = { "input.txt" }
  }
}
