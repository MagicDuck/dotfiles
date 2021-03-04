let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-html', 'coc-css', 'coc-cssmodules', 'coc-stylelint', 'coc-lua']

"----------------------------------------------------------------------------
" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

set signcolumn=auto
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

augroup mycocsignaturehelp
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OrganizeImports   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Keybindings
let g:which_key_map.a = {
      \ 'name' : '+code action' ,
      \ 'f' : [':CocAction'               , 'actions for current line'],
      \ 'x' : [':CocList extensions'      , 'manage extensions'],
      \ 'c' : [':CocList commands'        , 'commands'],
      \ 'o' : [':CocList outlines'        , 'outline'],
      \ 's' : [':CocList -I symbols'      , 'workspace symbols'],
      \ 'h' : [':CocPrev'                 , 'Do default action for prev item'],
      \ 'l' : [':CocNext'                 , 'Do default action for next item'],
      \ 'p' : [':CocListResume'           , 'resume latest'],
      \ }

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ab  <Plug>(coc-codeaction)
let g:which_key_map.a.b = 'apply to current buffer'
" Apply AutoFix to problem on the current line.
nmap <leader>aa  <Plug>(coc-fix-current)
let g:which_key_map.a.a = 'autofix current line'

let g:which_key_map.i = {
      \ 'name' : '+intellisense (coc)' ,
      \ 'd' : [':CocList diagnostics'     , 'all diagnostics'],
      \ 'x' : [':CocList extensions'      , 'manage extensions'],
      \ 'c' : [':CocList commands'        , 'commands'],
      \ 'o' : [':CocList outlines'        , 'outline'],
      \ 's' : [':CocList -I symbols'      , 'workspace symbols'],
      \ 'h' : [':CocPrev'                 , 'Do default action for prev item'],
      \ 'l' : [':CocNext'                 , 'Do default action for next item'],
      \ 'p' : [':CocListResume'           , 'resume latest'],
      \ }

