let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" window number in status line
if !exists("my_airline_number_setup")
  let my_airline_number_setup = 1

  function! WindowNumber(...)
      let builder = a:1
      let context = a:2
      call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
      return 0
  endfunction

  call airline#add_statusline_func('WindowNumber')
  call airline#add_inactive_statusline_func('WindowNumber')
endif