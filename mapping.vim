" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker tabstop=4 shiftwidth=4:

" Deactivate the help dialoge {{{
    imap <F1> <ESC>
    nmap <F1> <ESC>
    vmap <F1> <ESC>
" }}}
"---------------------------------------------------------
" Useful mappings
"---------------------------------------------------------
" Don't use Ex mode, use Q for formatting
map Q gq
" Remember the cursor position while formating paragraph
nmap ,Q mzQap'z

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Note: You have to set in your bash_profile
" bind -r '\C-s'
" stty -ixon
map <C-s> <esc>:update<cr>

nnoremap Y y$

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

nnoremap / /\v
map K <nop> " Disable K looking stuff up

noremap <leader>sg :%s/
noremap <leader>s :s/

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Indent without cursor position change
nnoremap <leader>i mzgg=G'z

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Fold all regions except the visually selected one:
vnoremap <leader>h :<c-u>1,'<lt>-fold<bar>'>+,$fold<CR>

" You are too fast and keep pressing `shift' if you type :w, try following
":command! -bang W w<bang>
command! -bang -bar -nargs=? -complete=file -range=% W <line1>,<line2>w<bang> <args>
command! -bang Wq wq<bang>
command! -bang Q q<bang>

" disallow opening the commandline window which by default is bound to
" q: (I tend to usually mean :q)
" The commandline window is still accessible using q/ or q?
noremap q: :q

" In help files, map Enter to follow tags
au filetype help set nonumber      " no line numbers when viewing help
au filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
au filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back

" execute the command in the current line (minus the first word, which
" is intended to be a shell prompt and needs to be $) and insert the
" output in the buffer
nmap <leader>e 0wy$:r!<cword><CR>
nmap <leader>E 0wwy$:r!<cword><CR>

" for editing a file with other users, this will insert my name and
" the date, when I edited
nmap <leader>cb odsiw, <ESC>:r!LC_ALL='' date<CR>kJo-

if exists("*pumvisible")
    inoremap <expr> <Down> pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"
    inoremap <expr> <Up> pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"
else
   inoremap <Down> <C-O>gj
   inoremap <Up> <C-O>gk
endif

if version > 700
" turn spelling on by default:
" set spell
" toggle spelling with F12 key:
    map <F12> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
endif

" WINDOWS {{{
    " Maps to make handling windows a bit easier
    "
    noremap <silent> <C-h> :wincmd h<CR>
    noremap <silent> <C-j> :wincmd j<CR>
    noremap <silent> <C-k> :wincmd k<CR>
    noremap <silent> <C-l> :wincmd l<CR>
    noremap <silent> <leader>= :wincmd =<CR>
    noremap <silent> <C-F9>  :vertical resize -5<CR>
    noremap <silent> <C-F10> :resize -5<CR>
    noremap <silent> <C-F11> :resize +5<CR>
    noremap <silent> <C-F12> :vertical resize +5<CR>
    noremap <silent> <leader>s8 :vertical resize 83<CR>
    noremap <silent> <leader>cj :wincmd j<CR>:close<CR>
    noremap <silent> <leader>ck :wincmd k<CR>:close<CR>
    noremap <silent> <leader>ch :wincmd h<CR>:close<CR>
    noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
    noremap <silent> <leader>cw :close<CR>
    "noremap <silent> <leader>ml <C-W>L
    "noremap <silent> <leader>mk <C-W>K
    "noremap <silent> <leader>mh <C-W>H " same in ShowMarks
    "noremap <silent> <leader>mj <C-W>J

    " ,q to toggle quickfix window (where you have stuff like GitGrep)
    " ,oq to open it back up (rare)
    nmap <silent> <leader>qc :cclose<CR>
    nmap <silent> <leader>qo :copen<CR>

    " Create window splits easier. The default
    " way is Ctrl-w,v and Ctrl-w,s. I remap
    " this to vv and ss
    nnoremap <silent> vv <C-w>v
    nnoremap <silent> ss <C-w>s
    nnoremap <silent> <leader>wo :ZoomWin<CR>
" }}}

