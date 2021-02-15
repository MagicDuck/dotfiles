" leader keys
noremap <Space> <Nop>
let mapleader = "\<Space>"
let maplocalleader = ","

" Create map to add keys to
let g:which_key_map =  {}

" window jumping
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile
let g:which_key_map[1] = 'jump to window 1'
let g:which_key_map[2] = 'jump to window 2'
let g:which_key_map[3] = 'jump to window 3'
let i = 4
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let g:which_key_map[i] = 'which_key_ignore'
    let i = i + 1
endwhile

let g:which_key_map['c'] = [ '<Plug>NERDCommenterToggle'  , 'comment' ]
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['f'] = [ ':Files'                     , 'search files' ]
let g:which_key_map['F'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map['b'] = [ ':Buffers'                   , 'search buffers' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below']
let g:which_key_map['r'] = [ ':Ranger'                    , 'ranger' ]
let g:which_key_map['R'] = [ ':source ~/.config/nvim/init.vim' , 'reload vim config' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['m'] = [ ':Marks'                     , 'search marks']

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" nerd tree
let g:which_key_map.t = {
      \ 'name' : '+tree' ,
      \ 'f' : [':NERDTreeFind'            , 'find buf in tree'],
      \ 't' : [':NERDTreeToggle'          , 'toggle tree'],
      \ 'c' : [':NERDTreeClose'           , 'close tree'],
      \ }

" git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'b' : [':Git blame'               , 'blame'],
      \ 's' : [':Git'                     , 'status'],
      \ 'o' : [':GBrowse'                 , 'open in browser'],
      \ }

" intellisense
let g:which_key_map.j = {
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


" Code Action
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


" Which-Key config 
"===============================================================================

let g:which_key_sep = '→'
let g:which_key_hspace = 10
"let g:which_key_timeout = 100
set timeoutlen=300

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
 \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
