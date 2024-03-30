-- local nextLeaderKey = function(key)
--   return '<C-S-' .. key .. '>'
-- end
-- local prevLeaderKey = function(key)
--   return '<C-A-' .. key .. '>'
-- end
local nextLeaderKey = function(key)
  return '<leader>j' .. key
end
local prevLeaderKey = function(key)
  return '<leader>k' .. key
end

-- show Mappings picker
my.keybind({
  description = "show a list of key bindings to pick from",
  lhs = "<leader>,",
  rhs = ":lua require('my/plugins/telescope/command_picker').pickKeybindOrCommand({mode = 'n'})<CR>",
})

-- copy/paste/save
my.keybind({
  description = "copy",
  mode = "v",
  lhs = "<C-c>",
  rhs = '"*y',
})
my.keybind({
  description = "paste",
  mode = "i",
  lhs = "<C-v>",
  rhs = '<C-O>"*p',
})
my.keybind({
  description = "save",
  lhs = "<C-s>",
  rhs = ":<C-U>w | lua vim.notify('saved ' .. vim.fn.expand('%'))<CR>",
})
my.keybind({
  description = "save (visual)",
  mode = "v",
  lhs = "<C-s>",
  rhs = "<C-C>:w | lua vim.notify('saved ' .. vim.fn.expand('%'))<CR>",
})
my.keybind({
  description = "save (insert)",
  mode = "i",
  lhs = "<C-s>",
  rhs = "<ESC>:w | lua vim.notify('saved ' .. vim.fn.expand('%'))<CR>",
})

-- buffer
my.keybind({
  description = "buffer: go to previously viewed/edited buffer",
  lhs = "<leader>o",
  rhs = ":b#<CR>",
})
my.keybind({
  description = "buffer: close current buffer while preserving window",
  lhs = "<leader>q",
  rhs = ":Bwipeout<CR>",
})
my.keybind({
  description = "buffer: yank full path of file in current buffer",
  lhs = "<leader>yf",
  rhs = ':let @* = expand("%") | echo "yanked: " . @*<CR>',
})
my.keybind({
  description = "buffer: yank project relative path of file in current buffer",
  lhs = "<leader>yp",
  rhs = ':let @* = expand("%:p") | echo "yanked: " . @*<CR>',
})
my.keybind({
  description = "buffer: yank a jest unit test command for current file",
  lhs = "<leader>yt",
  rhs =
  ':let @* = "env DEBUG_PRINT_LIMIT=100000 pnpm run test --maxWorkers=2 --watch " . expand("%:h:t") . "/" . expand("%:t:r") | echo "yanked: " . @*<CR>',
})
my.keybind({
  description = "buffer: yank a jest unit test command for current file",
  lhs = "<leader>yd",
  rhs =
  ':let @* = "env DEBUG_PRINT_LIMIT=100000 node --inspect ./node_modules/jest/bin/jest.js --watch --maxWorkers=2 " . expand("%:h:t") . "/" . expand("%:t:r") | echo "yanked: " . @*<CR>',
})

-- line
my.keybind({
  description = "line: paste on line above, keeping indentation",
  lhs = "gP",
  rhs = "O<esc>[p",
})
my.keybind({
  description = "line: paste on line below, keeping indentation",
  lhs = "gp",
  rhs = "o<esc>]p",
})

-- quickfix list
my.keybind({
  description = "quickfix list: next entry",
  lhs = prevLeaderKey("f"),
  rhs = ":Cprev<CR>",
})
my.keybind({
  description = "quickfix list: previous entry",
  lhs = nextLeaderKey("f"),
  rhs = ":Cnext<CR>",
})
my.keybind({
  description = "quickfix list: rename",
  lhs = "<leader>qr",
  rhs = ":call setqflist([], 'r', {'title': input('New Quickfix List Name: ')})<CR>",
})