" TABS {{{
    " Maps to make handling windows a bit easier
    "
    nnoremap <C-t> <esc>:tabnew<CR>
    nmap ]w :tabnext<cr>
    nmap [w :tabprev<cr>
    nmap ,tc :tabclose<cr>
" }}}

" VIMRC {{{
    " Edit the vimrc file
    nnoremap <silent> <leader>ev :vsp ~/.vim/vimrc<CR>
    nnoremap <silent> <leader>sv :so ~/.vim/vimrc<CR>
    nmap <leader>em :e ~/.vim/mapping.vim<CR>
    nnoremap <leader>ek :tabnew ~/.vim/memories<CR>
" }}}

" Copy & Paste {{{
    vnoremap <C-c> "+y
    " Toggle paste mode
    nnoremap <silent> <leader>p :set invpaste<CR>:set paste?<CR>
    nnoremap <silent> <C-p> :set paste<cr>o<esc>"+]P:set nopaste<cr>"

    " Copy line and comment out copied line
    nnoremap yd yypkk:put =b:NERDCommenterDelims['left']<CR>==Jjb
" }}}

" Conversion {{{
    " source: https://github.com/begriffs/dotfiles/blob/master/.vimrc
    " Convert symbol to string
    "nnoremap <silent> <leader>2s F:r"Ea"<ESC>
    " Convert string to symbol
    "nnoremap <silent> <leader>2y F"r:,x

    " Convert name to snake_case
    nmap <leader>2_ cr_
    " Convert name to camelCase
    nmap <leader>2c crc
    " Convert name to MixedCase
    nmap <leader>2m crm
    " Convert name to SNAKE_UPPERCASE
    nmap <leader>2u cru
    " Convert name to dash-case
    nmap <leader>2- cr-
" }}}

" Folding {{{
    "nmap <leader>f0 :set foldlevel=0<CR>
    "nmap <leader>f1 :set foldlevel=1<CR>
    "nmap <leader>f2 :set foldlevel=2<CR>
    "nmap <leader>f3 :set foldlevel=3<CR>
    "nmap <leader>f4 :set foldlevel=4<CR>

    nnoremap <space> za
" }}}

"---------------------------------------------------------
" From Derek
"---------------------------------------------------------
" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>:pwd<CR>
nmap <silent> <leader>mkd :!mkdir -p %:p:h<CR>:pwd<CR>

" Turn off that stupid highlight search
nmap <silent> <leader>n :set invhls<CR>:set hls?<CR>

" set text wrapping toggles
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>
"set hardwrapping
nmap <leader>wh set fo=at
"set softwrapping
nmap <leader>ws set fo=

" Buffer commands
" Deletes buffer and leave window intact
noremap <silent> <leader>bd :BD<CR>

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Highlight all instances of the current word under the cursor
"nmap <silent> ^ :setl hls<CR>:let @/="<C-r><C-w>"<CR>

" Search the current file for what's currently in the search {{{
    " register and display matches
    nmap <silent> <leader>gs
          \ :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

    " Search the current file for the word under the cursor and display matches
    nmap <silent> <leader>gw
          \ :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

    " Search the current file for the WORD under the cursor and display matches
    nmap <silent> <leader>gW
          \ :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>
" }}}

" Swap two words
nmap <silent> sw "xdiwdwep"xp
nmap <silent> sW "xdiWdwEp"xp

" Delete all buffers
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" better undo {{{
    inoremap <C-U> <C-G>u<C-U>
    inoremap <C-W> <C-G>u<C-W>
    inoremap <BS> <C-G>u<BS>
    inoremap <Del> <C-G>u<Del>
" }}}

" Visually select the text that was last edited/pasted
nmap gV `[v`]
"fold a method/function
nmap <leader>zm /}<CR>zf%<ESC>:nohlsearch<CR>
"change text in "" to the copied text
nmap <leader>c" vi"d"+P

" Split line (opposite to S-J joining line)
" Pressing `Enter' inserts a new line
" only if buffer is modifiable (e.g. not in help or quickfix window)
if (&ma)
    " nmap <buffer> <CR> i<CR><ESC>
    nnoremap <leader><CR> gEa<CR><ESC>ew
endif

" AutoClose
"au Filetype markdown,octopress nmap <leader>iuw i[xepa("+P
"au Filetype markdown,octopress nmap <leader>iuW i[xEpa("+P
"au Filetype markdown,octopress vmap <leader>iu s[lxhf]hxa("+Pl
" DelimitMate
au Filetype markdown,octopress nmap <leader>iuw ysw]ela(<C-R>+<ESC>
au Filetype markdown,octopress nmap <leader>iuW ysW]Ea(<ESC>"+p
au Filetype markdown,octopress vmap <leader>iu s]f]a(<C-R>+<ESC>
au Filetype markdown,octopress nmap <leader>up O**Update vom <ESC>:r!getDateVersion -d<CR>kJA:** **<ESC>i

nnoremap ze zMzo
nnoremap zE zMzO

" Stamping {{{
    " replace the current word with the last yanked text
    "nnoremap S diw"0P
    " replace visually selected text with the last yanked text
    "vnoremap S "_d"0P
    " replace the current word with the last yanked or deleted text
    nnoremap S "_diwP
    " replace visually selected text with the last yanked or deleted text
    vnoremap S "_dP
" }}}

nnoremap ]d ]czz " next diff and set screen to center of curser
nnoremap [d [czz " previous diff and set screen to center of curser
nnoremap <leader>d :diffthis<CR>

" Source
vnoremap <c-x> y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <c-x> ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Run the command that was just yanked
nmap <silent> <leader>rc :@"<cr>

" Don't move on *
nnoremap * *<c-o>:set hlsearch<cr>

nmap <Leader>r) ds)i <esc>
nmap <Leader>r( eF r(A)<esc>
