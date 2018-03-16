" solarized {
  " set background=light " or light
  "color xoria256
  " color solarized                 " load a colorscheme
  " let g:solarized_termtrans=0
  " let g:solarized_termcolors=256
  " let g:solarized_contrast="high"
  " let g:solarized_visibility="low"
  " set t_Co=256
" }

" Set up the gui cursor to look nice
set guicursor=n-v:block-Cursor-blinkwait1000-blinkoff150-blinkon1000
set guicursor+=c:ver25-Cursor
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor10-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
" highlight Cursor guifg=NONE guibg=NONE
" highlight Visual guifg='white' guibg='#b58900'
highlight Visual guifg='white' guibg='#DE1D5C'

highlight Search guibg=NONE guifg='#cb4b16'
highlight CursorLineNr guifg='#af8700' guibg=NONE

" set the gui options the way I like
set guioptions=ac
"set guioptions-=m
"set guioptions-=T


" set guifont=Monospace\ 9
" set guifont=Monaco\ for\ Powerline\ 9
" set guifont=Inconsolata\ for\ Powerline\ Medium\ 10
" set guifont=Mensch\ for\ Powerline\ Medium\ 9
" set guifont=Source\ Code\ Pro\ for\ Powerline\ 9
" set guifont=RobotoMono\ 10
set guifont=GohuGohuFont\ 10
" set guifont=GohuGohuFont\ 8
set guioptions-=T
"colorscheme xoria256
if has("gui_running")
  if !exists("g:vimrcloaded")
    winpos 0 0
    if ! &diff
      winsize 130 90
    else
      winsize 227 90
    endif
    let g:vimrcloaded = 1
  endif
endif
:nohls

if filereadable(expand("~/.gvimrc.local"))
    source ~/.gvimrc.local
endif
