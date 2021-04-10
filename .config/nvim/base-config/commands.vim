" Quickfix list navigation that loops around
"-----------------------------------------------------------------------------------------------
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

cabbrev cnext Cnext
cabbrev cprev Cprev
cabbrev lnext Lnext
cabbrev lprev LPREV

" Wipe all deleted (unloaded & unlisted) or all unloaded buffers
"-----------------------------------------------------------------------------------------------
function! MyBwipeout(listed) abort
  let l:buffers = filter(getbufinfo(), {_, v -> !v.loaded && (!v.listed || a:listed)})
  if !empty(l:buffers)
      execute 'bwipeout' join(map(l:buffers, {_, v -> v.bufnr}))
  endif
endfunction
command! -bar -bang Bwipeout call MyBwipeout(<bang>0)

" Grep with rg and open in quickfix
"-----------------------------------------------------------------------------------------------
command! -nargs=+ RgSearch execute 'silent grep! <args>' | copen 16

" Search in files
"-----------------------------------------------------------------------------------------------
command! -bang -nargs=? -complete=dir MyFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

function! RipgrepFzf(path, rgArgs) 
  let command_fmt = "rg --column --line-number --no-heading --color=always --ignore-file %s --smart-case %s %s %s || true"
  let initial_command = printf(command_fmt, g:my_global_rg_ignore_file, "", a:path, a:rgArgs)
  let reload_command = printf(command_fmt, g:my_global_rg_ignore_file, '{q}', a:path, a:rgArgs)
  let spec = {'options': ['--phony', '--query', "", '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), 0)
endfunction

command! -nargs=* -bang Search
  \ call RipgrepFzf('', <q-args>)

" Marks with preview
"-----------------------------------------------------------------------------------------------
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

