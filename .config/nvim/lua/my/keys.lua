-- show Mappings picker
my.keybind {
  description = "show a list of key bindings to pick from",
  lhs = "<leader>k",
  rhs = ":lua require('my/telescope').pickKeybind('n')<CR>"
}

-- config reload
my.keybind {
  description = "reload: vim config",
  lhs = "<leader>R",
  rhs = ":source ~/.config/nvim/init.vim<CR>"
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
  rhs = ":<C-U>:Update<CR>"
}
my.keybind {
  description = "save (visual)",
  mode = "v",
  lhs = "<C-s>",
  rhs = ":<C-C>:Update<CR>"
}
my.keybind {
  description = "save (insert)",
  mode = "i",
  lhs = "<C-s>",
  rhs = ":<C-O>:Update<CR>"
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
  lhs = "<leader>tt",
  rhs = ":tabnew<CR>"
}
my.keybind {
  description = "tab: close current tab",
  lhs = "<leader>tc",
  rhs = ":tabclose<CR>"
}

-- windows
my.keybind {
  description = "window: enter window mode",
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
  rhs = ':let @/ = ""'
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
end