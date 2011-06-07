if has("autocmd")
  autocmd bufwritepost functions source $MYVIMRC
endif

" delete whitespaces in the end of a line
" Only do this part when compiles with support for autocommands"
if(has("autocmd"))
  autocmd BufWritePre *.py *.js :call <SID>StripTrailingWhitespaces()
endif


function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call <SID>StripTrailingWhitespaces()<CR>


function! RunSystemCall(systemcall)
  let output = system(a:systemcall)
  let output = substitute(output, "\n", '', 'g')
  return output
endfunction
