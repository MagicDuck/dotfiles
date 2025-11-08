local func = require('vim.func')
---@module 'snacks'

local is_linux = vim.fn.has('linux') == 1

local nextLeaderKey = function(key)
  return '<leader>j' .. key
end
local prevLeaderKey = function(key)
  return '<leader>k' .. key
end

-- base keymaps
--------------------------------------------------------------------------------------------------

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
  " NOTE: <C-x><keystroke> in insert mode is useful for checking how nvim sees keystrokes
  inoremap <c-x> <c-v>

  " save
  nnoremap <C-s> :<C-U>w<CR>
  vnoremap <C-s> <C-C>:w<CR>
  inoremap <C-s> <ESC>:w<CR>

  " slightly easier :command
  noremap ; :

  " esc in terminal mode
  tnoremap <s-esc> <esc>
  tnoremap <esc> <C-\><C-n>

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

  nnoremap <leader>sr :%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>
]])

if is_linux then
  vim.cmd([[
    " ctrl-based motions
    " see https://github.com/neovim/neovim/discussions/34578
    " inoremap <c-h> <c-w>
    inoremap <c-bs> <c-w>
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

-- snippets / clap (bracket matching)
vim.keymap.set({ 'i', 's' }, '<end>', function()
  if require('luasnip').expand_or_jumpable() then
    require('luasnip').expand_or_jump()
  else
    require('clasp').wrap('next')
  end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<home>', function()
  if require('luasnip').jumpable(-1) then
    require('luasnip').jump(-1)
  else
    require('clasp').wrap('prev')
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(1)
  end
end, { silent = true })

-- show Mappings picker
--------------------------------------------------------------------------------------------------

-- my.keybind('<leader>,', function()
--   require('my/plugins/telescope/command_picker').pickKeybindOrCommand({ mode = 'n' })
-- end, { desc = 'show a list of key bindings to pick from' })

my.keybind('<leader>,', function()
  require('my.config.command_picker').open({ mode = 'n' })
end, { desc = 'show a list of key bindings and commands to pick from' })

-- buffer
--------------------------------------------------------------------------------------------------

my.keybind('<leader>o', ':b#<CR>', {
  desc = 'buffer: go to previously viewed/edited buffer',
})

my.keybind('<leader>x', ':Bwipeout<CR>', {
  desc = 'buffer: close current buffer while preserving window',
})

my.keybind(
  '<leader>yf',
  ':let @+ = expand("%") | echo "yanked: " . @+<CR>',
  { desc = 'buffer: yank project relative path of file in current buffer' }
)

my.keybind(
  '<leader>yp',
  ':let @+ = expand("%:p") | echo "yanked: " . @+<CR>',
  { desc = 'buffer: yank full path of file in current buffer' }
)

my.keybind(
  '<leader>yt',
  ':let @* = "env DEBUG_PRINT_LIMIT=100000 pnpm run test --maxWorkers=2 --watch " . expand("%:h:t") . "/" . expand("%:t:r") | echo "yanked: " . @*<CR>',
  { desc = 'buffer: yank a jest unit test command for current file' }
)

my.keybind(
  '<leader>yd',
  ':let @* = "env DEBUG_PRINT_LIMIT=100000 node --inspect ./node_modules/jest/bin/jest.js --watch --maxWorkers=2 " . expand("%:h:t") . "/" . expand("%:t:r") | echo "yanked: " . @*<CR>',
  { desc = 'buffer: yank a jest unit test command for current file' }
)

my.keybind('<leader>ur', function()
  local old_name = vim.api.nvim_buf_get_name(0)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':file ' .. old_name, true, false, true), 't', true)
end, { desc = 'buffer: rename' })

-- line
--------------------------------------------------------------------------------------------------

my.keybind('gP', 'O<esc>[p', { desc = 'line: paste on line above, keeping indentation' })

my.keybind('gp', 'o<esc>]p', { desc = 'line: paste on line below, keeping indentation' })

-- quickfix and loclist
--------------------------------------------------------------------------------------------------

my.keybind(prevLeaderKey('f'), ':Cprev<CR>', { desc = 'quickfix list: next entry' })

my.keybind(nextLeaderKey('f'), ':Cnext<CR>', { desc = 'quickfix list: previous entry' })

my.keybind(
  '<leader>qr',
  ":call setqflist([], 'r', {'title': input('New Quickfix List Name: ')})<CR>",
  { desc = 'quickfix list: rename' }
)

my.keybind('<leader>qd', function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end, { desc = 'quickfix list: toggle' })

-- TODO (sbadragan): use Snacks??
-- my.keybind('<leader>qk', ':Telescope quickfixhistory<CR>', { desc = 'quickfix list: history' })

my.keybind(prevLeaderKey('v'), ':Lprev<CR>', { desc = 'location list: next entry' })

my.keybind(nextLeaderKey('v'), ':Lnext<CR>', { desc = 'location list: previous entry' })

-- conflict resolution
--------------------------------------------------------------------------------------------------

my.keybind(nextLeaderKey('o'), ':diffget 3<CR>', { desc = 'conflict resolution: diff get from left' })

my.keybind(prevLeaderKey('o'), ':diffget 1<CR>', { desc = 'conflict resolution: diff get from right' })

my.keybind(nextLeaderKey('c'), '<Plug>(unimpaired-context-next)', { desc = 'conflict resolution: next conflict' })

my.keybind(prevLeaderKey('c'), '<Plug>(unimpaired-context-previous)', { desc = 'conflict resolution: prev conflict' })

-- tabs
--------------------------------------------------------------------------------------------------

my.keybind('<C-d>', '<cmd>tabprevious<CR>', { desc = 'tab: navigate to previous tab' })

my.keybind('<C-f>', '<cmd>tabnext<CR>', { desc = 'tab: navigate to next tab' })

my.keybind('<leader>tn', '<cmd>tabnew | Alpha<CR>', { desc = 'tab: create new tab' })

my.keybind('<leader>td', '<cmd>tabnew %<CR>', { desc = 'tab: duplicate current tab' })

my.keybind('<leader>tc', '<cmd>tabclose<CR>', { desc = 'tab: close current tab' })

-- my.keybind('<leader>st', function()
--   require('my/plugins/telescope/tab_picker').pickTab()
-- end, { desc = 'tab: pick tab using telescope' })

my.keybind('<leader>tt', '<cmd>EditBookmarkAsTab<CR>', { desc = 'tab: edit bookmark in new tab' })

my.keybind('<leader>to', '<cmd>EditBookmark<CR>', { desc = 'tab: edit bookmark in current tab' })

my.keybind('<leader>tr', ':TabRename<space>', { silent = false, noremap = true, desc = 'tab: rename' })

my.keybind('<leader>th', ':tabmove -1<CR>', { desc = 'tab: move left' })
my.keybind('<leader>tl', ':tabmove +1<CR>', { desc = 'tab: move right' })
my.keybind('<leader>a', ':Tabby jump_to_tab<CR>', { desc = 'tab: jump to tab' })
-- go to last tab: g<tab>

-- windows
--------------------------------------------------------------------------------------------------

my.keybind('s', '<C-W>', { silent = false, noremap = true, desc = 'window: enter window mode' })

my.keybind('<M-j>', ':resize -2<CR>', { desc = 'window: resize down' })

my.keybind('<M-k>', ':resize +2<CR>', { desc = 'window: resize up' })

my.keybind('<M-h>', ':vertical resize -2<CR>', { desc = 'window: resize left' })

my.keybind('<M-l>', ':vertical resize +2<CR>', { desc = 'window: resize right' })

-- easy capitalization
--------------------------------------------------------------------------------------------------

my.keybind('<M-u>', '<ESC>viwUi', { mode = 'i', desc = 'current word: capitalize (visual)' })

my.keybind('<M-u>', 'viwU<ESC>', { desc = 'current word: capitalize' })

-- improved indentation
--------------------------------------------------------------------------------------------------

my.keybind('<', '<gv', { mode = 'v', desc = 'indentation: indent left' })

my.keybind('>', '>gv', { mode = 'v', desc = 'indentation: indent right' })

-- highlighting
--------------------------------------------------------------------------------------------------

my.keybind('<leader>uv', ':let @/ = ""<CR>', { desc = 'highlighting: clear search highlight' })

-- docgen
--------------------------------------------------------------------------------------------------

my.keybind('<leader>hi', function()
  require('neogen').generate()
end, { desc = 'highlighting: clear search highlight' })

-- marks
--------------------------------------------------------------------------------------------------

local letters = 'abcdefghijklmnopqrstuvwxyz'
for i = 1, #letters do
  local letter = letters:sub(i, i)
  local uppercaseLetter = letter:upper()

  my.keybind('m' .. letter, 'm' .. uppercaseLetter, { desc = 'marks: set mark ' .. uppercaseLetter })

  my.keybind("'" .. letter, "'" .. uppercaseLetter, { desc = 'marks: go to mark ' .. uppercaseLetter })
end

-- startify
--------------------------------------------------------------------------------------------------

my.keybind('<leader>i', function()
  if vim.bo.filetype ~= 'alpha' then
    vim.cmd('Alpha')
  end
end, { desc = 'open startify' })

-- git
--------------------------------------------------------------------------------------------------

my.keybind('<leader>gb', ':Git blame<CR>', { desc = 'git: blame' })

my.keybind('<leader>gs', ':Gtabedit :<CR>', { desc = 'git: status in new tab' })

my.keybind('<leader>go', ':GBrowseMain<CR>', { desc = 'git: open current file in web browser (stash)' })

my.keybind('<leader>gm', ':GFiles?<CR>', { desc = 'git: pick from modified git files' })

my.keybind('<leader>gl', ':DiffviewOpen<CR>', { desc = 'git: log status using diffview' })

my.keybind('<leader>gh', ':DiffviewFileHistory %<CR>', { desc = 'git: log file history using diffview' })

my.keybind(
  '<leader>gh',
  ":'<,'>DiffviewFileHistory<CR>",
  { mode = 'v', desc = 'git: log selected region history using diffview' }
)

my.keybind('<C-g>', require('my.term').toggle_lazygit, { mode = 'invt', desc = 'git: open lazygit' })

-- file browser
--------------------------------------------------------------------------------------------------

my.keybind('<leader>r', ':Yazi<CR>', { desc = 'file browser: open at file' })
-- my.keybind({
--   desc ='file browser: toggle open',
--   lhs = '<leader>r',
--   rhs = ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
-- })
--
-- my.keybind({
--   desc ='file browser: toggle open',
--   lhs = '<M-o>',
--   rhs = ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
-- })

-- easy align
--
-- my.keybind({
--   desc ="Easy Align: Start interactive EasyAlign for (e.g. gaip, vipga)",
--   mode = "nvsox",
--   lhs = "ga",
--   rhs = "<Plug>(EasyAlign)",
-- })

-- fuzzy find things
--------------------------------------------------------------------------------------------------

-- my.keybind('<leader>b', ':Telescope buffers<CR>', { desc = 'Search: pick from existing buffers' })
my.keybind('<leader>b', function()
  Snacks.picker.buffers()
end, { desc = 'Search: pick from existing buffers' })

-- my.keybind('<leader>d', ':Telescope find_files<CR>', { desc = 'Search: pick from project files' })
my.keybind('<leader>d', function()
  Snacks.picker.files()
end, { desc = 'Search: pick from project files' })

-- my.keybind('<leader>f', ':Telescope live_grep<CR>', { desc = 'Search: find text in project files' })
my.keybind('<leader>f', function()
  Snacks.picker.grep()
end, { desc = 'Search: find text in project files' })

-- my.keybind(
--   '<leader>sb',
--   ':Telescope current_buffer_fuzzy_find<CR>',
--   { desc = 'Search: pick a line in the current buffer' }
-- )
my.keybind('<leader>sb', function()
  Snacks.picker.lines()
end, { desc = 'Search: pick a line in the current buffer' })

-- my.keybind(
--   '<leader>sf',
--   'y<ESC>:lua require("telescope.builtin").live_grep({ default_text="<c-r>0" })<CR>',
--   { mode = 'v', desc = 'Search: find current selection under cursor in project' }
-- )
--
-- my.keybind(
--   '<leader>sf',
--   'y<ESC>:lua require("telescope.builtin").live_grep({ default_text=vim.fn.expand("<cword>") })<CR>',
--   { mode = 'n', desc = 'Search: find current word under cursor in project' }
-- )
my.keybind('<leader>sf', function()
  Snacks.picker.grep({
    search = function(picker)
      return picker:word()
    end,
  })
end, { mode = 'in', desc = 'Search: find current word under cursor in project' })

my.keybind('<leader>sm', ':Namu symbols<CR>', { mode = 'n', desc = 'Search: search for symbols in current file' })

my.keybind('<leader>so', ':GrugFar<CR>', { mode = 'nv', desc = 'Search: replace in files using grug-far' })

my.keybind('<leader>si', function()
  require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })
end, { mode = 'nx', desc = 'Search: inside current range using grug-far' })

my.keybind('<leader>sp', function()
  require('grug-far').open({
    prefills = {
      paths = vim.fn.expand('%'),
    },
  })
end, { mode = 'nx', desc = 'Search: inside current file using grug-far' })

-- my.keybind(
--   '<leader>sh',
--   'y<ESC>:lua require("telescope.builtin").help_tags({ default_text=vim.fn.expand("<cword>") })<CR>',
--   { desc = 'Search: find in help tags visual' }
-- )

my.keybind('<leader>sh', function()
  Snacks.picker.help({
    pattern = function(picker)
      return picker:word()
    end,
  })
end, { mode = 'nx', desc = 'Search: find in help tags visual' })

my.keybind('<leader>sg', function()
  Snacks.picker.highlights()
end, { desc = 'Search: find highlight group' })

-- my.keybind('<leader>su', ':Telescope resume<CR>', { desc = 'Search: resume telescope search' })
my.keybind('<leader>su', function()
  Snacks.picker.resume()
end, { desc = 'Search: resume search' })

my.keybind(prevLeaderKey('s'), function()
  local inst = require('grug-far').get_instance()
  if inst then
    inst:goto_prev_match({ wrap = true })
    inst:open_location()
  end
end, { desc = 'grug-far: previous match' })

my.keybind(nextLeaderKey('s'), function()
  local inst = require('grug-far').get_instance()
  if inst then
    inst:goto_next_match({ wrap = true })
    inst:open_location()
  end
end, { desc = 'grug-far: next match' })

-- notes
--------------------------------------------------------------------------------------------------
my.keybind('<leader>ne', ':cd ~/notes/ | Alpha<CR>', { desc = 'notes: open notes dir' })

my.keybind('<leader>nd', ':MyFiles ~/notes/<CR>', { desc = 'notes: pick a note file' })

my.keybind('<leader>nf', ':SearchNotes<CR>', { desc = 'notes: find in note files' })

my.keybind('<leader>nr', ':e ~/notes/ | RnvimrToggle<CR>', { desc = 'notes: open notes dir with ranger' })

my.keybind('<leader>ng', ':lvimgrep /\\[[ ]\\]/ % | lopen<CR>', { desc = 'notes: todo: open buffer todos in loclist' })

my.keybind('<leader>na', ':EditNote ', { silent = false, desc = 'notes: add/edit note' })

my.keybind('<leader>nb', ':EditNoteForBranch<CR>', { desc = 'notes: add/edit note for current git branch' })

my.keybind('<leader>nt', function()
  require('my/todos').addTodoCommentToLineAbove()
end, { desc = 'notes: todo comments: add on line above' })