-- conflict resolution
my.keybind({
  description = "conflict resolution: diff get from left",
  lhs = nextLeaderKey('o'),
  rhs = ":diffget 3<CR>",
})
my.keybind({
  description = "conflict resolution: diff get from right",
  lhs = prevLeaderKey('o'),
  rhs = ":diffget 1<CR>",
})
my.keybind({
  description = "conflict resolution: next conflict",
  lhs = nextLeaderKey('c'),
  -- rhs = "]n",
  rhs = "<Plug>(unimpaired-context-next)",
})
my.keybind({
  description = "conflict resolution: prev conflict",
  lhs = prevLeaderKey('c'),
  -- rhs = "[n",
  rhs = "<Plug>(unimpaired-context-previous)",
})

-- tabs
my.keybind({
  description = "tab: navigate to previous tab",
  lhs = "<C-h>",
  rhs = "<cmd>tabprevious<CR>",
  mode = "niv",
})
my.keybind({
  description = "tab: navigate to next tab",
  lhs = "<C-l>",
  rhs = "<cmd>tabnext<CR>",
  mode = "niv",
})
my.keybind({
  description = "tab: navigate to previous tab",
  lhs = "<C-Left>",
  rhs = "<cmd>tabprevious<CR>",
  mode = "niv",
})
my.keybind({
  description = "tab: navigate to next tab",
  lhs = "<C-Right>",
  rhs = "<cmd>tabnext<CR>",
  mode = "niv",
})
my.keybind({
  description = "tab: create new tab",
  lhs = "<leader>tn",
  rhs = "<cmd>tabnew | Alpha<CR>",
})
my.keybind({
  description = "tab: close current tab",
  lhs = "<leader>tc",
  rhs = "<cmd>tabclose<CR>",
})
my.keybind({
  description = "tab: pick tab using telescope",
  lhs = "<leader>tf",
  rhs = "<cmd>lua require('my/plugins/telescope/tab_picker').pickTab()<CR>",
})
my.keybind({
  description = "tab: pick tab using telescope",
  lhs = "<leader>tt",
  rhs = "<cmd>PickBookmark<CR>",
})
my.keybind({
  description = "tab: rename",
  lhs = "<leader>tr",
  rhs = ":TabRename<space>",
  options = { silent = false, noremap = true },
})

-- windows
my.keybind({
  description = "window: enter window mode",
  mode = "n",
  lhs = "s",
  rhs = "<C-W>",
  options = { silent = false, noremap = true },
})
my.keybind({
  description = "window: resize down",
  lhs = "<M-j>",
  rhs = ":resize -2<CR>",
})
my.keybind({
  description = "window: resize up",
  lhs = "<M-k>",
  rhs = ":resize +2<CR>",
})
my.keybind({
  description = "window: resize left",
  lhs = "<M-h>",
  rhs = ":vertical resize -2<CR>",
})
my.keybind({
  description = "window: resize right",
  lhs = "<M-l>",
  rhs = ":vertical resize +2<CR>",
})

-- better nav for omnicomplete
-- inoremap <expr> <c-j> ("\<C-n>")
-- inoremap <expr> <c-k> ("\<C-p>")
-- my.keybind {
--   description = "omnicomplete: nav down",
--   mode = "i",
--   lhs = "<C-j>",
--   -- rhs = my.termcode("<C-n>"),
--   rhs = "<C-n>",
--   options = {expr = true}
-- }
-- my.keybind {
--   description = "omnicomplete: nav up",
--   mode = "i",
--   lhs = "<C-k>",
--   -- rhs = my.termcode("<C-p>"),
--   rhs = "<C-p>",
--   options = {expr = true}
-- }

-- easy capitalization
my.keybind({
  description = "current word: capitalize (visual)",
  mode = "i",
  lhs = "<M-u>",
  rhs = "<ESC>viwUi",
})
my.keybind({
  description = "current word: capitalize",
  lhs = "<M-u>",
  rhs = "viwU<ESC>",
})

