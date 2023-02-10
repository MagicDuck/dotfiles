" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert

imap <silent> <c-space> <Plug>(completion_trigger)

" snippet support
let g:completion_enable_snippet = 'UltiSnips'

" matching strategy
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

" ignore case
let g:completion_matching_ignore_case = 1

let g:completion_trigger_keyword_length = 3


let g:completion_chain_complete_list = {
    \ 'default' : {
    \   'default': [
    \       {'complete_items': ['buffers', 'snippet', 'lsp', 'path']},
    \       {'mode': '<c-p>'},
    \       {'mode': '<c-n>'}],
    \   }
    \}
let g:completion_auto_change_source	= 1

" let g:completion_trigger_on_delete = 1

" TODO (sbadragan): should we use this for vimwiki?
" let g:completion_confirm_key = ""
" imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
"     \ "\<Plug>(completion_confirm_completion)"  :
"     \ "\<c-e>\<CR>" : "\<CR>"
