" same mappings as in original except for <BS> which is used for window nav
nmap <silent><buffer> <CR> <Plug>VimwikiFollowLink
nmap <silent><buffer> <S-CR> <Plug>VimwikiSplitLink
nmap <silent><buffer> <C-CR> <Plug>VimwikiVSplitLink
nmap <silent><buffer> + <Plug>VimwikiNormalizeLink
vmap <silent><buffer> + <Plug>VimwikiNormalizeLinkVisual
vmap <silent><buffer> <CR> <Plug>VimwikiNormalizeLinkVisualCR
nmap <silent><buffer> <D-CR> <Plug>VimwikiTabnewLink
nmap <silent><buffer> <C-S-CR> <Plug>VimwikiTabnewLink
nmap <silent><buffer> <BS><BS> <Plug>VimwikiGoBackLink
nmap <silent><buffer> <TAB> <Plug>VimwikiNextLink
nmap <silent><buffer> <S-TAB> <Plug>VimwikiPrevLink
nmap <silent><buffer> <leader>wn <Plug>VimwikiGoto
nmap <silent><buffer> <leader>wd <Plug>VimwikiDeleteFile
nmap <silent><buffer> <leader>wr <Plug>VimwikiRenameFile
nmap <silent><buffer> <C-Down> <Plug>VimwikiDiaryNextDay
nmap <silent><buffer> <C-Up> <Plug>VimwikiDiaryPrevDay

" fix auto-complete
"inoremap <silent><buffer><expr> <CR>      compe#confirm('<C-]><Esc>:VimwikiReturn 1 5<CR>')

