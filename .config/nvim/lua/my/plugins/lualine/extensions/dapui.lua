local utils = require("my/plugins/lualine/utils")

local M = {}

M.sections = {
  lualine_b = {
    utils.createSpaceComponent("MyMenubarInactiveCap"),
    { 'filename', file_status = false }
  },
}

M.filetypes = {
  'dap-repl',
  'dapui_console',
  'dapui_watches',
  'dapui_stacks',
  'dapui_breakpoints',
  'dapui_scopes',
}

return M
