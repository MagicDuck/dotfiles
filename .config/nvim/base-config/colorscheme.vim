set termguicolors

" see http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
augroup colorscheme_custom
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE 
  autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE 
  "autocmd ColorScheme * highlight LineNr guibg=#DADADA 
  autocmd ColorScheme * highlight LineNr guibg=NONE
  autocmd ColorScheme * highlight SignColumn guibg=NONE 
  autocmd ColorScheme * highlight FoldColumn guibg=NONE
  "autocmd ColorScheme * highlight SignColumn guibg=#DADADA 
  "autocmd ColorScheme * highlight FoldColumn guibg=#DADADA 
  autocmd ColorScheme * highlight CursorLineNr guibg=#f0f0f0
  autocmd ColorScheme * highlight CursorLine guibg=#f0f0f0
  autocmd ColorScheme * highlight Visual guibg=#e9f8ff
  autocmd ColorScheme * highlight VertSplit guibg=NONE
  autocmd ColorScheme * highlight Comment guibg=NONE guifg=#777777 gui=NONE
  autocmd ColorScheme * highlight SpecialComment guibg=NONE guifg=#777777 gui=NONE
  autocmd ColorScheme * highlight Todo guibg=#ffc9c9 gui=bold
augroup END

" remove odd ~ squiggles from end of buffer
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

"set background=dark
"colorscheme sonokai " tutticolor colorful lucius
"colorscheme zephyr
"colorscheme OceanicNext
set background=light
colorscheme edge
