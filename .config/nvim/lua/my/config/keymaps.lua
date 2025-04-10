---@module 'snacks'

local is_linux = vim.fn.has('linux') == 1

local nextLeaderKey = function(key)
  return '<leader>j' .. key
end
local prevLeaderKey = function(key)
  return '<leader>k' .. key
end

-- base keymaps --------------------------------------------------------------------------------

vim.cmd([[
  " wildmenu swap arrow keys and left right
  cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
  cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
  cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
  cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

  " better completion
  " inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " inoremap <expr> <c-j> ("\<C-n>")
  " inoremap <expr> <c-k> ("\<C-p>")

  " copy/paste
  vnoremap <C-c> *y
  inoremap <C-v> <C-O>"*p

  " save
  nnoremap <C-s> :<C-U>w<CR>
  vnoremap <C-s> <C-C>:w<CR>
  inoremap <C-s> <ESC>:w<CR>

  " slightly easier :command
  noremap ; :

  " esc in terminal mode
  tnoremap <s-esc> <C-\><C-n>

  " visual block select
  nnoremap X <c-v>

  " don't overwrite copied text when pasting in visual mode
  " vnoremap p "0p
  " vnoremap P "0P
  xnoremap p pgvy

  " easier visual line select
  " nnoremap vv V

  " line begin and end
  nnoremap H ^
  vnoremap H ^
  onoremap H ^
  nnoremap L $
  vnoremap L $
  onoremap L $

  inoremap <Home> <Esc>^i
  nnoremap <Home> ^
  vnoremap <Home> ^
  onoremap <Home> ^

  " Quickfix list navigation that loops around
  command! Cnext try | cnext | catch | cfirst | catch | endtry
  command! Cprev try | cprev | catch | clast | catch | endtry
  command! Lnext try | lnext | catch | lfirst | catch | endtry
  command! Lprev try | lprev | catch | llast | catch | endtry

  cabbrev cnext Cnext
  cabbrev cprev Cprev
  cabbrev lnext Lnext
  cabbrev lprev Lprev

  xnoremap il 0o$h
  onoremap il :normal vil<CR>
]])

if is_linux then
  vim.cmd([[
    " ctrl-based motions
    " c-h is c-bs
    inoremap <c-h> <c-w>
    inoremap <c-del> <c-o>de
    inoremap <c-left> <c-o>b
    inoremap <c-right> <c-o>w
    inoremap <c-up> <c-o>^
    inoremap <c-down> <c-o>$

    " cnoremap <c-bs> <c-w>
    cnoremap <c-del> <del>
    cnoremap <c-left> <s-left>
    cnoremap <c-right> <s-right>
    cnoremap <c-up> <home>
    cnoremap <c-down> <end>

    " tnoremap <c-bs> <c-w>
    tnoremap <c-Del> <a-d> 
    tnoremap <c-left> <a-b>
    tnoremap <c-right> <a-f>
    tnoremap <c-up> <home>
    tnoremap <c-down> <end>
    ]])
else
  vim.cmd([[
    " alt-based motions
    inoremap <a-bs> <c-w>
    inoremap <a-del> <c-o>de
    inoremap <a-left> <c-o>b
    inoremap <a-right> <c-o>w
    inoremap <a-up> <c-o>^
    inoremap <a-down> <c-o>$

    cnoremap <a-bs> <c-w>
    cnoremap <a-del> <del>
    cnoremap <a-left> <s-left>
    cnoremap <a-right> <s-right>
    cnoremap <a-up> <home>
    cnoremap <a-down> <end>

    tnoremap <a-bs> <c-w>
    tnoremap <a-Del> <a-d> 
    tnoremap <a-left> <a-b>
    tnoremap <a-right> <a-f>
    tnoremap <a-up> <home>
    tnoremap <a-down> <end>
    ]])
end

-- other keymaps-------------------------------------------------------------------------------

-- show Mappings picker
my.keybind('<leader>,', function()
  require('my/plugins/telescope/command_picker').pickKeybindOrCommand({ mode = 'n' })
end, { desc = 'show a list of key bindings to pick from' })

