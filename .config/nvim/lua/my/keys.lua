-- show Mappings picker
my.keybind {
  description = "show a list of key bindings to pick from",
  lhs = "<leader>k",
  rhs = ":lua require('my/telescope/command_picker').pickKeybindOrCommand({mode = 'n'})<CR>"
}

-- config reload
my.keybind {
  description = "reload: vim config",
  lhs = "<leader>R",
  rhs = ":lua my.reloadVim()<CR>"
}

-- copy/paste/save
my.keybind {
  description = "copy",
  mode = "v",
  lhs = "<C-c>",
  rhs = '"*y'
}
my.keybind {
  description = "paste",
  mode = "i",
  lhs = "<C-v>",
  rhs = '<C-O>"*p'
}
my.keybind {
  description = "save",
  lhs = "<C-s>",
  rhs = ":<C-U>Update<CR>"
}
my.keybind {
  description = "save (visual)",
  mode = "v",
  lhs = "<C-s>",
  rhs = "<C-C>:Update<CR>"
}
my.keybind {
  description = "save (insert)",
  mode = "i",
  lhs = "<C-s>",
  rhs = "<C-O>:Update<CR>"
}

-- buffer wipeout while preserving window
my.keybind {
  description = "close current buffer while preserving window",
  lhs = "<leader>q",
  rhs = ":Bwipeout<CR>"
}

-- quickfix list
my.keybind {
  description = "quickfix list: next entry",
  lhs = "<down>c",
  rhs = ":Cnext<CR>"
}
my.keybind {
  description = "quickfix list: previous entry",
  lhs = "<up>c",
  rhs = ":Cprev<CR>"
}

-- conflict resolution
my.keybind {
  description = "conflict resolution: diff get from left",
  lhs = "<left>o",
  rhs = ":diffget 3<CR>"
}
my.keybind {
  description = "conflict resolution: diff get from right",
  lhs = "<right>o",
  rhs = ":diffget 1<CR>"
}
my.keybind {
  description = "conflict resolution: next conflict",
  lhs = "<down>d",
  rhs = "]c"
}
my.keybind {
  description = "conflict resolution: prev conflict",
  lhs = "<up>d",
  rhs = "[c"
}

-- tabs
my.keybind {
  description = "tab: navigate to next tab",
  lhs = "<right>m",
  rhs = ":tabnext<CR>"
}
my.keybind {
  description = "tab: navigate to previous tab",
  lhs = "<left>m",
  rhs = ":tabprevious<CR>"
}
my.keybind {
  description = "tab: create new tab",
  lhs = "<leader>mt",
  rhs = ":tabnew<CR>"
}
my.keybind {
  description = "tab: close current tab",
  lhs = "<leader>mc",
  rhs = ":tabclose<CR>"
}

-- windows
my.keybind {
  description = "window: enter window mode",
  mode = "n",
  lhs = "<BS>",
  rhs = "<C-W>"
}
my.keybind {
  description = "window: navigate down",
  lhs = "<C-j>",
  rhs = "<C-W><C-J>"
}
my.keybind {
  description = "window: navigate up",
  lhs = "<C-k>",
  rhs = "<C-W><C-K>"
}
my.keybind {
  description = "window: navigate left",
  lhs = "<C-h>",
  rhs = "<C-W><C-H>"
}
my.keybind {
  description = "window: navigate right",
  lhs = "<C-l>",
  rhs = "<C-W><C-l>"
}
my.keybind {
  description = "window: resize down",
  lhs = "<M-j>",
  rhs = ":resize -2<CR>"
}
my.keybind {
  description = "window: resize up",
  lhs = "<M-k>",
  rhs = ":resize +2<CR>"
}
my.keybind {
  description = "window: resize left",
  lhs = "<M-h>",
  rhs = ":vertical resize -2<CR>"
}
my.keybind {
  description = "window: resize right",
  lhs = "<M-l>",
  rhs = ":vertical resize +2<CR>"
}

for i = 1, 5, 1 do
  my.keybind {
    description = "window: jump to window " .. i,
    lhs = "<leader>" .. i,
    rhs = ":" .. i .. "wincmd w<CR>"
  }
end

