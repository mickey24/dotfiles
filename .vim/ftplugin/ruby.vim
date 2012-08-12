augroup MyRubyAutoCmd
  autocmd!
augroup END

" Syntax check
compiler ruby
autocmd MyRubyAutoCmd BufWritePost <buffer> silent make -c % | redraw!