-- my.keybind({
--   desc = 'show a list of key bindings to pick from',
--   lhs = '<leader>,',
--   rhs = function()
--     require('my/plugins/telescope/command_picker').pickKeybindOrCommand({ mode = 'n' })
--   end,
-- })
--
-- -- buffer
-- my.keybind({
--   desc = 'buffer: go to previously viewed/edited buffer',
--   lhs = '<leader>o',
--   rhs = ':b#<CR>',
-- })
-- my.keybind({
--   desc = 'buffer: close current buffer while preserving window',
--   lhs = '<leader>x',
--   rhs = ':Bwipeout<CR>',
-- })
-- my.keybind({
--   desc = 'buffer: yank project relative path of file in current buffer',
--   lhs = '<leader>yf',
--   rhs = ':let @* = expand("%") | echo "yanked: " . @*<CR>',
-- })
-- my.keybind({
--   desc = 'buffer: yank full path of file in current buffer',
--   lhs = '<leader>yp',
--   rhs = ':let @* = expand("%:p") | echo "yanked: " . @*<CR>',
-- })
-- my.keybind({
--   desc = 'buffer: yank a jest unit test command for current file',
--   lhs = '<leader>yt',
--   rhs = ':let @* = "env DEBUG_PRINT_LIMIT=100000 pnpm run test --maxWorkers=2 --watch " . expand("%:h:t") . "/" . expand("%:t:r") | echo "yanked: " . @*<CR>',
-- })
-- my.keybind({
--   desc = 'buffer: yank a jest unit test command for current file',
--   lhs = '<leader>yd',
--   rhs = ':let @* = "env DEBUG_PRINT_LIMIT=100000 node --inspect ./node_modules/jest/bin/jest.js --watch --maxWorkers=2 " . expand("%:h:t") . "/" . expand("%:t:r") | echo "yanked: " . @*<CR>',
-- })
--
-- my.keybind({
--   desc = 'buffer: rename',
--   lhs = '<leader>ur',
--   rhs = function()
--     local old_name = vim.api.nvim_buf_get_name(0)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':file ' .. old_name, true, false, true), 't', true)
--   end,
-- })
--
-- -- line
-- my.keybind({
--   desc = 'line: paste on line above, keeping indentation',
--   lhs = 'gP',
--   rhs = 'O<esc>[p',
-- })
-- my.keybind({
--   desc = 'line: paste on line below, keeping indentation',
--   lhs = 'gp',
--   rhs = 'o<esc>]p',
-- })
--
-- -- quickfix list
-- my.keybind({
--   desc = 'quickfix list: next entry',
--   lhs = prevLeaderKey('f'),
--   rhs = ':Cprev<CR>',
-- })
-- my.keybind({
--   desc = 'quickfix list: previous entry',
--   lhs = nextLeaderKey('f'),
--   rhs = ':Cnext<CR>',
-- })
-- my.keybind({
--   desc = 'quickfix list: rename',
--   lhs = '<leader>qr',
--   rhs = ":call setqflist([], 'r', {'title': input('New Quickfix List Name: ')})<CR>",
-- })
-- my.keybind({
--   desc = 'quickfix list: toggle',
--   lhs = '<leader>sd',
--   rhs = function()
--     local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
--     local action = qf_winid > 0 and 'cclose' or 'copen'
--     vim.cmd('botright ' .. action)
--   end,
-- })
-- my.keybind({
--   desc = 'quickfix list: history',
--   lhs = '<leader>sk',
--   rhs = ':Telescope quickfixhistory<CR>',
-- })
--
-- -- conflict resolution
-- my.keybind({
--   desc = 'conflict resolution: diff get from left',
--   lhs = nextLeaderKey('o'),
--   rhs = ':diffget 3<CR>',
-- })
-- my.keybind({
--   desc = 'conflict resolution: diff get from right',
--   lhs = prevLeaderKey('o'),
--   rhs = ':diffget 1<CR>',
-- })
-- my.keybind({
--   desc = 'conflict resolution: next conflict',
--   lhs = nextLeaderKey('c'),
--   -- rhs = "]n",
--   rhs = '<Plug>(unimpaired-context-next)',
-- })
-- my.keybind({
--   desc = 'conflict resolution: prev conflict',
--   lhs = prevLeaderKey('c'),
--   -- rhs = "[n",
--   rhs = '<Plug>(unimpaired-context-previous)',
-- })
--
-- -- tabs
-- my.keybind({
--   desc = 'tab: navigate to previous tab',
--   lhs = '<left>',
--   rhs = '<cmd>tabprevious<CR>',
-- })
-- my.keybind({
--   desc = 'tab: navigate to next tab',
--   lhs = '<right>',
--   rhs = '<cmd>tabnext<CR>',
-- })
-- my.keybind({
--   desc = 'tab: create new tab',
--   lhs = '<leader>tn',
--   rhs = '<cmd>tabnew | Alpha<CR>',
-- })
-- my.keybind({
--   desc = 'tab: duplicate current tab',
--   lhs = '<leader>td',
--   rhs = '<cmd>tabnew %<CR>',
-- })
-- my.keybind({
--   desc = 'tab: close current tab',
--   lhs = '<leader>tc',
--   rhs = '<cmd>tabclose<CR>',
-- })
-- my.keybind({
--   desc = 'tab: pick tab using telescope',
--   lhs = '<leader>st',
--   rhs = "<cmd>lua require('my/plugins/telescope/tab_picker').pickTab()<CR>",
-- })
-- my.keybind({
--   desc = 'tab: edit bookmark in new tab',
--   lhs = '<leader>tt',
--   rhs = '<cmd>EditBookmarkAsTab<CR>',
-- })
-- my.keybind({
--   desc = 'tab: edit bookmark in current tab',
--   lhs = '<leader>to',
--   rhs = '<cmd>EditBookmark<CR>',
-- })
-- my.keybind({
--   desc = 'tab: rename',
--   lhs = '<leader>tr',
--   rhs = ':TabRename<space>',
--   options = { silent = false, noremap = true },
-- })
--
-- -- windows
-- my.keybind({
--   desc = 'window: enter window mode',
--   lhs = 's',
--   rhs = '<C-W>',
--   options = { silent = false, noremap = true },
-- })
-- my.keybind({
--   desc = 'window: resize down',
--   lhs = '<M-j>',
--   rhs = ':resize -2<CR>',
-- })
-- my.keybind({
--   desc = 'window: resize up',
--   lhs = '<M-k>',
--   rhs = ':resize +2<CR>',
-- })
-- my.keybind({
--   desc = 'window: resize left',
--   lhs = '<M-h>',
--   rhs = ':vertical resize -2<CR>',
-- })
-- my.keybind({
--   desc = 'window: resize right',
--   lhs = '<M-l>',
--   rhs = ':vertical resize +2<CR>',
-- })
--
-- -- easy capitalization
-- my.keybind({
--   desc = 'current word: capitalize (visual)',
--   mode = 'i',
--   lhs = '<M-u>',
--   rhs = '<ESC>viwUi',
-- })
-- my.keybind({
--   desc = 'current word: capitalize',
--   lhs = '<M-u>',
--   rhs = 'viwU<ESC>',
-- })
--
-- -- improved indentation
-- my.keybind({
--   desc = 'indentation: indent left',
--   mode = 'v',
--   lhs = '<',
--   rhs = '<gv',
-- })
-- my.keybind({
--   desc = 'indentation: indent right',
--   mode = 'v',
--   lhs = '>',
--   rhs = '>gv',
-- })
--
-- my.keybind({ '<leader><leader>', ':let @/ = ""<CR>', desc = 'highlighting: clear search highlight' })
-- -- highlighting
-- my.keybind({
--   desc = 'highlighting: clear search highlight',
--   lhs = '<leader><leader>',
--   rhs = ':let @/ = ""<CR>',
-- })
--
-- -- docgen
-- my.keybind({
--   desc = 'highlighting: clear search highlight',
--   lhs = '<leader>hi',
--   rhs = function()
--     require('neogen').generate()
--   end,
-- })
--
-- -- marks
-- local letters = 'abcdefghijklmnopqrstuvwxyz'
-- for i = 1, #letters do
--   local letter = letters:sub(i, i)
--   local uppercaseLetter = letter:upper()
--   my.keybind({
--     desc = 'marks: set mark ' .. uppercaseLetter,
--     lhs = 'm' .. letter,
--     rhs = 'm' .. uppercaseLetter,
--   })
--   my.keybind({
--     desc = 'marks: go to mark ' .. uppercaseLetter,
--     lhs = "'" .. letter,
--     rhs = "'" .. uppercaseLetter,
--   })
-- end
--
-- -- startify
-- my.keybind({
--   desc = 'open startify',
--   lhs = '<leader>i',
--   rhs = function()
--     if vim.bo.filetype ~= 'alpha' then
--       vim.cmd('Alpha')
--     end
--   end,
-- })
--
-- -- git
-- my.keybind({
--   desc = 'git: blame',
--   lhs = '<leader>gb',
--   rhs = ':Git blame<CR>',
-- })
-- my.keybind({
--   desc = 'git: status in new tab',
--   lhs = '<leader>gs',
--   rhs = ':Gtabedit :<CR>',
-- })
-- my.keybind({
--   desc = 'git: open current file in web browser (stash)',
--   lhs = '<leader>go',
--   rhs = ':GBrowseMain<CR>',
-- })
-- my.keybind({
--   desc = 'git: pick from modified git files',
--   lhs = '<leader>gm',
--   rhs = ':GFiles?<CR>',
-- })
-- -- my.keybind({
-- -- 	desc ="git: history time lapse view of current file changes",
-- -- 	lhs = "<leader>gh",
-- -- 	rhs = ":GitTimeLapse<CR>",
-- -- })
-- my.keybind({
--   desc = 'git: log status using diffview',
--   lhs = '<leader>gl',
--   rhs = ':DiffviewOpen<CR>',
-- })
-- my.keybind({
--   desc = 'git: log file history using diffview',
--   lhs = '<leader>gh',
--   rhs = ':DiffviewFileHistory %<CR>',
-- })
-- my.keybind({
--   mode = 'v',
--   desc = 'git: log selected region history using diffview',
--   lhs = '<leader>gh',
--   rhs = ":'<,'>DiffviewFileHistory<CR>",
-- })
--
-- -- file browser
-- my.keybind({
--   desc = 'file browser: open at file',
--   lhs = '<leader>r',
--   rhs = ':Yazi<CR>',
-- })
-- -- my.keybind({
-- --   desc ='file browser: toggle open',
-- --   lhs = '<leader>r',
-- --   rhs = ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
-- -- })
-- -- my.keybind({
-- --   desc ='file browser: toggle open',
-- --   lhs = '<M-o>',
-- --   rhs = ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
-- -- })
-- -- my.keybind({
-- --   mode = 't',
-- --   desc ='ranger: toggle open (extra binding that works in terminal mode)',
-- --   lhs = '<M-o>',
-- --   rhs = '<C-\\><C-n>:Telescope file_browser path=%:p:h select_buffer=true<CR>',
-- -- })
--
-- -- easy align
-- -- my.keybind({
-- --   desc ="Easy Align: Start interactive EasyAlign for (e.g. gaip, vipga)",
-- --   mode = "nvsox",
-- --   lhs = "ga",
-- --   rhs = "<Plug>(EasyAlign)",
-- -- })
--
-- -- fuzzy find things
-- my.keybind({
--   desc = 'Search: pick from existing buffers',
--   lhs = '<leader>b',
--   -- rhs = ":Buffers<CR>"
--   rhs = ':Telescope buffers<CR>',
-- })
-- my.keybind({
--   desc = 'Search: pick from project files',
--   lhs = '<leader>d',
--   rhs = ':Telescope find_files<CR>',
-- })
-- my.keybind({
--   desc = 'Search: find text in project files',
--   lhs = '<leader>f',
--   rhs = ':Telescope live_grep<CR>',
-- })
-- my.keybind({
--   desc = 'Search: pick a line in the current buffer',
--   lhs = '<leader>sb',
--   rhs = ':Telescope current_buffer_fuzzy_find<CR>',
-- })
-- my.keybind({
--   desc = 'Search: pick a line in all opened buffers',
--   lhs = '<leader>sl',
--   rhs = ':Lines<CR>',
-- })
-- my.keybind({
--   mode = 'v',
--   desc = 'Search: find current selection under cursor in project',
--   lhs = '<leader>sf',
--   rhs = 'y<ESC>:lua require("telescope.builtin").live_grep({ default_text="<c-r>0" })<CR>',
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'Search: find current word under cursor in project',
--   lhs = '<leader>sf',
--   rhs = 'y<ESC>:lua require("telescope.builtin").live_grep({ default_text=vim.fn.expand("<cword>") })<CR>',
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'Search: replace in files using grug-far',
--   lhs = '<leader>so',
--   rhs = ':GrugFar<CR>',
-- })
--
-- my.keybind({
--   desc = 'Search: find in help tags visual',
--   lhs = '<leader>sh',
--   rhs = 'y<ESC>:lua require("telescope.builtin").help_tags({ default_text=vim.fn.expand("<cword>") })<CR>',
--   mode = 'n',
-- })
-- my.keybind({
--   desc = 'Search: resume telescope search',
--   lhs = '<leader>su',
--   rhs = ':Telescope resume<CR>',
-- })
--
-- -- notes
-- my.keybind({
--   desc = 'notes: open notes dir',
--   lhs = '<leader>ne',
--   rhs = ':cd ~/notes/ | Alpha<CR>',
-- })
-- my.keybind({
--   desc = 'notes: pick a note file',
--   lhs = '<leader>nd',
--   rhs = ':MyFiles ~/notes/<CR>',
-- })
-- my.keybind({
--   desc = 'notes: find in note files',
--   lhs = '<leader>nf',
--   rhs = ':SearchNotes<CR>',
-- })
-- my.keybind({
--   desc = 'notes: open notes dir with ranger',
--   lhs = '<leader>nr',
--   rhs = ':e ~/notes/ | RnvimrToggle<CR>',
-- })
-- my.keybind({
--   desc = 'notes: todo: open buffer todos in loclist',
--   lhs = '<leader>ng',
--   rhs = ':lvimgrep /\\[[ ]\\]/ % | lopen<CR>',
-- })
-- my.keybind({
--   desc = 'notes: add/edit note',
--   lhs = '<leader>na',
--   rhs = ':EditNote ',
--   options = { silent = false },
-- })
-- my.keybind({
--   desc = 'notes: add/edit note for current git branch',
--   lhs = '<leader>nb',
--   rhs = ':EditNoteForBranch<CR>',
-- })
-- my.keybind({
--   desc = 'notes: todo comments: add on line above',
--   lhs = '<leader>nt',
--   rhs = function()
--     require('my/todos').addTodoCommentToLineAbove()
--   end,
-- })
-- my.keybind({
--   desc = 'notes: todo comments: search in project',
--   lhs = '<leader>ns',
--   rhs = ':TodoTelescope<CR>',
--   -- rhs = ":SearchForTodoComments<CR>",
-- })
--
-- -- LSP
-- my.keybind({
--   desc = 'lsp: symbol: trigger hover help popup',
--   lhs = 'K',
--   rhs = function()
--     vim.lsp.buf.hover()
--   end,
-- })
-- my.keybind({
--   mode = 'ni',
--   desc = 'lsp: symbol: trigger signature help popup',
--   lhs = '<C-k>',
--   rhs = vim.lsp.buf.signature_help,
-- })
-- my.keybind({
--   desc = 'lsp: symbol: go to declaration',
--   lhs = 'gD',
--   rhs = function()
--     vim.lsp.buf.declaration()
--   end,
-- })
-- -- TODO (sbadragan): move this to another file
-- my.keybind({
--   desc = 'lsp: symbol: go to definition',
--   lhs = 'gd',
--   rhs = function()
--     local openLocation = function(loc)
--       local targetBuf = vim.fn.bufnr(loc.filename)
--       local targetWin = 0
--       if targetBuf == -1 then
--         vim.fn.win_execute(targetWin, 'e! ' .. vim.fn.fnameescape(loc.filename), true)
--         targetBuf = vim.api.nvim_win_get_buf(targetWin)
--       else
--         vim.api.nvim_win_set_buf(targetWin, targetBuf)
--       end
--       pcall(vim.api.nvim_win_set_cursor, targetWin, { loc.lnum or 1, loc.col and loc.col - 1 or 0 })
--     end
--
--     vim.lsp.buf.definition({
--       on_list = function(options)
--         local items = {}
--         for _, item in ipairs(options.items) do
--           if not vim.iter(items):find(function(it)
--             return item.lnum == it.lnum
--           end) then
--             table.insert(items, item)
--           end
--         end
--
--         if #items == 0 then
--           print('no definitions found!')
--           return
--         end
--
--         if #items == 1 then
--           openLocation(items[1])
--           return
--         end
--
--         local cwd = vim.fn.getcwd()
--         vim.ui.select(items, {
--           prompt = 'Select where to go:',
--           format_item = function(item)
--             local filename = item.filename
--             if vim.startswith(filename, cwd) then
--               filename = '.' .. filename:sub(#cwd + 1)
--             end
--             return vim.trim(item.text) .. '\n    ' .. filename .. ':' .. item.lnum .. ':' .. item.col
--           end,
--         }, function(choice)
--           openLocation(choice)
--         end)
--       end,
--     })
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: symbol: go to definition in new tab',
--   lhs = 'gt',
--   rhs = '<C-W>v<C-W>T:lua vim.lsp.buf.definition()<CR>',
-- })
-- my.keybind({
--   desc = 'lsp: symbol: go to definition in vertical split',
--   lhs = 'gs',
--   rhs = '<C-W>v:lua vim.lsp.buf.definition()<CR>',
-- })
-- my.keybind({
--   desc = 'lsp: symbol: go to type definition',
--   lhs = 'gy',
--   rhs = function()
--     vim.lsp.buf.type_definition()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: symbol: go to implementation',
--   lhs = 'gm',
--   rhs = function()
--     vim.lsp.buf.implementation()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: symbol: go to references',
--   lhs = 'gr',
--   rhs = function()
--     vim.lsp.buf.references()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: symbol: rename',
--   lhs = '<leader>lr',
--   rhs = function()
--     vim.lsp.buf.rename()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: code action: pick',
--   lhs = '<leader>la',
--   rhs = function()
--     vim.lsp.buf.code_action()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: diagnostics: show from current line',
--   lhs = '<leader>ld',
--   rhs = function()
--     vim.diagnostic.open_float()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: diagnostics: go to previous',
--   lhs = prevLeaderKey('d'),
--   rhs = function()
--     vim.diagnostic.goto_prev()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: diagnostics: go to next',
--   lhs = nextLeaderKey('d'),
--   rhs = function()
--     vim.diagnostic.goto_next()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: diagnostics: put all buffer diagnostics into the loclist',
--   lhs = '<leader>ll',
--   rhs = function()
--     vim.diagnostic.setloclist()
--   end,
-- })
-- my.keybind({
--   desc = 'lsp: format current buffer',
--   lhs = '<leader>lf',
--   rhs = '<cmd>lua vim.lsp.buf.format()<CR>',
-- })
-- my.keybind({
--   desc = 'format json',
--   lhs = '<leader>uj',
--   rhs = ':%!jq .<CR>',
-- })
-- my.keybind({
--   desc = 'lsp: toggle outline',
--   lhs = '<leader>lo',
--   rhs = '<cmd>AerialToggle left<CR>',
-- })
--
-- my.keybind({
--   mode = 'nxo',
--   desc = 'flash to location',
--   lhs = 'f',
--   rhs = "<cmd>lua require('flash').jump()<cr>",
-- })
-- my.keybind({
--   mode = 'nxo',
--   desc = 'flash: select using treesitter',
--   lhs = is_linux and '<c-h>' or '<a-bs>', -- c-h is c-bs weirdly enough
--   rhs = "<cmd>lua require('flash').treesitter()<cr>",
--   options = { silent = false, noremap = true },
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'leap line select',
--   lhs = 'R',
--   rhs = "<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('Vf<space><space>', true, false, true), 't', true)<CR>",
-- })
-- -- my.keybind({
-- --   mode = 'n',
-- --   desc ='leap line select',
-- --   lhs = 'Y',
-- --   rhs = "<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('yf<space><space>', true, false, true), 't', true)<CR>",
-- -- })
--
-- -- replace
-- my.keybind({
--   mode = 'n',
--   desc = 'replace current word in file',
--   lhs = '<leader>sr',
--   rhs = ':%s/<C-r><C-w>//g<Left><Left>',
--   options = { silent = false },
-- })
-- -- scrolling
-- my.keybind({
--   mode = 'n',
--   desc = 'scroll down',
--   lhs = '<PageDown>',
--   rhs = '30j',
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'scroll up',
--   lhs = '<PageUp>',
--   rhs = '30k',
-- })
--
-- -- dap debugging
-- my.keybind({
--   desc = 'debugger: when debugging, continue. Otherwise start debugging',
--   lhs = '<leader>ec',
--   rhs = ':MyDapReloadContinue<CR>',
-- })
-- my.keybind({
--   desc = 'debugger: pause',
--   lhs = '<leader>ep',
--   rhs = function()
--     require('dap').pause()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: step over',
--   lhs = '<leader>er',
--   rhs = function()
--     require('dap').step_over()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: step into',
--   lhs = '<leader>ei',
--   rhs = function()
--     require('dap').step_into()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: step out',
--   lhs = '<leader>eo',
--   rhs = function()
--     require('dap').step_out()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: step back',
--   lhs = '<leader>ea',
--   rhs = function()
--     require('dap').step_back()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: run to cursor (temporarily removes all other breakpoints and adds them back after)',
--   lhs = '<leader>ej',
--   rhs = function()
--     require('dap').run_to_cursor()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: toggle breakpoint',
--   lhs = '<leader>eb',
--   rhs = function()
--     require('dap').toggle_breakpoint()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: set conditional breakpoint',
--   lhs = '<leader>ek',
--   rhs = function()
--     require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: set log point',
--   lhs = '<leader>el',
--   rhs = function()
--     require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: open/focus REPL',
--   lhs = '<leader>ef',
--   rhs = function()
--     require('dap').repl_open()
--   end,
-- })
-- my.keybind({
--   desc = 'debugger: re-run the last debug adapter / configuration that ran',
--   lhs = '<leader>ed',
--   rhs = function()
--     require('dap').run_last()
--   end,
-- })
-- my.keybind({
--   mode = 'nv',
--   desc = 'debugger: evaluate expression under cursor (works with selection in visual mode)',
--   lhs = '<leader>ee',
--   rhs = function()
--     require('dap.ui.widgets').hover()
--   end,
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'debugger: terminate',
--   lhs = '<leader>eq',
--   rhs = function()
--     require('dap').terminate()
--   end,
-- })
--
-- my.keybind({
--   mode = 'n',
--   desc = 'markdown: preview open',
--   lhs = '<leader>po',
--   rhs = ':PeekOpen<CR>',
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'markdown: preview open',
--   lhs = '<leader>pc',
--   rhs = ':PeekClose<CR>',
-- })
--
-- -- switch to alternate file
-- my.keybind({
--   mode = 'n',
--   desc = 'vsplit edit associated file: jsx file',
--   lhs = '<leader>vf',
--   rhs = function()
--     vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.jsx')
--   end,
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'vsplit edit associated file: spec file',
--   lhs = '<leader>vt',
--   rhs = function()
--     vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.spec.js')
--   end,
-- })
-- my.keybind({
--   mode = 'n',
--   desc = 'vsplit edit associated file: module scss file',
--   lhs = '<leader>vc',
--   rhs = function()
--     vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.module.scss')
--   end,
-- })
--
-- -- snippets
-- my.keybind({
--   mode = 'i',
--   desc = 'Snippets: search and insert snippet with telescope',
--   lhs = '<c-p>',
--   rhs = '<esc>:Telescope luasnip<CR>',
-- })
--
-- -- messages window
-- my.keybind({
--   mode = 'n',
--   desc = 'Messages : show messages window',
--   lhs = '<leader>m',
--   -- rhs = '<esc>:messages<CR>',
--   rhs = '<esc>:Bmessages<CR>',
-- })
--
-- -- tests
-- my.keybind({
--   desc = 'mini.test: run file',
--   lhs = '<leader>xf',
--   rhs = function()
--     require('mini.test').run_file()
--   end,
-- })
-- my.keybind({
--   desc = 'mini.test: run tests',
--   lhs = '<leader>xt',
--   rhs = function()
--     require('mini.test').run()
--   end,
-- })
--
-- -- overseer
-- my.keybind({
--   desc = 'overseer: run task',
--   lhs = '<leader>wr',
--   rhs = '<cmd>OverseerRun<CR>',
-- })
-- my.keybind({
--   desc = 'overseer: toggle',
--   lhs = '<leader>wt',
--   rhs = '<cmd>OverseerToggle<CR>',
-- })
