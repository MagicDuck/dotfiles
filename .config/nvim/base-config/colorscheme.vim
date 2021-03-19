set termguicolors

augroup colorscheme_custom
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=NONE
  autocmd ColorScheme * highlight EndOfBuffer guibg=NONE

  autocmd ColorScheme * highlight LineNr guibg=NONE
  autocmd ColorScheme * highlight SignColumn guibg=NONE
  autocmd ColorScheme * highlight FoldColumn guibg=NONE
  " autocmd ColorScheme * highlight CursorLineNr guibg=#f0f0f0
  " autocmd ColorScheme * highlight CursorLine guibg=#f0f0f0
  " autocmd ColorScheme * highlight Visual guibg=#E9F5F5
  " autocmd ColorScheme * highlight VertSplit guibg=NONE
  " autocmd ColorScheme * highlight Comment guibg=#EDF0F3 guifg=#828486 gui=NONE
  autocmd ColorScheme * highlight Comment guibg=#EDF0F3 guifg=#626466 gui=NONE
  autocmd ColorScheme * highlight SpecialComment guibg=NONE guifg=#808080 gui=NONE
  autocmd ColorScheme * highlight Todo guibg=#ffc9c9 gui=bold
augroup END
" augroup colorscheme_custom
"   autocmd!
"   autocmd ColorScheme * highlight Normal guibg=#fafbfc
"   " autocmd ColorScheme * highlight Normal guibg=#ffffff
"   autocmd ColorScheme * highlight EndOfBuffer guibg=#fafbfc
"
"   " autocmd ColorScheme * highlight LineNr guibg=NONE
"   " autocmd ColorScheme * highlight SignColumn guibg=NONE
"   " autocmd ColorScheme * highlight FoldColumn guibg=NONE
"   " autocmd ColorScheme * highlight CursorLineNr guibg=#f0f0f0
"   " autocmd ColorScheme * highlight CursorLine guibg=#f0f0f0
"   autocmd ColorScheme * highlight Visual guibg=#E9F5F5
"   " autocmd ColorScheme * highlight VertSplit guibg=NONE
"   autocmd ColorScheme * highlight Comment guibg=NONE guifg=#808080 gui=NONE
"   autocmd ColorScheme * highlight SpecialComment guibg=NONE guifg=#808080 gui=NONE
"   autocmd ColorScheme * highlight Todo guibg=#ffc9c9 gui=bold
" augroup END

" remove odd ~ squiggles from end of buffer
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

"set background=dark
"colorscheme sonokai " tutticolor colorful lucius
"colorscheme zephyr
"colorscheme OceanicNext
colorscheme edge
set background=light
