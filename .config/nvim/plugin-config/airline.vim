" source ~/.config/nvim/autoload/airline/themes/myoceaniclight.vim
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme='cool'
" let g:airline_theme='papercolor'
" let g:airline_theme='oceanicnextlight'
let g:airline_theme='myoceanicnextlight'

" window number in status line
if !exists("my_airline_number_setup")
  let my_airline_number_setup = 1

  function! WindowNumber(...)
      let builder = a:1
      let context = a:2
      call builder.add_section_spaced('airline_a', '%{tabpagewinnr(tabpagenr())}')
      return 0
  endfunction

  call airline#add_statusline_func('WindowNumber')
  call airline#add_inactive_statusline_func('WindowNumber')
endif

let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline_section_z="%p%% %#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L"
" let g:airline_section_b="%{airline#util#wrap(airline#extensions#hunks#get_hunks(),100)}%{airline#util#wrap(airline#extensions#branch#get_head(),80)}"
function! AirlineInit()
  let g:airline_section_z="%p%%"
  let g:airline_section_x=''
  let g:airline_section_y='_'
  let g:airline_section_b=''
endfunction
autocmd User AirlineAfterInit call AirlineInit()

let airline#extensions#tabline#current_first = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number

let airline#extensions#nvimlsp#error_symbol = ' '
let airline#extensions#nvimlsp#warning_sybmol = '⚠️'