-- my.keybind('<leader>ns', ':TodoTelescope<CR>', { desc = 'notes: todo comments: search in project' })
my.keybind('<leader>ns', function()
  Snacks.picker.todo_comments()
end, { desc = 'notes: todo comments: search in project' })

-- LSP
--------------------------------------------------------------------------------------------------

my.keybind('K', function()
  vim.lsp.buf.hover({ border = 'rounded' })
end, { desc = 'lsp: symbol: trigger hover help popup' })

my.keybind('<C-k>', function()
  vim.lsp.buf.signature_help({ border = 'rounded' })
end, { mode = 'ni', desc = 'lsp: symbol: trigger signature help popup' })

my.keybind('gD', function()
  vim.lsp.buf.declaration()
end, { desc = 'lsp: symbol: go to declaration' })

my.keybind('gd', function()
  require('my.plugins.lsp.goto_definition').goto_definition()
end, { desc = 'lsp: symbol: go to definition' })

my.keybind('gt', '<C-W>v<C-W>T:lua vim.lsp.buf.definition()<CR>', { desc = 'lsp: symbol: go to definition in new tab' })

my.keybind(
  'gs',
  '<C-W>v:lua vim.lsp.buf.definition()<CR>',
  { desc = 'lsp: symbol: go to definition in vertical split' }
)

