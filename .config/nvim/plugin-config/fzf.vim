" Extra key bindings
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  "copen
  " cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-l': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.9, 'height': 0.9,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'rounded' } }
let g:fzf_preview_window = ['up:50%']

let g:fzf_files_options = ['--keep-right']

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --tiebreak=length,end --bind ctrl-a:toggle-all '

let g:my_global_rg_ignore_file = expand("~/.config/nvim/rg_global_ignore") 
let $FZF_DEFAULT_COMMAND="rg --files --ignore-file " . g:my_global_rg_ignore_file . ' '

" handling setting and unsetting BAT_THEME for fzf.vim
let $BAT_THEME='OneHalfLight'
augroup update_bat_theme
  autocmd!
  autocmd colorscheme * call ToggleBatEnvVar()
augroup end
function ToggleBatEnvVar()
  let $BAT_THEME='OneHalfLight'
endfunction


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
:
