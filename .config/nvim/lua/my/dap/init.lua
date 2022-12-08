require('my/dap/dapui')
require('my/dap/debug-configurations')
local dap = require('dap')

-- debug adapters
-- Note: the java adapter is set up in jdtls.lua

-- TODO (sbadragan): fixup
-- ran the following commands to attach to remote process and it worked
-- Telescope dap configurations  --> then pick a process using the selector
-- lua require'dap'.toggle_breakpoint()
-- lua P(require("dap").status())
-- lua require'dap'.terminate()


-- TODO:
-- show the hover window with the evaluated expression on K
-- add keybinds
-- nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
-- nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