my.keybind('gy', function()
  vim.lsp.buf.type_definition()
end, { desc = 'lsp: symbol: go to type definition' })

my.keybind('gm', function()
  vim.lsp.buf.implementation()
end, { desc = 'lsp: symbol: go to implementation' })

my.keybind('gr', function()
  vim.lsp.buf.references(nil, { loclist = true })
end, { desc = 'lsp: symbol: go to references' })

my.keybind('<leader>lr', function()
  vim.lsp.buf.rename()
end, { desc = 'lsp: symbol: rename' })

my.keybind('<leader>la', function()
  vim.lsp.buf.code_action()
end, { desc = 'lsp: code action: pick' })

my.keybind('<leader>ld', function()
  vim.diagnostic.open_float()
end, { desc = 'lsp: diagnostics: show from current line' })

my.keybind(prevLeaderKey('d'), function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'lsp: diagnostics: go to previous' })

my.keybind(nextLeaderKey('d'), function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'lsp: diagnostics: go to next' })

my.keybind('<leader>ll', function()
  vim.diagnostic.setloclist()
end, { desc = 'lsp: diagnostics: put all buffer diagnostics into the loclist' })

my.keybind('<leader>lf', function()
  vim.lsp.buf.format()
end, { desc = 'lsp: format current buffer' })

my.keybind('<leader>uj', ':%!jq .<CR>', { desc = 'format json' })

my.keybind('<leader>lo', '<cmd>AerialToggle left<CR>', { desc = 'lsp: toggle outline' })

my.keybind('M', function()
  require('flash').jump({
    search = { multi_window = false },
  })
end, { mode = 'nxo', desc = 'flash to location' })

my.keybind(is_linux and '<c-h>' or '<a-bs>', function()
  require('flash').treesitter()
end, {
  mode = 'nxo',
  silent = false,
  noremap = true,
  desc = 'flash: select using treesitter',
})

my.keybind('R', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('VM', true, false, true), 't', true)
end, { mode = 'n', desc = 'flash line select' })

-- scrolling
--------------------------------------------------------------------------------------------------

my.keybind('<PageDown>', '30j', { mode = 'n', desc = 'scroll down' })

