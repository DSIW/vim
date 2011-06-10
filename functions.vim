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

"-----------------------------------------------------------------------------
" Set up spell function
"-----------------------------------------------------------------------------

let g:myLang = 0
let g:myLangList = [ "Off", "german", "english", "german & english" ]
function! ChangeSpellLang()
  if g:myLang == 0 | set nospell | endif
  if g:myLang == 1 | setlocal spell spelllang=de | endif
  if g:myLang == 2 | setlocal spell spelllang=en_us | endif
  if g:myLang == 3 | setlocal spell spelllang=de,en_us | endif
  echo "language:" g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
map <F12> :call ChangeSpellLang()<CR>
"format the bad spelled words
hi SpellBad ctermbg=52 ctermfg=9
"set spell suggestion to 8
set spellsuggest=8
