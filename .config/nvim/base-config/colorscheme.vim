augroup colorscheme_custom
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=#fafbfc
  autocmd ColorScheme * highlight EndOfBuffer guibg=NONE

  autocmd ColorScheme * highlight LineNr guibg=NONE
  autocmd ColorScheme * highlight SignColumn guibg=NONE
  autocmd ColorScheme * highlight FoldColumn guibg=NONE
  " autocmd ColorScheme * highlight CursorLineNr guibg=#f0f0f0
  " autocmd ColorScheme * highlight CursorLine guibg=#f0f0f0
  autocmd ColorScheme * highlight Visual guibg=#E9F5F5
  " autocmd ColorScheme * highlight VertSplit guibg=NONE
  " autocmd ColorScheme * highlight Comment guibg=#EDF0F3 guifg=#828486 gui=NONE
  autocmd ColorScheme * highlight Comment guibg=#EDF0F3 guifg=#626466 gui=NONE
  autocmd ColorScheme * highlight SpecialComment guibg=#EDF0F3 guifg=#626466 gui=NONE
  autocmd ColorScheme * highlight TSComment guibg=#EDF0F3 guifg=#626466 gui=NONE
  " autocmd ColorScheme * highlight SpecialComment guibg=#EDF0F3 guifg=#626466 gui=NONE
  " autocmd ColorScheme * highlight Todo gui=bold
  " autocmd ColorScheme * highlight Todo guibg=#ffc9c9 gui=bold
  " autocmd ColorScheme * highlight Todo guibg=#ffc9c9 gui=bold
  autocmd ColorScheme * highlight HopNextKey guibg=#ffc9c9 guifg=#222222 gui=bold
  autocmd ColorScheme * highlight HopNextKey1 guibg=#d4dfff guifg=#222222 gui=bold
  autocmd ColorScheme * highlight HopNextKey2 guibg=#d4dfff guifg=#222222 gui=bold
  autocmd ColorScheme * highlight clear DiffText
  autocmd ColorScheme * highlight DiffText guibg=#DBD1F6
  autocmd ColorScheme * highlight clear LspDiagnosticsDefaultInformation
  autocmd ColorScheme * highlight LspDiagnosticsDefaultInformation guifg=#4C9E90

  " autocmd ColorScheme * highlight clear LspDiagnosticsUnderlineError
  " autocmd ColorScheme * highlight clear LspDiagnosticsUnderlineWarning
  " autocmd ColorScheme * highlight clear LspDiagnosticsUnderlineInformation
  " autocmd ColorScheme * highlight clear LspDiagnosticsUnderlineHint
  autocmd ColorScheme * highlight link TSError Normal
  " autocmd ColorScheme * highlight clear TSError
  " autocmd ColorScheme * highlight TSError guibg=#FAF2F2
  " autocmd ColorScheme * highlight markdownHighlightjavascript guibg=#ffc9c9

  autocmd ColorScheme * highlight TelescopeNormal guibg=#fafbfc
  autocmd ColorScheme * highlight TelescopeMatching guifg=#d05858 gui=bold
  " autocmd ColorScheme * highlight clear Cursor
  " autocmd ColorScheme * highlight Cursor guibg=#DBD1F6
  
  autocmd ColorScheme * highlight TSVariable guifg=#222222
  autocmd ColorScheme * highlight TSParameter guifg=#222222
  autocmd ColorScheme * highlight TSParameterReference guifg=#222222
  " autocmd ColorScheme * highlight MyTodo guifg=#4C9E90 gui=bold
  autocmd ColorScheme * highlight MyTodo guifg=#BE7E05 gui=bold

  " fidget
  autocmd ColorScheme * highlight link FidgetTitle Title
  autocmd ColorScheme * highlight link FidgetTask MoreMsg 
  " autocmd ColorScheme * highlight FidgetTitle guifg=#4C9E90 guibg=#fafbfc
  " autocmd ColorScheme * highlight FidgetTask guifg=#be7e05 guibg=#fafbfc
augroup END

" remove odd ~ squiggles from end of buffer and other annoying places, like diffs
set fillchars=diff:\ ,fold:\ ,vert:\│,eob:\ ,msgsep:‾

"set background=dark
"colorscheme sonokai " tutticolor colorful lucius
"colorscheme zephyr
"colorscheme OceanicNext
colorscheme edge
set background=light