-- improved indentation
my.keybind({
  description = "indentation: indent left",
  mode = "v",
  lhs = "<",
  rhs = "<gv",
})
my.keybind({
  description = "indentation: indent right",
  mode = "v",
  lhs = ">",
  rhs = ">gv",
})

-- highlighting
my.keybind({
  description = "highlighting: clear search highlight",
  lhs = "<leader>uv",
  rhs = ':let @/ = ""<CR>',
})

-- marks
local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #letters do
  local letter = letters:sub(i, i)
  local uppercaseLetter = letter:upper()
  my.keybind({
    description = "marks: set mark " .. uppercaseLetter,
    lhs = "m" .. letter,
    rhs = "m" .. uppercaseLetter,
  })
  my.keybind({
    description = "marks: go to mark " .. uppercaseLetter,
    lhs = "'" .. letter,
    rhs = "'" .. uppercaseLetter,
  })
end

-- startify
my.keybind({
  description = "open startify",
  lhs = "<leader>i",
  rhs = ":lua if (vim.bo.filetype ~= 'alpha') then vim.cmd('Alpha') end<CR>",
})


-- git
-- my.keybind({
--   description = "git: status",
--   lhs = "<leader>gg",
--   rhs = ":Neogit<CR>",
-- })
my.keybind({
  description = "git: blame",
  lhs = "<leader>gb",
  rhs = ":Git blame<CR>",
})
my.keybind({
  description = "git: status in new tab",
  lhs = "<leader>gs",
  rhs = ":Gtabedit :<CR>",
})
my.keybind({
  description = "git: open current file in web browser (stash)",
  lhs = "<leader>go",
  rhs = ":GBrowse<CR>",
})
my.keybind({
  description = "git: pick from modified git files",
  lhs = "<leader>gm",
  rhs = ":GFiles?<CR>",
})
-- my.keybind({
-- 	description = "git: history time lapse view of current file changes",
-- 	lhs = "<leader>gh",
-- 	rhs = ":GitTimeLapse<CR>",
-- })
my.keybind({
  description = "git: log status using diffview",
  lhs = "<leader>gl",
  rhs = ":DiffviewOpen<CR>",
})
my.keybind({
  mode = "n",
  description = "git: log file history using diffview",
  lhs = "<leader>gh",
  rhs = ":DiffviewFileHistory %<CR>",
})
my.keybind({
  mode = "v",
  description = "git: log selected region history using diffview",
  lhs = "<leader>gh",
  rhs = ":'<,'>DiffviewFileHistory<CR>",
})

-- ranger
-- my.keybind({
--   description = "ranger: toggle open",
--   lhs = "<leader>r",
--   rhs = ":RnvimrToggle<CR>",
-- })
-- my.keybind({
--   description = "ranger: toggle open (extra binding that works in terminal mode)",
--   lhs = "<M-o>",
--   rhs = ":RnvimrToggle<CR>",
-- })
-- my.keybind({
--   mode = "t",
--   description = "ranger: toggle open (extra binding that works in terminal mode)",
--   lhs = "<M-o>",
--   rhs = "<C-\\><C-n>:RnvimrToggle<CR>",
-- })
-- file browser
my.keybind({
  description = "file browser: toggle open",
  lhs = "<leader>r",
  rhs = ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
})
my.keybind({
  description = "ranger: toggle open (extra binding that works in terminal mode)",
  lhs = "<M-o>",
  rhs = ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
})
my.keybind({
  mode = "t",
  description = "ranger: toggle open (extra binding that works in terminal mode)",
  lhs = "<M-o>",
  rhs = "<C-\\><C-n>:Telescope file_browser path=%:p:h select_buffer=true<CR>",
})

-- easy align
-- my.keybind({
--   description = "Easy Align: Start interactive EasyAlign for (e.g. gaip, vipga)",
--   mode = "nvsox",
--   lhs = "ga",
--   rhs = "<Plug>(EasyAlign)",
-- })

