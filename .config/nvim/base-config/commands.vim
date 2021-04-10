" quickfix list navigation that loops around
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

cabbrev cnext Cnext
cabbrev cprev Cprev
cabbrev lnext Lnext
cabbrev lprev LPREV

" grep and open in quickfix
command! -nargs=+ RgSearch execute 'silent grep! <args>' | copen 16

" TODO should this be called on leader-f and leader-b ?
" Wipe all deleted (unloaded & unlisted) or all unloaded buffers
function! MyBwipeout(listed) abort
  let l:buffers = filter(getbufinfo(), {_, v -> !v.loaded && (!v.listed || a:listed)})
  if !empty(l:buffers)
      execute 'bwipeout' join(map(l:buffers, {_, v -> v.bufnr}))
  endif
endfunction
command! -bar -bang Bwipeout call MyBwipeout(<bang>0)
