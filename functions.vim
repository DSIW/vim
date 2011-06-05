" delete whitespaces in the end of a line
" Only do this part when compiles with support for autocommands"
if(has("autocmd"))
  autocmd BufWritePre *.py *.js :call <SID>StripTrailingWhitespaces()
endif
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------

function! RunSystemCall(systemcall)
  let output = system(a:systemcall)
  let output = substitute(output, "\n", '', 'g')
  return output
endfunction