-- fuzzy find things
my.keybind({
  description = "Search: pick from existing buffers",
  lhs = "<leader>b",
  -- rhs = ":Buffers<CR>"
  rhs = ":Telescope buffers<CR>",
})
my.keybind({
  description = "Search: pick from project files",
  lhs = "<leader>d",
  -- rhs = ":MyFiles<CR>"
  rhs = ":Telescope find_files<CR>",
})
my.keybind({
  description = "Search: pick from project files (alternate keybind)",
  lhs = "<C-p>",
  -- rhs = ":MyFiles<CR>"
  rhs = ":Telescope find_files<CR>",
})
my.keybind({
  description = "Search: find text in project files",
  lhs = "<leader>f",
  -- rhs = ":Search<CR>"
  rhs = ":Telescope live_grep<CR>",
  -- rhs = ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>',
})
-- my.keybind({
--   description = "Search: find text in project files",
--   lhs = "<leader>f",
--   rhs = ":FzfLua live_grep<CR>",
-- })
-- my.keybind {
--   description = "Search: pick a mark location",
--   lhs = "<leader>j",
--   rhs = ":MarksWithPreview<CR>"
-- }
my.keybind({
  description = "Search: pick a line in the current buffer",
  lhs = "<leader>sb",
  -- rhs = ":BLines<CR>"
  rhs = ":Telescope current_buffer_fuzzy_find<CR>",
})
my.keybind({
  description = "Search: pick a line in all opened buffers",
  lhs = "<leader>sl",
  rhs = ":Lines<CR>",
})
my.keybind({
  mode = "v",
  description = "Search: find current selection under cursor in project",
  lhs = "<leader>sf",
  rhs = 'y<ESC>:lua require("telescope.builtin").live_grep({ default_text="<c-r>0" })<CR>',
})
my.keybind({
  mode = "n",
  description = "Search: find current word under cursor in project",
  lhs = "<leader>sf",
  rhs = 'y<ESC>:lua require("telescope.builtin").live_grep({ default_text=vim.fn.expand("<cword>") })<CR>',
})
my.keybind({
  description = "Search: replace in files using spectre",
  lhs = "<leader>sd",
  rhs = ":Spectre<CR>",
})
my.keybind({
  description = "Search: find in help tags",
  lhs = "<leader>sh",
  rhs = ":Telescope help_tags<CR>",
})

-- notes
my.keybind({
  description = "notes: open notes dir",
  lhs = "<leader>ne",
  rhs = ":cd ~/notes/ | Alpha<CR>",
})
my.keybind({
  description = "notes: pick a note file",
  lhs = "<leader>nd",
  rhs = ":MyFiles ~/notes/<CR>",
})
my.keybind({
  description = "notes: find in note files",
  lhs = "<leader>nf",
  rhs = ":SearchNotes<CR>",
})
my.keybind({
  description = "notes: open notes dir with ranger",
  lhs = "<leader>nr",
  rhs = ":e ~/notes/ | RnvimrToggle<CR>",
})
my.keybind({
  description = "notes: todo: open buffer todos in loclist",
  lhs = "<leader>ng",
  rhs = ":lvimgrep /\\[[ ]\\]/ % | lopen<CR>",
})
my.keybind({
  description = "notes: add/edit note",
  lhs = "<leader>na",
  rhs = ":EditNote ",
  options = { silent = false },
})
my.keybind({
  description = "notes: add/edit note for current git branch",
  lhs = "<leader>nb",
  rhs = ":EditNoteForBranch<CR>",
})
my.keybind({
  description = "notes: todo comments: add on line above",
  lhs = "<leader>nt",
  rhs = ":lua require('my/todos').addTodoCommentToLineAbove()<CR>",
})
my.keybind({
  description = "notes: todo comments: search in project",
  lhs = "<leader>ns",
  rhs = ":TODOTelescope<CR>",
  -- rhs = ":SearchForTodoComments<CR>",
})

