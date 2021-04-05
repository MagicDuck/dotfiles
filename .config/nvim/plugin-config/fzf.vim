" Extra key bindings
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
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

"Get Files
command! -bang -nargs=? -complete=dir MyFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   " let spec = {'options': ['--with-nth', '--exact', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction
function! RipgrepFzf(path, rgArgs) 
  let command_fmt = "rg --column --line-number --no-heading --color=always --ignore-file %s --smart-case %s %s %s || true"
  let initial_command = printf(command_fmt, g:my_global_rg_ignore_file, "", a:path, a:rgArgs)
  let reload_command = printf(command_fmt, g:my_global_rg_ignore_file, '{q}', a:path, a:rgArgs)
  let spec = {'options': ['--phony', '--query', "", '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), 0)
endfunction

command! -nargs=* -bang Search
  \ call RipgrepFzf('', <q-args>)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Marks with preview
function! s:fzf_preview_p(bang, ...) abort
    let preview_args = get(g:, 'fzf_preview_window', ['up:50%', 'ctrl-/'])
    if empty(preview_args)
        return { 'options': ['--preview-window', 'hidden'] }
    endif

    " For backward-compatiblity
    if type(preview_args) == type('')
        let preview_args = [preview_args]
    endif
    return call('fzf#vim#with_preview', extend(copy(a:000), preview_args))
endfunction

command! -bar -bang MarksWithPreview
      \ call fzf#vim#marks(
      \     s:fzf_preview_p(<bang>0, {'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}',
      \               'options': '--preview-window +{2}-/2'}),
      \     <bang>0)

" command! -bar ExitExplorer  if (&ft == "coc-explorer") | wincmd l | endif

" key bindings
let g:which_key_map['b'] = [ 'Buffers' , 'search buffers' ]
let g:which_key_map['d'] = [ 'MyFiles'                   , 'search files' ]
let g:which_key_map['f'] = [ 'Search'                    , 'search text' ]
let g:which_key_map['j'] = [ 'MarksWithPreview'          , 'search marks with preview']

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : ['History/'     , 'history'],
      \ ';' : ['Commands'     , 'commands'],
      \ 'a' : ['Ag'           , 'text Ag'],
      \ 'b' : ['BLines'       , 'current buffer'],
      \ 'B' : ['Buffers'      , 'open buffers'],
      \ 'c' : ['Commits'      , 'commits'],
      \ 'C' : ['BCommits'     , 'buffer commits'],
      \ 'f' : ['MyFiles'      , 'files'],
      \ 'g' : ['GFiles'       , 'git files'],
      \ 'G' : ['GFiles?'      , 'modified git files'],
      \ 'h' : ['History'      , 'file history'],
      \ 'H' : ['History:'     , 'command history'],
      \ 'l' : ['Lines'        , 'lines'] ,
      \ 'm' : ['Marks'        , 'marks'] ,
      \ 'M' : ['Maps'         , 'normal maps'] ,
      \ 'p' : ['Helptags'     , 'help tags'] ,
      \ 'P' : ['Tags'         , 'project tags'],
      \ 's' : ['Snippets'     , 'snippets'],
      \ 'S' : ['Colors'       , 'color schemes'],
      \ 't' : ['Rg'           , 'text Rg'],
      \ 'T' : ['BTags'        , 'buffer tags'],
      \ 'w' : ['Windows'      , 'search windows'],
      \ 'y' : ['Filetypes'    , 'file types'],
      \ 'z' : ['FZF'          , 'FZF'],
      \ }

" finding files with C-p
nnoremap <silent><C-p> :MyFiles<CR>