-- better nav for omnicomplete
-- inoremap <expr> <c-j> ("\<C-n>")
-- inoremap <expr> <c-k> ("\<C-p>")
my.keybind {
  description = "omnicomplete: nav down",
  mode = "i",
  lhs = "<C-j>",
  -- rhs = my.termcode("<C-n>"),
  rhs = "<C-n>",
  options = {expr = true}
}
my.keybind {
  description = "omnicomplete: nav up",
  mode = "i",
  lhs = "<C-k>",
  -- rhs = my.termcode("<C-p>"),
  rhs = "<C-p>",
  options = {expr = true}
}

-- easy capitalization
my.keybind {
  description = "current word: capitalize (visual)",
  mode = "i",
  lhs = "<C-u>",
  rhs = "<ESC>viwUi"
}
my.keybind {
  description = "current word: capitalize",
  lhs = "<C-u>",
  rhs = "viwU<ESC>"
}

-- improved indentation
my.keybind {
  description = "indentation: indent left",
  mode = "v",
  lhs = "<",
  rhs = "<gv"
}
my.keybind {
  description = "indentation: indent right",
  mode = "v",
  lhs = ">",
  rhs = ">gv"
}

-- highlighting
my.keybind {
  description = "highlighting: clear search highlight",
  lhs = "<leader>v",
  rhs = ':let @/ = ""<CR>'
}

-- marks
local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #letters do
  local letter = letters:sub(i, i)
  local uppercaseLetter = letter:upper()
  my.keybind {
    description = "marks: set mark " .. uppercaseLetter,
    lhs = "m" .. letter,
    rhs = "m" .. uppercaseLetter
  }
  my.keybind {
    description = "marks: go to mark " .. uppercaseLetter,
    lhs = "'" .. letter,
    rhs = "'" .. uppercaseLetter
  }
end

-- startify
my.keybind {
  description = "open startify",
  lhs = "<leader>i",
  rhs = ":Startify<CR>"
}

-- commenting
my.keybind {
  description = "comment: toggle comment",
  mode = "nvsox",
  lhs = "<leader>c",
  rhs = "<Plug>NERDCommenterToggle"
}

-- git
my.keybind {
  description = "git: blame",
  lhs = "<leader>gb",
  rhs = ":Git blame<CR>"
}
my.keybind {
  description = "git: status",
  lhs = "<leader>gs",
  rhs = ":Git status<CR>"
}
my.keybind {
  description = "git: open current file in web browser (stash)",
  lhs = "<leader>go",
  rhs = ":GBrowse<CR>"
}
my.keybind {
  description = "git: pick from modified git files",
  lhs = "<leader>gm",
  rhs = ":GFiles?<CR>"
}

-- ranger
my.keybind {
  description = "ranger: toggle open",
  lhs = "<leader>r",
  rhs = ":RnvimrToggle<CR>"
}
my.keybind {
  description = "ranger: toggle open (extra binding that works in terminal mode)",
  lhs = "<M-o>",
  rhs = ":RnvimrToggle<CR>"
}
my.keybind {
  mode = "t",
  description = "ranger: toggle open (extra binding that works in terminal mode)",
  lhs = "<M-o>",
  rhs = "<C-\\><C-n>:RnvimrToggle<CR>"
}

-- easy align
my.keybind {
  description = "Easy Align: Start interactive EasyAlign for (e.g. gaip, vipga)",
  mode = "nvsox",
  lhs = "ga",
  rhs = "<Plug>(EasyAlign)"
}

-- fuzzy find things
my.keybind {
  description = "Search: pick from existing buffers",
  lhs = "<leader>b",
  rhs = ":Buffers<CR>"
}
my.keybind {
  description = "Search: pick from project files",
  lhs = "<leader>d",
  rhs = ":MyFiles<CR>"
}
my.keybind {
  description = "Search: pick from project files (alternate keybind)",
  lhs = "<C-p>",
  rhs = ":MyFiles<CR>"
}
my.keybind {
  description = "Search: find text in project files",
  lhs = "<leader>f",
  rhs = ":Search<CR>"
}
my.keybind {
  description = "Search: pick a mark location",
  lhs = "<leader>j",
  rhs = ":MarksWithPreview<CR>"
}
my.keybind {
  description = "Search: pick a line in the current buffer",
  lhs = "<leader>sb",
  rhs = ":BLines<CR>"
}
my.keybind {
  description = "Search: pick a line in all opened buffers",
  lhs = "<leader>sl",
  rhs = ":Lines<CR>"
}
my.keybind {
  description = "Search: pick an exsting window to go to",
  lhs = "<leader>sw",
  rhs = ":Windows<CR>"
}
my.keybind {
  description = "Search: find current word under cursor in project",
  lhs = "<leader>sf",
  rhs = ":SearchCurrentWord<CR>"
}

-- notes
my.keybind {
  description = "notes: open notes dir",
  lhs = "<leader>ne",
  rhs = ":cd ~/notes/ | Startify<CR>"
}
my.keybind {
  description = "notes: pick a note file",
  lhs = "<leader>nd",
  rhs = ":MyFiles ~/notes/<CR>"
}
my.keybind {
  description = "notes: find in note files",
  lhs = "<leader>nf",
  rhs = ":SearchNotes<CR>"
}
my.keybind {
  description = "notes: open notes dir with ranger",
  lhs = "<leader>nr",
  rhs = ":e ~/notes/ | RnvimrToggle<CR>"
}
my.keybind {
  description = "notes: todo: open buffer todos in loclist",
  lhs = "<leader>ng",
  rhs = ":lvimgrep /\\[[ ]\\]/ % | lopen<CR>"
}
my.keybind {
  description = "notes: add/edit note",
  lhs = "<leader>na",
  rhs = ":EditNote ",
  options = {silent = false}
}
my.keybind {
  description = "notes: add/edit note for current git branch",
  lhs = "<leader>nb",
  rhs = ":EditNoteForBranch<CR>"
}
my.keybind {
  description = "notes: todo comments: add on line above",
  lhs = "<leader>nt",
  rhs = ":lua require('my/todos').addTodoCommentToLineAbove()<CR>"
}
my.keybind {
  description = "notes: todo comments: search in project",
  lhs = "<leader>ns",
  rhs = ":SearchForTodoComments<CR>"
}

-- LSP
my.keybind {
  description = "lsp: symbol: trigger hover help popup",
  lhs = "K",
  rhs = ":lua vim.lsp.buf.hover()<CR>"
}
my.keybind {
  description = "lsp: symbol: trigger signature help popup",
  lhs = ",s",
  rhs = ":lua vim.lsp.buf.signature_help()<CR>"
}
my.keybind {
  description = "lsp: symbol: go to declaration",
  lhs = "gD",
  rhs = ":lua vim.lsp.buf.declaration()<CR>"
}
my.keybind {
  description = "lsp: symbol: go to definition",
  lhs = "gd",
  rhs = ":lua vim.lsp.buf.definition()<CR>"
}
my.keybind {
  description = "lsp: symbol: go to type definition",
  lhs = "gy",
  rhs = ":lua vim.lsp.buf.type_definition()<CR>"
}
my.keybind {
  description = "lsp: symbol: go to implementation",
  lhs = "gm",
  rhs = ":lua vim.lsp.buf.implementation()<CR>"
}
my.keybind {
  description = "lsp: symbol: go to references",
  lhs = "gr",
  rhs = ":lua vim.lsp.buf.references() <CR>"
}
my.keybind {
  description = "lsp: symbol: rename",
  lhs = ",r",
  rhs = ":lua require('lspsaga.rename').rename()<CR>"
}
my.keybind {
  description = "lsp: code action: pick",
  lhs = ",a",
  rhs = ":lua require('lspsaga.rename').rename()<CR>"
}
my.keybind {
  description = "lsp: diagnostics: show from current line",
  lhs = ",l",
  rhs = ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
}
my.keybind {
  description = "lsp: diagnostics: go to previous",
  lhs = "<up>f",
  rhs = ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>"
}
my.keybind {
  description = "lsp: diagnostics: go to next",
  lhs = "<down>f",
  rhs = ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>"
}
my.keybind {
  description = "lsp: diagnostics: put all buffer diagnostics into the loclist",
  lhs = ",f",
  rhs = ":lua vim.lsp.diagnostic.set_loclist()<CR>"
}
my.keybind {
  description = "lsp: format current buffer",
  lhs = ",F",
  rhs = "<cmd>lua vim.lsp.buf.formatting()<CR>"
}
