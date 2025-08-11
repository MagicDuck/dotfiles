vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.cmd.filetype('on')
vim.cmd.filetype('plugin on')

-- see: https://neovim.io/doc/user/lua.html#vim.opt
local opt = vim.opt

-- set through editorconfig
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0
vim.g.editorconfig = true
opt.expandtab = false
opt.smarttab = true
opt.hlsearch = true -- highlight search
opt.incsearch = true -- incremental search
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true -- better case handling for insert mode completion
opt.wrapscan = true
opt.autoindent = true
opt.autoread = true -- automatically reload files changed outside Vi
opt.cmdheight = 1
opt.laststatus = 2
opt.showcmd = false -- don't show command in status line as you type it
opt.showfulltag = true
opt.shortmess:append({ t = true, s = true, I = true, c = true, A = true })
vim.cmd([[ set wildchar=<Tab> ]]) -- expects a char (number)
vim.cmd([[ set wildcharm=<C-z> ]]) -- expects a char (number)
vim.cmd([[ set wildoptions=fuzzy,pum ]])
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignorecase = true
opt.cursorline = true
opt.clipboard = 'unnamedplus' -- use system clipboard
opt.fileformats = 'unix,dos'
opt.backupcopy = 'yes' -- make file change watchers happy
opt.number = true
opt.relativenumber = false
opt.pumheight = 10 -- Makes popup menu smaller
opt.fileencoding = 'utf-8' -- The encoding written to file
opt.ruler = true -- Show the cursor position all the time
opt.iskeyword:append('-') -- treat dash separated words as a word text object"
opt.mouse = 'a' -- Enable your mouse
opt.splitbelow = true -- Horizontal splits will automatically be below
opt.splitright = true -- Vertical splits will automatically be to the right
opt.conceallevel = 0 -- So that I can see `` in markdown files
opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
opt.backup = false
opt.writebackup = false
opt.updatetime = 300 -- Faster completion
opt.formatoptions = 'jqlnt' -- disable auto-comments
opt.signcolumn = 'yes' -- always show sign column
opt.scrolloff = 999 -- keep cursor in the middle of the window
opt.scroll = 5 -- number of lines the scroll commands should scroll
opt.termguicolors = true -- true color
opt.timeout = false -- don't time out on leader commands
opt.foldenable = false
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.grepformat = '%f:%l:%c:%m'
opt.shiftround = true
opt.grepprg = 'rg --vimgrep --smart-case --follow'
opt.fillchars = { diff = '╱', fold = '⋆', vert = '│', eob = ' ', msgsep = '‾' }
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
-- vim.o.messagesopt = 'wait:500,history:10000'
vim.o.messagesopt = 'hit-enter,history:10000'

-- opt.backspace = { 'start' }
if vim.fn.has('nvim-0.9.0') == 1 then
  opt.splitkeep = 'screen'
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- define signs to show in the sign column
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInformation', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignError', { text = '✘', texthl = 'DiagnosticSignError' })

-- see https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
vim.diagnostic.config({
  virtual_text = {
    prefix = '■', -- Could be '●', '▎', 'x'
  },
})

-- add error format for tsc
-- from a buffer, can use with :cexpr getline(1, '$')
vim.cmd([[
  set errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m,%f:%l:%c
]])

-- diff opts
vim.cmd([[
  set diffopt+=linematch:60
]])

-- filetype for conf files
vim.filetype.add({
  extension = { rasi = 'rasi', rofi = 'rasi', wofi = 'rasi' },
  filename = {
    ['vifmrc'] = 'vim',
  },
  pattern = {
    ['.*/waybar/config'] = 'jsonc',
    ['.*/mako/config'] = 'dosini',
    ['.*/kitty/kitty.conf'] = 'kitty',
    -- ['.*/ghostty/config'] = 'dosini',
    ['.*/hypr/.+%.conf'] = 'hyprlang',
    ['%.env%.[%w_.-]+'] = 'sh',
  },
})
vim.treesitter.language.register('bash', 'kitty')