-- LSP
my.keybind({
  description = "lsp: symbol: trigger hover help popup",
  lhs = "K",
  rhs = ":lua vim.lsp.buf.hover()<CR>",
})
my.keybind({
  description = "lsp: symbol: trigger signature help popup",
  lhs = "<leader>ls",
  rhs = ":lua vim.lsp.buf.signature_help()<CR>",
})
my.keybind({
  description = "lsp: symbol: go to declaration",
  lhs = "gD",
  rhs = ":lua vim.lsp.buf.declaration()<CR>",
})
my.keybind({
  description = "lsp: symbol: go to definition",
  lhs = "gd",
  rhs = ":lua vim.lsp.buf.definition()<CR>",
})
my.keybind({
  description = "lsp: symbol: go to definition in new tab",
  lhs = "gt",
  rhs = "<C-W>v<C-W>T:lua vim.lsp.buf.definition()<CR>",
})
my.keybind({
  description = "lsp: symbol: go to definition in vertical split",
  lhs = "gv",
  rhs = "<C-W>v:lua vim.lsp.buf.definition()<CR>",
})
my.keybind({
  description = "lsp: symbol: go to type definition",
  lhs = "gy",
  rhs = ":lua vim.lsp.buf.type_definition()<CR>",
})
my.keybind({
  description = "lsp: symbol: go to implementation",
  lhs = "gm",
  rhs = ":lua vim.lsp.buf.implementation()<CR>",
})
my.keybind({
  description = "lsp: symbol: go to references",
  lhs = "gr",
  rhs = ":lua vim.lsp.buf.references() <CR>",
})
my.keybind({
  description = "lsp: symbol: rename",
  lhs = "<leader>lr",
  rhs = ":lua vim.lsp.buf.rename()<CR>",
})
my.keybind({
  description = "lsp: code action: pick",
  lhs = "<leader>la",
  rhs = ":lua vim.lsp.buf.code_action()<CR>",
})
my.keybind({
  description = "lsp: diagnostics: show from current line",
  lhs = "<leader>ld",
  rhs = ":lua vim.diagnostic.open_float()<CR>",
})
my.keybind({
  description = "lsp: diagnostics: go to previous",
  lhs = prevLeaderKey('d'),
  rhs = ":lua vim.diagnostic.goto_prev()<CR>",
})
my.keybind({
  description = "lsp: diagnostics: go to next",
  lhs = nextLeaderKey('d'),
  rhs = ":lua vim.diagnostic.goto_next()<CR>",
})
my.keybind({
  description = "lsp: diagnostics: put all buffer diagnostics into the loclist",
  lhs = "<leader>ll",
  rhs = ":lua vim.diagnostic.setloclist()<CR>",
})
my.keybind({
  description = "lsp: format current buffer",
  lhs = "<leader>lf",
  rhs = "<cmd>lua vim.lsp.buf.formatting()<CR>",
})
my.keybind({
  description = "format json",
  lhs = "<leader>fj",
  rhs = ":%!jq .<CR>",
})

-- hop
-- my.keybind({
--   mode = "nvxo",
--   description = "hop to word",
--   lhs = "f",
--   -- rhs = "<cmd>HopChar2<CR>"
--   rhs = "<cmd>HopWord<CR>",
-- })
-- my.keybind({
--   mode = "nv",
--   description = "hop to line",
--   lhs = "F",
--   rhs = "<cmd>HopLine<CR>",
-- })
-- leap
-- my.keybind({
--   mode = "nvxo",
--   description = "leap to location",
--   lhs = "f",
--   rhs = "<cmd>MyLeapCurrentWindow<CR>",
-- })
-- my.keybind({
--   mode = "nvxo",
--   description = "leap to location all tab windows",
--   lhs = "F",
--   rhs = "<cmd>MyLeapAllWindows<CR>",
-- })
-- leap
my.keybind({
  mode = "nxo",
  description = "flash to location",
  lhs = "f",
  rhs = "<cmd>lua require('flash').jump()<cr>",
})
my.keybind({
  mode = "nxo",
  description = "flash: select using treesitter",
  lhs = ",",
  rhs = "<cmd>lua require('flash').treesitter()<cr>",
})
my.keybind({
  mode = "n",
  description = "leap line select",
  lhs = "R",
  rhs =
  "<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('Vf<space><space>', true, false, true), 't', true)<CR>",
})
my.keybind({
  mode = "n",
  description = "leap line select",
  lhs = "Y",
  rhs =
  "<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('yf<space><space>', true, false, true), 't', true)<CR>",
})