my.keybind('<PageUp>', '30k', { mode = 'n', desc = 'scroll up' })

-- dap debugging
--------------------------------------------------------------------------------------------------

my.keybind(
  '<leader>ec',
  ':MyDapReloadContinue<CR>',
  { desc = 'debugger: when debugging, continue. Otherwise start debugging' }
)

my.keybind('<leader>ep', function()
  require('dap').pause()
end, { desc = 'debugger: pause' })

my.keybind('<leader>er', function()
  require('dap').step_over()
end, { desc = 'debugger: step over' })

my.keybind('<leader>ei', function()
  require('dap').step_into()
end, { desc = 'debugger: step into' })

my.keybind('<leader>eo', function()
  require('dap').step_out()
end, { desc = 'debugger: step out' })

my.keybind('<leader>ea', function()
  require('dap').step_back()
end, { desc = 'debugger: step back' })

my.keybind('<leader>ej', function()
  require('dap').run_to_cursor()
end, { desc = 'debugger: run to cursor (temporarily removes all other breakpoints and adds them back after)' })

my.keybind('<leader>eb', function()
  require('dap').toggle_breakpoint()
end, { desc = 'debugger: toggle breakpoint' })

my.keybind('<leader>ek', function()
  require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'debugger: set conditional breakpoint' })

my.keybind('<leader>el', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = 'debugger: set log point' })

my.keybind('<leader>ef', function()
  require('dap').repl_open()
end, { desc = 'debugger: open/focus REPL' })

my.keybind('<leader>ed', function()
  require('dap').run_last()
end, { desc = 'debugger: re-run the last debug adapter / configuration that ran' })

my.keybind('<leader>ee', function()
  require('dap.ui.widgets').hover()
end, { mode = 'nv', desc = 'debugger: evaluate expression under cursor (works with selection in visual mode)' })

my.keybind('<leader>eq', function()
  require('dap').terminate()
end, { desc = 'debugger: terminate' })

my.keybind('<leader>po', ':PeekOpen<CR>', { desc = 'markdown: preview open' })

my.keybind('<leader>pc', ':PeekClose<CR>', { desc = 'markdown: preview open' })

-- switch to alternate file
--------------------------------------------------------------------------------------------------
my.keybind('<leader>vf', function()
  vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.jsx')
end, { desc = 'vsplit edit associated file: jsx file' })

my.keybind('<leader>vt', function()
  vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.spec.js')
end, { desc = 'vsplit edit associated file: spec file' })

my.keybind('<leader>vc', function()
  vim.cmd('vsplit ' .. vim.fn.expand('%:p:r:r') .. '.module.scss')
end, { desc = 'vsplit edit associated file: module scss file' })

-- snippets
--------------------------------------------------------------------------------------------------

-- my.keybind(
--   '<c-b>',
--   '<esc>:Telescope luasnip<CR>',
--   { mode = 'i', desc = 'Snippets: search and insert snippet with telescope' }
-- )

my.keybind('<c-b>', function()
  require('snacks-luasnip').pick()
end, { mode = 'i', desc = 'Snippets: search and insert snippet' })

-- messages window
--------------------------------------------------------------------------------------------------

my.keybind('<leader>m', ':Bmessages<CR>', { desc = 'Messages : show messages window' })

-- tests
--------------------------------------------------------------------------------------------------

my.keybind('<leader>xf', function()
  require('mini.test').run_file()
end, { desc = 'mini.test: run file' })

my.keybind('<leader>xt', function()
  require('mini.test').run()
end, { desc = 'mini.test: run tests' })

-- overseer
--------------------------------------------------------------------------------------------------

my.keybind('<leader>wr', '<cmd>OverseerRun<CR>', { desc = 'overseer: run task' })

my.keybind('<leader>wt', '<cmd>OverseerToggle<CR>', { desc = 'overseer: toggle' })
