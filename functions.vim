if has("autocmd")
  autocmd bufwritepost functions source $MYVIMRC
endif

" delete whitespaces in the end of a line
" Only do this part when compiles with support for autocommands"
"if(has("autocmd"))
  "autocmd BufWritePre *.py *.js :call <SID>StripTrailingWhitespaces()
"endif


" Clean all end of line extra whitespace with ,S
" Credit: voyeg3r https://github.com/mitechie/pyvim/issues/#issue/1
" deletes excess space but maintains the list of jumps unchanged
" for more details see: h keepjumps
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
nmap <silent> <leader>S <esc>:keepjumps call CleanExtraSpaces()<cr>

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

"-----------------------------------------------------------------------------
" Periodically save of the current buffer
"-----------------------------------------------------------------------------
"au BufRead,BufNewFile * let b:start_time=localtime()
"au BufWrite * let b:start_time=localtime()
"au CursorHold * call UpdateFile()
"" only write if needed and update the start time after the save
"function! UpdateFile()
  "if ((localtime() - b:start_time) >= 60)
    "update
    "let b:start_time=localtime()
  "else
    "echo "Only " . (localtime() - b:start_time) . " seconds have elapsed so far."
  "endif
"endfunction