-- replace
my.keybind({
  mode = "n",
  description = "replace current word in file",
  lhs = "<leader>sr",
  rhs = ":%s/<C-r><C-w>//g<Left><Left>",
  options = { silent = false },
})
-- scrolling
my.keybind({
  mode = "n",
  description = "scroll down",
  lhs = "<PageDown>",
  rhs = "30j",
  -- rhs = "<cmd>lua require('neoscroll').scroll(0.1, true, 8)<cr>"
})
my.keybind({
  mode = "n",
  description = "scroll up",
  lhs = "<PageUp>",
  rhs = "30k",
  -- rhs = "<cmd>lua require('neoscroll').scroll(-0.1, true, 8)<cr>"
})

-- vimspector debugging
-- my.keybind({
--   description = "debugger: when debugging, continue. Otherwise start debugging",
--   lhs = ",dd",
--   rhs = ":call vimspector#Continue()<CR>",
-- })
-- my.keybind({
--   description = "debugger: stop",
--   lhs = ",dx",
--   rhs = "<Plug>VimspectorStop",
-- })
-- my.keybind({
--   description = "debugger: restart debugging with the same configuration",
--   lhs = ",dr",
--   rhs = "<Plug>VimspectorRestart",
-- })
-- my.keybind({
--   description = "debugger: pause",
--   lhs = ",dp",
--   rhs = "<Plug>VimspectorPause",
-- })
-- my.keybind({
--   description = "debugger: toggle line breakpoint",
--   lhs = ",db",
--   rhs = "<Plug>VimspectorToggleBreakpoint",
-- })
-- my.keybind({
--   description = "debugger: toggle conditional line breakpoint",
--   lhs = ",dn",
--   rhs = "<Plug>VimspectorToggleConditionalBreakpoint",
-- })
-- my.keybind({
--   description = "debugger: add a function breakpoint for expression under cursor",
--   lhs = ",df",
--   rhs = "<Plug>VimspectorAddFunctionBreakpoint",
-- })
-- my.keybind({
--   description = "debugger: run to cursor",
--   lhs = ",du",
--   rhs = "<Plug>VimspectorRunToCursor",
-- })
-- my.keybind({
--   description = "debugger: step over",
--   lhs = ",dl",
--   rhs = "<Plug>VimspectorStepOver",
-- })
-- my.keybind({
--   description = "debugger: step into",
--   lhs = ",dm",
--   rhs = "<Plug>VimspectorStepInto",
-- })
-- my.keybind({
--   description = "debugger: step out",
--   lhs = ",da",
--   rhs = "<Plug>VimspectorStepOut",
-- })
-- my.keybind({
--   description = "debugger: evaluate expression under cursor (or visual) in popup",
--   lhs = ",de",
--   rhs = "<Plug>VimspectorBalloonEval",
-- })
-- my.keybind({
--   description = "debugger: jump to call stack window",
--   lhs = ",ds",
--   rhs = ":call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>",
-- })
-- my.keybind({
--   description = "debugger: jump to variables window",
--   lhs = ",dv",
--   rhs = ":call win_gotoid(g:vimspector_session_windows.variables)<CR>",
-- })
-- my.keybind({
--   description = "debugger: jump to watches window",
--   lhs = ",dw",
--   rhs = ":call win_gotoid(g:vimspector_session_windows.watches)<CR>",
-- })
-- my.keybind({
--   description = "debugger: jump to output window",
--   lhs = ",do",
--   rhs = ":call win_gotoid(g:vimspector_session_windows.output)<CR>",
-- })
-- my.keybind({
--   description = "debugger: jump to code window",
--   lhs = ",dc",
--   rhs = ":call win_gotoid(g:vimspector_session_windows.code)<CR>",
-- })
-- my.keybind({
--   description = "debugger: jump to terminal window",
--   lhs = ",dt",
--   rhs = ":call win_gotoid(g:vimspector_session_windows.terminal)<CR>",
-- })
-- my.keybind({
--   description = "debugger: reset (quit)",
--   lhs = ",dq",
--   rhs = ":VimspectorReset<CR>",
-- })

