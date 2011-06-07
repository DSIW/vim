" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END
else
  set autoindent    " always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Set linenumbers
set nu

" console vim has usually a dark background,
" while in gvim I usually use a light background
if has("gui_running")
" set bg=light
 set bg=dark
"else
" set bg=dark
endif

" set Unicode if possible
" --------------------
" First, check that the necessary capabilities are compiled-in
if has("multi_byte")
" (optional) remember the locale set by the OS
        let g:locale_encoding = &encoding
" if already Unicode, no need to change it
" we assume that an encoding name is a Unicode one
" iff its name starts with u or U
        if &encoding !~? '^u'
" avoid clobbering the keyboard's charset
                if &termencoding == ""
                        let &termencoding = &encoding
                endif
" now we're ready to set UTF-8
                set encoding=utf-8
        endif
" heuristics for use at file-open
" how are different fileencodings determined?
" This is a list. The first that succeeds, will be used
" default is 'ucs-bom,utf-8,default,latin1'
        set fileencodings=ucs-bom,utf-8,latin9
endif

" Tweak timeouts, because the default is too conservative
" This setting is taken from :h 'ttimeoutlen'
set timeout timeoutlen=3000 ttimeoutlen=100

set t_Co=256
colo xoria256
" map <F3> :setlocal spell spelllang=de<cr>
"iunmap ll
" Softwrap
set linebreak
set wrap
" Format text width the external programm "par". Use "gq" for the external program; or use "gw" for internal program of vim
set formatprg=par\ -re
set nolist
" Shortcut to rapidly toggle `set list`
nmap _l :set list!<CR>
set listchars=tab:▸\   "eol:¬
"Invisible character colors
"highlight SpecialKey ctermfg=5
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59
set showbreak=

" Set shell
set sh=bash

" Numberformat to use, unsetting bascially only allows decimal
" octal and hex may make trouble if tried to increment/decrement
" certain numberformats
" (e.g. 007 will be incremented to 010, because vim thinks its octal)
set nrformats=

" Matching of IP-Addresses Highlight in yellow
highlight ipaddr term=bold ctermfg=yellow guifg=yellow
" highlight ipaddr ctermbg=green guibg=green
match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/


" highlight matching parens:
" Default for matchpairs: (:),[:],{:},<:>
     set matchpairs+=<:>
     highlight MatchParen term=reverse ctermbg=7 guibg=cornsilk

" Hardwrap
set textwidth=0
set wrapmargin=5
set formatoptions= "ta

set expandtab "tabs to sapces (alternativly: set noexpandtab: spaces to tabs, :retab

"-----------------------------------------------------------------------------
" Global Stuff from Derek
"-----------------------------------------------------------------------------

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Tabstops are 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2 " for backspace in insert-mod
set expandtab

" set the search scan to wrap lines
set wrapscan

" set the search scan so that it ignores case when the search is all lower
" case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

" Set the status line the way i like it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" STATUSBAR
" --------------------
" if has("statusline")
"     set statusline=
"     set statusline+=%-3.3n\ " buffer number
"     set statusline+=%f\ " file name
"     set statusline+=%h%m%r%w " flags
"     set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
" " set statusline+=%{&encoding}, " encoding
"     set statusline+=%{(&fenc==\"\"?&enc:&fenc)},
"     set statusline+=%{&fileformat} " file format
"     set statusline+=%{(&bomb?\",BOM\":\"\")}] " BOM
"     set statusline+=%= " right align
" "set statusline+=0x%-8B\ " current char
"     set statusline+=%-10.(%l,%c%V%)\ %p%% " offset
" "set statusline=%<%f\ %h%m%r%=%k[%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %-12.(%l,%c%V%)\ %P
" endif

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Don't update the display while executing macros
set lazyredraw

" Show the current command in the lower right corner
set showcmd

" Show the current mode
set showmode

" Turn on: showmatching brackets
set showmatch

" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
set guioptions=ac

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" Keep some stuff in the history
set history=100

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
"set foldmethod=syntax " folding by syntax
set foldclose=all " if curser out of fold, then close
set foldcolumn=2 " set the column of the left side
set foldenable " folding is enabled

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
set virtualedit=all

" These things start comment lines
set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:-

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 120 chars
set textwidth=120

" get rid of the silly characters in window separators
set fillchars=""

" Turn tabs into spaces
set expandtab

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Initial path seeding
set path=
set path+=/usr/local/include/**
set path+=/usr/include/**
set path+=~/code/**

" Set the tags files to be the following
set tags=./tags,tags

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" I don't like it when the matching parens are automatically highlighted
let loaded_matchparen = 1

"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------
augroup derek_xsd
  au!
  au BufEnter *.xsd,*.wsdl,*.xml setl tabstop=4 | setl shiftwidth=4
  au BufEnter *.xsd,*.wsdl,*.xml setl formatoptions=crq | setl textwidth=80
augroup END

augroup Binary
  au!
  au BufReadPre   *.bin let &bin=1
  au BufReadPost  *.bin if &bin | %!xxd
  au BufReadPost  *.bin set filetype=xxd | endif
  au BufWritePre  *.bin if &bin | %!xxd -r
  au BufWritePre  *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

if has("autocmd")
  " Source the vimrc file after saving it
  autocmd bufwritepost vimrc source $MYVIMRC

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
endif

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
  "set guifont=Monaco:h12
  set guioptions-=T
  colorscheme xoria256
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

"---------------------------------------------
" Insert external vim sources
"---------------------------------------------
source ~/.vim/mapping.vim
source ~/.vim/plugin.vim
source ~/.vim/functions.vim
" vimspell: http://www.vim.org/scripts/script.php?script_id=465
source ~/.vim/abbrev.vim
source ~/.vim/private.vim " Private Daten
