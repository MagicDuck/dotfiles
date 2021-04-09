" TODO at some point, these should integrate with the Mappings
" quickfix list navigation that loops around
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

cabbrev cnext Cnext
cabbrev cprev Cprev
cabbrev lnext Lnext
cabbrev lprev LPREV

" grep
command! -nargs=+ RgSearch execute 'silent grep! <args>' | copen 16
