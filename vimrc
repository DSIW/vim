" Modeline and Notes {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker tabstop=4 shiftwidth=4:
"
" I have the categories of this from Steve Francia (see http://spf13.com)
" }}}

" Environment {{{
    " Basics {{{
        set nocompatible    " must be first line
        set background=dark " Assume a dark background
        set ttyfast         " we have a fast tty
    " }}}

    " Initial path seeding {{{
        set path=
        set path+=/usr/local/include/**
        set path+=/usr/include/**
        set path+=~/sys/bin/**
    " }}}

    " Windows Compatible {{{
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }}}
" }}}

" Bundles {{{
    " Setup Bundle Support {{{
        filetype off                   " required!
        " The next two lines ensure that the ~/.vim/bundle/ system works
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
    " }}}

    "Bundle 'gmarik/vundle.git'
    Bundle 'vundle'
    "Bundle 'gmarik/github-search.vim'
    Bundle 'https://github.com/gmarik/github-search.vim.git'
    "Bundle 'https://github.com/gmarik/ingretu.git'

    " General {{{
        Bundle 'Lokaltog/vim-powerline'
        "Bundle 'unicode.vim'
        Bundle 'unimpaired.vim'
        Bundle 'lastpos.vim'
        Bundle 'sudo.vim'
        "Bundle 'vimshell-ssh'
        Bundle 'Gundo'
        Bundle 'The-NERD-tree'
        Bundle 'SearchComplete'
        Bundle 'EasyGrep'
        Bundle 'hexman.vim'
        "Bundle 'taglist.vim'
        Bundle 'speeddating.vim'
        Bundle 'trailing-whitespace'
        Bundle 'repeat.vim'
        "Bundle 'recover.vim'
        Bundle 'ack.vim'
        Bundle 'greplace.vim'

        Bundle 'VisIncr'
        Bundle 'AutomaticLaTexPlugin'
        "Bundle 'csv.vim'
        Bundle 'sessionman.vim'
        "Bundle 'AutoClose'
        Bundle 'delimitMate.vim'
        Bundle 'majutsushi/tagbar'
        Bundle 'YankRing.vim'
        Bundle 'ShowMarks'
        "Bundle 'Buffer-Search'
        "Bundle 'ShowPairs'
        "Bundle 'LustyJuggler'
        Bundle 'NrrwRgn'
    " }}}

    " UI {{{
        "Bundle 'xoria256.vim'
        "Bundle 'neverland.vim--All-colorschemes-suck'
        Bundle 'ZoomWin'
        Bundle 'altercation/vim-colors-solarized'
    " }}}

    " Programming {{{
        "Bundle 'xptemplate'
        Bundle 'Tabular'
        Bundle 'The-NERD-Commenter'
        "Bundle 'ProtoDef'
        "Bundle 'SuperTab'
        Bundle 'Indent-Guides'
        "Bundle 'VimDebug'
        "Bundle 'camelcasemotion'
        Bundle 'Syntastic'
        Bundle 'Shougo/neocomplcache'
        Bundle "MarcWeber/vim-addon-mw-utils"

        Bundle 'c.vim'
        Bundle 'FSwitch'

        Bundle 'ruby.vim'
        Bundle 'ecomba/vim-ruby-refactoring.git'
        Bundle 'skalnik/vim-vroom'
        Bundle 'splitjoin.vim'
        Bundle 'skwp/vim-rspec'

        "Bundle 'vim-coffee-script'

        "Bundle 'cespare/vjde.git'
        "Bundle 'javacomplete'
        "Bundle 'ervandew/eclim.git'

        "Bundle 'pep8'
        "Bundle 'mitechie/pyflakes-pathogen.git'
        "Bundle 'fs111/pydoc.vim.git'

        Bundle "tomtom/tlib_vim"
        Bundle "DSIW/snipmate-snippets"
        Bundle "garbas/vim-snipmate"

        "Bundle 'javascript.vim'
        Bundle 'vim-json-bundle'
    " }}}

    " Textobjects {{{
        Bundle 'kana/vim-textobj-user.git'
        Bundle 'textobj-rubyblock'
        " r
        Bundle 'textobj-function'
        " f
        Bundle 'textobj-entire'
        " e
        Bundle 'textobj-indent'
        " i/I
        Bundle 'textobj-fold'
        " z
        Bundle 'textobj-datetime'
        " d...
        Bundle 'argtextobj.vim'
        " a
        Bundle 'vim-textobj-quoted'
        " `
        Bundle 'bootleq/vim-textobj-rubysymbol'
        " :
    "}}}

    " Mail {{{
        "Bundle 'CheckAttach.vim'
    " }}}

    " Git {{{
        Bundle 'git.zip'
        Bundle 'fugitive.vim'
        Bundle 'Gist.vim'
    " }}}

    " Sourround {{{
        Bundle 'surround.vim'
        "Bundle 'delete-surround-html'
    " }}}

    " Web {{{
        "Bundle 'XML-Folding'
        "Bundle 'ragtag.vim'
        Bundle 'mirell/vim-matchit'
        Bundle 'vim-octopress'
        "Bundle 'rails.vim'
        "Bundle 'tpope/vim-rails'
        "Bundle 'Haml'
        "Bundle 'mirell/vim-matchit'
        Bundle 'tpope/vim-markdown'
        "Bundle 'Markdown-syntax'
        "Bundle 'tsaleh/vim-align'
    " }}}

    " errors {{{
        "Bundle 'Align.vim' " ERROR
        "Bundle 'checklist.vim' " ERROR
        "Bundle 'css_color.vim' " CPU raises up
        "Bundle 'vim-recovery' " NOT FOUND
        "Bundle 'minibufexpl.vim' ERROR with plugin "fugitive in diff mode"

        "Bundle 'endwise.vim'
        " ERROR with "pumvisible"

        "Bundle 'Solarized' " ERROR with comments (background is too dark)
    " }}}
" }}}

" General {{{
    " Set filetype stuff to on
    filetype on
    filetype plugin on
    filetype indent on

    set ff=unix " ff=dos " sets line end to UNIX

    set sh=zsh " Set shell

    syntax on " Switch on syntax highlighting.

    " Make the 'cw' and like commands put a $ at the end instead of just deleting
    " the text and replacing it
    "set cpoptions=ces$

    set history=1000 " Keep some stuff in the history

    set mousehide " Hide the mouse pointer while typing

    set autowrite    " e.g. before :make
    set autoread
    "set autochdir    " auto change dir of file

    set vb " set visual bell -- i hate that damned beeping

    " Allow the cursor to go in to "invalid" places
    set virtualedit=all

    " Disable encryption (:X)
    set key=

    " set the forward slash to be the slash of note. No backslashes
    set shellslash

    " Numberformat to use, unsetting bascially only allows decimal
    " octal and hex may make trouble if tried to increment/decrement
    " certain numberformats
    " (e.g. 007 will be incremented to 010, because vim thinks its octal)
    set nrformats=

    set hidden                      " allow buffer switching without saving

    " allow backspacing over everything in insert mode
    set backspace=indent,eol,start

    " Add ignorance of whitespace to diff
    set diffopt+=iwhite

    " These things start comment lines
    set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:-

    " Same as default except that I remove the 'u' option
    set complete=.,w,b,t

    " When completing by tag, show the whole tag, not just the function name
    set showfulltag

    " get rid of the silly characters in window separators
    set fillchars=""

    " Setting up the directories {{{
        set backup                      " backups are nice ...
        if has('persistent_undo')
            set undofile                "so is persistent undo ...
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif
        " Could use * rather than *.*, but I prefer to leave .files unsaved
        au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
        au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)
    " }}}

    " Search {{{
        set nohlsearch " Enable search highlighting

        set incsearch " Incrementally match the search

        set wrapscan " set the search scan to wrap lines

        " set the search scan so that it ignores case when the search is all lower
        " case but recognizes uppercase if it's specified
        set ignorecase
        set smartcase
    " }}}

    " encodings {{{
        " set Unicode if possible
        " First, check that the necessary capabilities are compiled-in
        if has("multi_byte")
          " (optional) remember the locale set by the OS
          let g:locale_encoding = &encoding
          " if already Unicode, no need to change it
          " we assume that an encoding name is a Unicode one
          " if its name starts with u or U
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
    " }}}

    " backups {{{
        " set backup dir
        set backup    " keep a backup file
        "set backupdir=~/.vim/backup/
        "set directory=~/.vim/tmp
    " }}}
" }}}

" Vim UI {{{
    set nu " Set linenumbers
    "set relativenumber

    " solarized {{{
        set background=light " or light
        hi IndentGuidesOdd  ctermbg=black
        hi IndentGuidesEven ctermbg=darkgrey
        "set background=light " or light
        "hi IndentGuidesOdd  ctermbg=white
        "hi IndentGuidesEven ctermbg=lightgrey
        "color xoria256
        colorscheme solarized                 " load a colorscheme
          let g:solarized_termtrans=0
          let g:solarized_termcolors=256
          let g:solarized_contrast="high"
          let g:solarized_visibility="low"
          let g:solarized_italic=1
          let g:solarized_bold=1
        set t_Co=256
    " }}}
    set showmode " Show the current mode

    " highlight {{{
        "Invisible character colors
        "highlight SpecialKey ctermfg=5
        "highlight NonText guifg=#4a4a59
        "highlight SpecialKey guifg=#4a4a59
        set showbreak=

        "match @Author oder @author
        :highlight author ctermbg=black ctermfg=blue
        :match author /\(@[aA]uth\?or: \?\)\@<=[^ ].\+/

        " highlight matching parens:
        " Default for matchpairs: (:),[:],{{{:}}},<:>
        set matchpairs+=<:>
        highlight MatchParen term=reverse ctermbg=7 guibg=cornsilk

        " I don't like it when the matching parens are automatically highlighted
        let loaded_matchparen = 1
    " }}}

    " tell VIM to always put a status line in, even if there is only one window
    set laststatus=2

    set ch=2 " Make command line two lines high

    set cursorline
    set hidden  " allow buffer switching without saving

    set wildmenu " Make the command-line completion better
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.

    set lazyredraw " Don't update the display while executing macros

    set winminheight=0              " windows can be 0 line high

    " Syntax coloring lines that are too long just slows down the world
    set synmaxcol=2048

    set list
    set listchars=tab:▸\ ,trail:·,extends:#,nbsp:· ",eol:¬ " Highlight problematic whitespace: ﹁

    set scrolloff=8                 " minimum lines to keep above and below cursor
    set scrolljump=5                " lines to scroll when cursor leaves screen

    if has('cmdline_info')
      set ruler                   " show the ruler
      set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
      set showcmd                 " show partial commands in status line and
      " selected characters/lines in visual mode
    endif

    set showmatch " Turn on: showmatching brackets

    " timeouts {{{
        " This is the timeout used while waiting for user input on a multi-keyed macro
        " or while just sitting and waiting for another key to be pressed measured
        " in milliseconds.
        "
        " i.e. for the ",d" command, there is a "timeoutlen" wait period between the
        "      "," key and the "d" key.  If the "d" key isn't pressed before the
        "      timeout expires, one of two things happens: The "," command is executed
        "      if there is one (which there isn't) or the command aborts.
        "set timeoutlen=500
        " Tweak timeouts, because the default is too conservative
        " This setting is taken from :h 'ttimeoutlen'
        set timeout timeoutlen=500 ttimeoutlen=100
    " }}}

    " statusline {{{
        if has("statusline")
            "set statusline=
            "set statusline+=%<%f " file name
            "set statusline+=\ %h%m%r%w " flags
            "set statusline+=\ Buf:%-3.3n " buffer number
            "set statusline+=\ [%-3.b][0x%-2.B] " current character unter curser
            "set statusline+=\ %{{{fugitive#statusline()}}} " Git branch
            "set statusline+=%= " right align
            "set statusline+=%k[
            "set statusline+=%{{{strlen(&ft)?&ft:'none'}}} " filetype
            "set statusline+=\ \|
            "set statusline+=\ %{{{&fileformat}}} " file format
            "set statusline+=/
            "set statusline+=%{{{(&fenc\ ==\ \"\"?&enc:&fenc)}}} " encoding
            "set statusline+=%{{{(&bomb?\",BOM\":\"\")}}} " BOM
            "set statusline+=]
            "set statusline+=\ %-12.(%l,%c%V%)\ %p%% " offset

            "statusline setup (via https://github.com/skwp/dotfiles/blob/master/vim/plugin/settings/yadr-statusline.vim)
            "set statusline=%#DiffAdd#
            "set statusline+=%#warningmsg#
            "set statusline+=%{SyntasticStatuslineFlag()}
            "set statusline=%#DiffAdd#
            "set statusline+=%f\
            "set statusline+=%#LineNr# "switch to colors used for line number
            "set statusline+=%{fugitive#statusline()}
            "set statusline+=%#DiffAdd# "switch back to normal
            "set statusline+=%= "left/right separator
            "set statusline+=%m "modified flag

            "display a warning if &paste is set
            "set statusline+=%#DiffChange#
            "set statusline+=%{&paste?'[paste]':''}
            "set statusline+=%#LineNr# "switch to colors used for line number
            "set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
            "set statusline+=%#DiffAdd# "switch to colors used for line number
            "set statusline+=%c: "cursor column
            "set statusline+=%l/%L "cursor line/total lines
            "set statusline+=\ %P "percent through file
            "set laststatus=2

            "return the syntax highlight group under the cursor ''
            "function! StatuslineCurrentHighlight()
                "let name = synIDattr(synID(line('.'),col('.'),1),'name')
                "if name == ''
                    "return ''
                "else
                    "return '[' . name . ']'
                "endif
            "endfunction
        endif
    " }}}

    " folding {{{
        " These commands open folds
        set foldmethod=syntax " folding by syntax
        "set foldclose=all " if curser out of fold, then close
        set foldcolumn=2 " set the column of the left side
        "set nofoldenable " folding isn't enabled
        "set foldmethod=marker " Fold on the marker
        set foldenable " Turn on folding
        set foldlevel=100 " Don't autofold anything (but I can still fold manually)
        "set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo,hor
        set foldopen=block,jump,mark,percent,quickfix,search,tag,undo,hor

        set foldtext=MyFoldLabel()
    " }}}
" }}}

" Formatting {{{
    set textwidth=120      " Set the textwidth to be 120 chars (if 0: screen_width)
    set wrapmargin=5
    set formatoptions=     " ta

    set expandtab          " Turn tabs into spaces
    set shiftwidth=2       " use indents of 2 spaces
    set tabstop=2
    set softtabstop=2      " for backspace in insert-mod

    " Format text width the external programm "par" . Use "gq" for the external program; or use "gw" for internal program of vim
    "set formatprg=par\ -re

    set linebreak
    set wrap               " wrap long lines

    set autoindent         " indent at the same level of the previous line
" }}}

" Key (re)Mappings {{{
    let mapleader=","

    " Don't use Ex mode, use Q for formatting
    map Q gq

    " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
    " so that you can undo CTRL-U after inserting a line break.
    inoremap <C-U> <C-G>u<C-U>

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    " Stupid shift key fixes
    "cmap W w
    "cmap WQ wq
    "cmap wQ wq
    "cmap Q q

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    command MkBackup :! cp % %.bak

    if filereadable(expand("~/.vim/mapping.vim"))
        source ~/.vim/mapping.vim
    endif
" }}}

" Plugins {{{

    " Ctags {{{
        set tags=./tags;/,~/.vimtags,./tags,tags
    " }}}

     " neocomplcache {{{
        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplcache.
        let g:neocomplcache_enable_at_startup = 1
        " Use smartcase.
        let g:neocomplcache_enable_smart_case = 1
        " Use camel case completion.
        let g:neocomplcache_enable_camel_case_completion = 1
        " Use underbar completion.
        let g:neocomplcache_enable_underbar_completion = 1
        " Set minimum syntax keyword length.
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_enable_auto_delimiter = 1

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
          let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " AutoComplPop like behavior.
        "let g:neocomplcache_enable_auto_select = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        let g:neocomplcache_disable_auto_complete = 1
        inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
        "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"


        " AutoComplPop like behavior.
        let g:neocomplcache_enable_auto_select = 0

        " SuperTab like snippets behavior.
        imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        " Plugin key-mappings.
        imap <C-k>     <Plug>(neocomplcache_snippets_expand)
        smap <C-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()


        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>"
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        "inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

     " }}}

     " Fugitive {{{
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> ,dg :diffget<CR>
        nnoremap <silent> ,dp :diffput<CR>
        "cmap Gbrowser Gbrowse | redraw!
     "}}}

     " TagBar {{{
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
        let g:tagbar_width = 30
        let g:tagbar_sort = 0
        let g:tagbar_compact = 1
        let g:tagbar_autoshowtag = 1
     "}}}

     " Session List {{{
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
     " }}}

    " xptemplate {{{
        " let g:xptemplate_key = '<Tab>'
        let g:xptemplate_always_show_pum = 1
        ":command -range=% SendDB :<line1>,<line2>w !mysql -udb11sa23 -pz51f8f4ca p001 -t
        "map <Tab> :Tabnext<cr>

        " Set personal snippet folder location:
        let g:xptemplate_snippet_folders=['$HOME/.vim/bundle/vim-xpt/personal']
        "
        " Turn off automatic closing of quotes and braces:
        let g:xptemplate_brace_complete = 0
        "
        " Snippet triggering key:
        "let g:xptemplate_key = '<F1>'
        "
        " Open the pop-up menu:
        let g:xptemplate_key_pum_only = '<Leader><Tab>'
        "
        " Clear current placeholder and jump to the next:
        imap <C-d> <Tab>
        let g:xptemplate_nav_cancel = '<C-d>'
        "
        " Move to the next placeholder in a snippet:
        let g:xptemplate_nav_next = '<Tab>'
        "
        " Go to the end of the current placeholder and in to insert mode:
        "
        " <C-_> is actually CONTROL-/ on my keyboard.
        "let g:xptemplate_to_right = '<C-\>'
        "
        " Move cursor back to last placeholder:
        let g:xptemplate_goback = '<C-g>'
        "
        " Use TAB/S-TAB to navigate through the pop-up menu:
        let g:xptemplate_pum_tab_nav = 1
        "
        " Reload xptemplate snippets without quitting vim.
        "nmap <A-F1> :XPTreload<CR>
    " }}}

    " EasyGrep {{{
        let g:EasyGrepFileAssociations='/home/dsiw/.vim/bundle/EasyGrep/plugin/EasyGrepFileAssociations'
        let g:EasyGrepMode=1
        let g:EasyGrepCommand=0
        let g:EasyGrepRecursive=0
        let g:EasyGrepIgnoreCase=1
        let g:EasyGrepHidden=0
        let g:EasyGrepSearchCurrentBufferDir=1
        let g:EasyGrepAllOptionsInExplorer=1
        let g:EasyGrepWindow=0
        let g:EasyGrepReplaceWindowMode=1
        let g:EasyGrepOpenWindowOnMatch=1
        let g:EasyGrepEveryMatch=1
        let g:EasyGrepJumpToMatch=1
        let g:EasyGrepInvertWholeWord=1
        let g:EasyGrepFileAssociationsInExplorer=1
        let g:EasyGrepExtraWarnings=1
        let g:EasyGrepOptionPrefix='<leader>vy'
        let g:EasyGrepReplaceAllPerFile=0
    " }}}

    " ATP {{{
        "nmap :makelatex :MakeLatex
        "nmap :viewoutput :ViewOutput
        let g:atp_Python = "/usr/bin/python2"
        let b:atp_Viewer = "evince"
    " }}}

    " Tabular {{{
        if exists(":Tabularize")
        nmap <Leader>t= :Tabularize /=<CR>
        vmap <Leader>t= :Tabularize /=<CR>
        nmap <Leader>t: :Tabularize /:\zs<CR>
        vmap <Leader>t: :Tabularize /:\zs<CR>
        endif
    " }}}

    " Align {{{
        inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
        function! s:align()
        let p = '^\s*|\s.*\s|\s*$'
        if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{{{-\}}}'.repeat('.',position),'ce',line('.'))
        endif
        endfunction
    " }}}

    " CTags {{{
        set tags=./tags;/,~/.vimtags
        " configure tags - add additional tags here or comment out not-used ones
        set tags+=~/.vim/tags/cpp
        " build tags of your own project with Ctrl-F12
        "map <F8> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
        "map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
        map <Leader>rt :!ctags -R *<CR><CR>
        map <C-\> :tnext<CR>
    " }}}

    " OmniComplete {{{
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest

        " OmniCppComplete {{{
            let OmniCpp_NamespaceSearch = 1
            let OmniCpp_GlobalScopeSearch = 1
            let OmniCpp_ShowAccess = 1
            let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
            let OmniCpp_MayCompleteDot = 1 " autocomplete after .
            let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
            let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
            let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
            " automatically open and close the popup menu / preview window
            au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
            set completeopt=menuone,menu,longest,preview
        " }}}
    " }}}

    " Checkist {{{
        au BufNewFile,BufRead *.chklst setf chklst
    " }}}

    " Gundo {{{
        nnoremap ,g :GundoToggle<CR>

        " open on the right so as not to compete with the nerdtree
        let g:gundo_right = 1

        " a little wider for wider screens
        let g:gundo_width = 50
    " }}}

    " Indent Guides {{{
        let g:indent_guides_auto_colors = 1
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
    " }}}

    " Ragtag {{{
        let g:ragtag_global_maps = 1
    " }}}

    " Taglist {{{
        if exists(":TlistToggle")
        noremap <silent> <F6> :TlistToggle<CR>
        inoremap <silent> <F6> <C-C>:TlistToggle<CR>
        endif
    " }}}

    " Lusty-Juggler {{{
        " http://www.vim.org/scripts/script.php?script_id=2050
        "nmap <silent> <Leader>b :LustyJuggler<CR>
    " }}}

    " FSwitch Settings {{{
        nmap <silent> ,of :FSHere<CR>
        nmap <silent> ,ol :FSRight<CR>
        nmap <silent> ,oL :FSSplitRight<CR>
        nmap <silent> ,oh :FSLeft<CR>
        nmap <silent> ,oH :FSSplitLeft<CR>
        nmap <silent> ,ok :FSAbove<CR>
        nmap <silent> ,oK :FSSplitAbove<CR>
        nmap <silent> ,oj :FSBelow<CR>
        nmap <silent> ,oJ :FSSplitBelow<CR>
    " }}}

    " NERD Tree  {{{
        " Toggle the NERD Tree on an off with F7
        nmap ,T :NERDTreeToggle<CR>

        " Close the NERD Tree with Shift-F7
        "nmap <S-F7> :NERDTreeClose<CR>

        " Store the bookmarks file in perforce
        let NERDTreeBookmarksFile="~/.vim/NERDTreeBookmarks"

        " Show the bookmarks table on startup
        "let NERDTreeShowBookmarks=1
        let NERDTreeShowBookmarks=0

        let NERDTreeChDirMode=2

        " Don't display these kinds of files
        let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
        \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
        \ '\.embed\.manifest$', '\.embed\.manifest.res$',
        \ '\.intermediate\.manifest$', '^mt.dep$', '\~$', '\.swp$' ]
        let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\~$']


        " Do not yiel about unknown filetypes.
        let NERDShutUp=1
    " }}}

    " MiniBufExplorer Plugin Settings {{{
        " Yup, I don't like this one either
        "let loaded_minibufexplorer = 1
        let g:miniBufExplMapWindowNavVim = 1
        let g:miniBufExplMapCTabSwitchBufs = 1
        let g:miniBufExplModSelTarget = 1
        let g:miniBufExplMapWindowNavArrows = 1
    " }}}

    " ShowMarks  {{{
        " I don't think I like this
        "let g:loaded_showmarks = 1
        let g:showmarks_enable = 0
    " }}}

    " ShowPairs {{{
        highlight ShowPairsHLp ctermfg=black ctermbg=white
        let g:showpairs_enable = 0
        let g:showpairs_pairs = "(:),{{{:}}},[:]"
    " }}}

    " SnipMate {{{
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        "let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
        "let g:snips_trigger_key='<c-space>'
        " Shortcut for reloading snippets, useful when developing
        nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
    " }}}

    " Source Explorer Plugin Settings {{{
        " The switch of the Source Explorer
        " nmap <silent> <F8> :SrcExplToggle<CR>

        " Set the height of Source Explorer window
        let g:SrcExpl_winHeight = 16

        " Set 10 ms for refreshing the Source Explorer
        let g:SrcExpl_refreshTime = 10

        " In order to Avoid conflicts, the Source Explorer should know what plugins
        " are using buffers. And you need add their bufname into the list below
        " according to the command ":buffers!"
        let g:SrcExpl_pluginList = [
        \ "_NERD_tree_",
        \ "Source_Explorer"
        \ ]
        " Enable/Disable the local definition searching, and note that this is not
        " guaranteed to work, the Source Explorer doesn't check the syntax for now.
        " It only searches for a match with the keyword according to command 'gd'
        let g:SrcExpl_searchLocalDef = 1

        " Do not let the Source Explorer update the tags file when opening
        let g:SrcExpl_isUpdateTags = 0

        " Use program 'ctags' with argument '--sort=foldcase -R' to create or
        " update a tags file
        let g:SrcExpl_updateTagsCmd = "retag.ksh"

        " Set "<F9>" key for updating the tags file artificially
        let g:SrcExpl_updateTagsKey = "<F9>"
    " }}}

    " FuzzyFinder Settings {{{
        "nmap ,fb :FuzzyFinderBuffer<CR>
        "nmap ,ff :FuzzyFinderFile<CR>
        "nmap ,ft :FuzzyFinderTag<CR>
    " }}}

    " Unimpaired {{{
        " Bubble single lines
        nmap <C-Up> [e
        nmap <C-Down> ]e
        " Bubble multiple lines
        vmap <C-Up> [egv
        vmap <C-Down> ]egv
    " }}}

    " Tlist {{{
        let Tlist_Ctags_Cmd = "/usr/bin/ctags" " The packge 'ctags' have to be installed!
        let Tlist_GainFocus_On_ToggleOpen = 1
        let Tlist_Close_On_Select = 1
    " }}}

    " jcommenter {{{
        "autocmd FileType java source $VIM/macros/jcommenter.vim
        autocmd FileType java map <M-c> :call JCommentWriter()<CR>  " Alt-C
        let g:vjde_completion_key='<c-space>'
    " }}}

    " XMLFolding {{{
        au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/bundle/vim-xmlfolding/plugin/XMLFolding.vim
    " }}}

    " SuperTab {{{
        let g:SuperTabDefaultCompletionType = "context"
    " }}}

    " VimDebug {{{
        if exists(":DBGRstart")
            map <F12>      :DBGRstart<CR>
            map <Leader>s/ :DBGRstart

            map <F7>       :call DBGRstep()<CR>
            map <F8>       :call DBGRnext()<CR>
            map <F9>       :call DBGRcont()<CR>                   " continue

            map <Leader>b  :call DBGRsetBreakPoint()<CR>
            map <Leader>c  :call DBGRclearBreakPoint()<CR>
            map <Leader>ca :call DBGRclearAllBreakPoints()<CR>

            map <Leader>v/ :DBGRprint
            map <Leader>v  :DBGRprintExpand expand("<cWORD>")<CR> " print value under the cursor

            map <Leader>/  :DBGRcommand

            map <F10>      :call DBGRrestart()<CR>
            map <F11>      :call DBGRquit()<CR>
        endif
    " }}}

    " Surround {{{
        " via: http://whynotwiki.com/Vim
        " via: https://github.com/skwp/dotfiles/blob/master/vim/plugin/settings/surround.vim
        " Ruby
        " Use v or # to get a variable interpolation (inside of a string)}
        " ysiw# Wrap the token under the cursor in #{}
        " v...s# Wrap the selection in #{}
        au Filetype ruby let g:surround_113 = "#{\r}" " v
        au Filetype ruby let g:surround_35 = "#{\r}" " #

        " Select text in an ERb file with visual mode and then press s- or s=
        " Or yss- to do entire line.
        au Filetype erb let g:surround_45 = "<% \r %>" " -
        au Filetype erb let g:surround_61 = "<%= \r %>" " =
    " }}}

    " Sudo {{{
        " Write a file as sudo
        command Wsudo :w sudo:%
    " }}}

    " SplitJoin {{{
        nmap sj :SplitjoinSplit<cr>
        nmap sk :SplitjoinJoin<cr>
    " }}}

    " Powerline {{{
        let g:Powerline_symbols = 'fancy'
        "let g:Powerline_symbols_override = { 'BRANCH': [0x2213], 'LINE': 'L', }
        "let g:Powerline_theme='skwp'
        "let g:Powerline_colorscheme='skwp'
    " }}}

    " DelimitMate {{{
        let g:delimitMate_excluded_ft = "mail,txt"
        let delimitMate_autoclose = 1
        let delimitMate_expand_space = 1
        let delimitMate_balance_matchpairs = 1
        let delimitMate_quotes = "\" ' `"
        let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
        au FileType ruby let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }}}

    " YankRing {{{
        "let g:yankring_enabled = 0  " Disables the yankring
        let g:yankring_max_history = 100
        let g:yankring_window_use_horiz = 0  " Use vertical split
        let g:yankring_window_use_right = 1
        let g:yankring_history_dir = '~/.vim/'
        let g:yankring_history_file = 'yankring_history'
    " }}}

    " VRoom {{{
        let g:vroom_cucumber_path = 'cucumber '
    " }}}

    " Syntastic {{{
    let g:syntastic_mode_map = { 'mode': 'passive',
                               \ 'active_filetypes': [],
                               \ 'passive_filetypes': ['ruby'] }
    " }}}
" }}}

" GUI Settings {{{
    " Set up the window colors and size
    if has("gui_running")
      set bg=dark
      "set guifont=Monaco:h12
      set guioptions-=T
      "colorscheme xoria256
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
" }}}

" Functions {{{
    " Auto commands {{{
        augroup Binary "{{{
            au!
            au BufReadPre   *.bin let &bin=1
            au BufReadPost  *.bin if &bin | %!xxd
            au BufReadPost  *.bin set filetype=xxd | endif
            au BufWritePre  *.bin if &bin | %!xxd -r
            au BufWritePre  *.bin endif
            au BufWritePost *.bin if &bin | %!xxd
            au BufWritePost *.bin set nomod | endif
        augroup END
        "}}}
        augroup Mail "{{{
            au!
            autocmd BufNewFile,BufRead *.mail set filetype=mail
            autocmd BufNewFile,BufRead ~/.mutt/* set filetype=muttrc
            autocmd BufNewFile,BufRead *msmtp* set filetype=msmtp
        augroup END
        "}}}
        augroup Coffee "{{{
            au!
            au BufNewFile,BufRead *.coffee set filetype=coffee
            au BufNewFile,BufRead *.coffee setl foldmethod=indent
            au Filetype coffee setl foldmethod=indent nofoldenable
            au Filetype coffee setl shiftwidth=2 expandtab
        augroup END
        "}}}
        augroup Shebang "{{{
            au!
            au BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># encoding: utf-8\<nl>\"|$
            au BufNewFile *.sh 0put =\"#!/bin/bash\<nl>\"|$
            au BufNewFile *.pl 0put =\"#!/usr/bin/env perl\<nl>\"|$
            autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
            autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
        augroup END
        "}}}
        augroup Executable "{{{
            " automatically give executable permissions if file begins with #! and contains '/bin/' in the path
            au!
            au BufWritePost * call MakeExecutable()
        augroup END
        "}}}

        " Source the vimrc file after saving it
        "au Bufwritepost vimrc source $MYVIMRC

        " Treat .rss files as XML
        au BufNewFile,BufRead *.rss,*.atom set filetype=xml
        au BufNewFile,BufRead *.asm,*.ASM,*.s,*.S source $VIM/syntax/gasm.vim
        au BufNewFile,BufRead *.ldif set filetype=ldif

        au BufWritePost *.c :make
        au BufWritePost *.snippet call ReloadAllSnippets()
        au BufReadPost fugitive://* set bufhidden=delete

        " Syntax of these languages is fussy over tabs Vs spaces

        augroup Markdown "{{{
            au!
            " Markdown
            "au Filetype markdown setlocal foldexpr=MarkdownLevel()
            "au Filetype markdown setlocal foldmethod=expr
            au BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown | set ts=4 sts=4 sw=4 expandtab
            au FileType markdown syn region myMkdHeaderFold
                        \ start="\v^\s*\z(\#{1,6})"
                        \ end="\v\n(\s*\#)\@="ms=s-1,me=s-1
                        \ skip="\v(\n\s*\z1\#)\@="
                        \ fold contains=myMkdHeaderFold

            au FileType markdown syn sync fromstart
            au FileType markdown set foldmethod=syntax
            au FileType markdown set fo+=t
        augroup END
        "}}}

        augroup Octopress "{{{
            " Octopress
            autocmd BufNewFile,BufRead *.op,*.octopress setlocal filetype=octopress | set ts=4 sts=4 sw=4 expandtab
            au FileType octopress syn region myMkdHeaderFold
                        \ start="\v^\s*\z(\#{1,6})"
                        \ end="\v\n(\s*\#)\@="ms=s-1,me=s-1
                        \ skip="\v(\n\s*\z1\#)\@="
                        \ fold contains=myMkdHeaderFold
                        \ transparent fold

            au FileType octopress syn sync fromstart
            au FileType octopress set foldmethod=syntax
            "au FileType octopress set syntax enable
            au FileType octopress set fo+=t
        augroup END
        "}}}

        au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

        " Customisations based on house-style (arbitrary)
        au FileType html       setlocal ts=2 sts=2 sw=2 expandtab
        au FileType css        setlocal ts=2 sts=2 sw=2 expandtab
        au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
        au FileType python     setlocal ts=2 sts=2 sw=2 expandtab

        " Omni Completion
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS

        au BufNewFile,BufRead Guardfile set filetype=ruby
    " }}}

    " Clean whitespace at EOL {{{
        function TrimWhiteSpace()
            %s/\s\+$//e
        endfunction
        nmap <silent> <leader>rtw <ESC>:call TrimWhiteSpace()<CR>
    " }}}

    " Set up spell function {{{
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
    " }}}

    " Periodically save of the current buffer {{{
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
    " }}}

    " Open URL in current line with web browser  {{{
        "function! myopenBrowser()
        "let line0 = getline(".")
        "let line = matchstr(line0, "http[^ ]*")
        "if line=="" | let line = matchstr(line0, "ftp[^ ]*")  | endif
        "if line=="" | let line = matchstr(line0, "file[^ ]*") | endif
        "let line = escape(line, "#?&;|%")
        "exec '!firefox '.line
        "endfunction
    " }}}

    " Get level of markdown headers {{{
        function! MarkdownLevel()
            if getline(v:lnum) =~ '^# .*$'
                return ">1"
            endif
            if getline(v:lnum) =~ '^## .*$'
                return ">1"
            endif
            if getline(v:lnum) =~ '^### .*$'
                return ">2"
            endif
            if getline(v:lnum) =~ '^#### .*$'
                return ">3"
            endif
            if getline(v:lnum) =~ '^##### .*$'
                return ">4"
            endif
            if getline(v:lnum) =~ '^###### .*$'
                return ">5"
            endif
            return "="
        endfunction
    "}}}

    " Make executable {{{
    " automatically give executable permissions if file begins with #! and contains '/bin/' in the path
        function! MakeExecutable()
            if getline(1) =~ "^#!.*/bin/"
                silent !chmod a+x <afile>
            endif
        endfunction
    " }}}

    " Foldtext {{{
        function! MyFoldLabel()
            let getcontent = substitute(getline(v:foldstart), "^[[:space:]]*", "", 'g')
            let linestart = substitute(v:folddashes, ".", '»', 'g')
            return linestart . " " . getcontent
        endfunction
    " }}}

" Programming {{{
    set cin         " C code ident

    " Let the syntax highlighting for Java files allow cpp keywords
    let java_allow_cpp_keywords = 1
" }}}

" Sources {{{
    " vimspell: http://www.vim.org/scripts/script.php?script_id=465
    if filereadable(expand("~/.vim/abbrev.vim"))
        source ~/.vim/abbrev.vim
    endif
    if filereadable(expand("~/.vim/private.vim"))
        source ~/.vim/private.vim
    endif
" }}}

" Use local vimrc if available {{{
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }}}

" Use local gvimrc if available and gui is running {{{
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }}}