-- dap debugging
my.keybind({
  description = "debugger: when debugging, continue. Otherwise start debugging",
  lhs = "<leader>ec",
  rhs = ":MyDapReloadContinue<CR>",
})
my.keybind({
  description = "debugger: pause",
  lhs = "<leader>ep",
  rhs = ":lua require('dap').pause()<CR>",
})
my.keybind({
  description = "debugger: step over",
  lhs = "<leader>er",
  rhs = ":lua require('dap').step_over()<CR>",
})
my.keybind({
  description = "debugger: step into",
  lhs = "<leader>ei",
  rhs = ":lua require('dap').step_into()<CR>",
})
my.keybind({
  description = "debugger: step out",
  lhs = "<leader>eo",
  rhs = ":lua require('dap').step_out()<CR>",
})
my.keybind({
  description = "debugger: step back",
  lhs = "<leader>ea",
  rhs = ":lua require('dap').step_back()<CR>",
})
my.keybind({
  description = "debugger: run to cursor (temporarily removes all other breakpoints and adds them back after)",
  lhs = "<leader>ej",
  rhs = ":lua require('dap').run_to_cursor()<CR>",
})
my.keybind({
  description = "debugger: toggle breakpoint",
  lhs = "<leader>eb",
  rhs = ":lua require('dap').toggle_breakpoint()<CR>",
})
my.keybind({
  description = "debugger: set conditional breakpoint",
  lhs = "<leader>ek",
  rhs = ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
})
my.keybind({
  description = "debugger: set log point",
  lhs = "<leader>el",
  rhs = ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
})
my.keybind({
  description = "debugger: open/focus REPL",
  lhs = "<leader>ef",
  rhs = ":lua require('dap').repl_open()<CR>",
})
my.keybind({
  description = "debugger: re-run the last debug adapter / configuration that ran",
  lhs = "<leader>ed",
  rhs = ":lua require('dap').run_last()<CR>",
})
my.keybind({
  mode = "nv",
  description = "debugger: evaluate expression under cursor (works with selection in visual mode)",
  lhs = "<leader>ee",
  rhs = ":lua require('dap.ui.widgets').hover()<CR>",
})
my.keybind({
  mode = "n",
  description = "debugger: terminate",
  lhs = "<leader>eq",
  rhs = ":lua require('dap').terminate()<CR>",
})

my.keybind({
  mode = "n",
  description = "markdown: preview open",
  lhs = "<leader>po",
  rhs = ":PeekOpen<CR>",
})
my.keybind({
  mode = "n",
  description = "markdown: preview open",
  lhs = "<leader>pc",
  rhs = ":PeekClose<CR>",
})

-- switch to alternate file
my.keybind({
  mode = "n",
  description = "vsplit edit associated file: jsx file",
  lhs = "<leader>vf",
  rhs = ":lua vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.jsx')<CR>",
})
my.keybind({
  mode = "n",
  description = "vsplit edit associated file: spec file",
  lhs = "<leader>vt",
  rhs = ":lua vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.spec.js')<CR>",
})
my.keybind({
  mode = "n",
  description = "vsplit edit associated file: module scss file",
  lhs = "<leader>vc",
  rhs = ":lua vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.module.scss')<CR>",
})
