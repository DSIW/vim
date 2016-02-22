" Modeline and Notes {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker tabstop=4 shiftwidth=4:
"
" I have the categories of this from Steve Francia (see http://spf13.com)
" }}}

" Environment {{{
    " Basics {{{
        set nocompatible    " must be first line
        set ttyfast         " we have a fast tty
    " }}}
" }}}

" Plugins {{{
    call plug#begin('~/.vim/plugged')

    " General {{{
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        "Plug 'unicode.vim'
        Plug 'unimpaired.vim'
        Plug 'lastpos.vim'
        "Plug 'sudo.vim' " eunuch has same function
        "Plug 'vimshell-ssh'
        " Plug 'The-NERD-tree'
        Plug 'ctrlp.vim'
        "Plug 'SearchComplete'
        " Plug 'EasyGrep'
        "Plug 'hexman.vim'
        "Plug 'taglist.vim'
        "Plug 'tpope/vim-speeddating.git'
        "Plug 'trailing-whitespace'
        Plug 'tpope/vim-repeat'
        "Plug 'recover.vim'
        Plug 'rking/ag.vim'
        "Plug 'greplace.vim'
        Plug 'Rykka/lastbuf.vim'
        " open vim with file:42 to open at line 42
        Plug 'bogado/file-line'
        Plug 'arecarn/crunch' | Plug 'arecarn/selection.vim'
        Plug 'gioele/vim-autoswap'
        Plug 'DavidGamba/vim-vmath'
        " Plug 'Yggdroot/hiPairs'
        Plug 'zirrostig/vim-schlepp'
        " Plug 'atweiden/vim-betterdigraphs'

        Plug 'VisIncr'
        "Plug 'csv.vim'
        "Plug 'xolox/vim-session'
        " Plug 'delimitMate.vim'
        Plug 'majutsushi/tagbar'
        " Plug 'mndrix/prolog.vim'
        " Plug 'EasyMotion'
        Plug 'AndrewRadev/sideways.vim'
        "Plug 'mhinz/vim-signify'
        Plug 'AndrewRadev/switch.vim'
        Plug 'tpope/vim-eunuch'
        " Plug 'mutewinter/UnconditionalPaste'
        "Plug 'paradigm/vim-multicursor'
        " Plug 'hlissner/vim-multiedit'
        "Plug 'sjl/splice.vim'
        "Plug 'christoomey/vim-space'
        "Plug 'vim-scripts/LineJuggler'
        "Plug 'rainerborene/vim-timetap'
        "Plug 'mhinz/vim-startify'
        Plug 'aklt/vim-substitute'
        "Plug 'myusuf3/numbers.vim'
        Plug 'mbbill/undotree', { 'on': 'UndoTreeToggle' }
        " Plug 'osyo-manga/vim-over'
        " Plug 'tpope/vim-characterize'
        " Plug 'tpope/vim-flatfoot'
        " Plug 'tommcdo/vim-exchange'
        " Plug 'ledger/vim-ledger'
        Plug 'vim-scripts/LanguageTool', { 'for': 'txt' }
    " }}}

    " UI {{{
        "Plug 'spf13/vim-colors'
        "Plug 'flazz/vim-colorschemes'
        "Plug 'tomasr/molokai'
        "Plug 'xoria256.vim'
        "Plug 'neverland.vim--All-colorschemes-suck'
        " Plug 'ZoomWin'
        Plug 'altercation/vim-colors-solarized'
        " Plug 'chriskempson/base16-vim'
        Plug 'bufkill.vim'
        " Plug 'croaky/vim-colors-github'
        Plug 'junegunn/limelight.vim', { 'for': 'txt' }
    " }}}

    " Programming {{{
        "Plug 'xptemplate'
        Plug 'godlygeek/tabular'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-dispatch'
        Plug 'Keithbsmiley/investigate.vim'
        "Plug 'ProtoDef'
        "Plug 'SuperTab'
        "Plug 'Indent-Guides'
        "Plug 'VimDebug'
        Plug 'camelcasemotion'
        "Plug 'Syntastic'
        "Plug 'Shougo/neocomplcache'
        " Plug 'tpope/vim-abolish'
        "Plug 'jshint.vim'
        " Plug 'derekwyatt/vim-scala'
        " Plug 'airblade/vim-rooter'


        " Plug 'Valloric/YouCompleteMe'

        " Snippets {{{
            Plug 'tomtom/tlib_vim'
            Plug 'MarcWeber/vim-addon-mw-utils'
            Plug 'sirver/UltiSnips' | Plug 'honza/vim-snippets'
        "}}}

        " C/C++ {{{
            "Plug 'c.vim'
            "Plug 'FSwitch'
        "}}}

        " Crystal {{{
            Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
        " }}}

        " Ruby {{{
            Plug 'vim-ruby/vim-ruby', { 'for': ['ruby','jruby'] }
            Plug 'ecomba/vim-ruby-refactoring'
            " Plug 'skalnik/vim-vroom'
            Plug 'splitjoin.vim', { 'for': ['ruby','jruby'] }
            " Plug 'skwp/vim-rspec'
            " Plug 'thoughtbot/vim-rspec'
            "Plug 'rson/vim-conque'
            "Plug 'skwp/vim-ruby-conque'
            Plug 'tpope/vim-rails'
            "Plug 'kchmck/vim-coffee-script'
            Plug 'tpope/vim-haml', { 'for': 'haml' }
            Plug 'tpope/vim-bundler'
            Plug 'tpope/vim-rake'
            Plug 'henrik/vim-ruby-runner', { 'for': 'ruby' }
        "}}}

        " Java {{{
            "Plug 'cespare/vjde.git'
            "Plug 'javacomplete'
            "Plug 'ervandew/eclim.git'
        "}}}

        " Python {{{
            "Plug 'pep8'
            "Plug 'mitechie/pyflakes-pathogen.git'
            "Plug 'fs111/pydoc.vim.git'
            " Plug 'cwood/vim-django'
            " Plug 'jmcomets/vim-pony'
            " Plug 'jmcantrell/vim-virtualenv'
        "}}}

        " JavaScript {{{
            "Plug 'javascript.vim'
            Plug 'vim-json-bundle', { 'for': ['json','js'] }
            " JSON manipulation
            " Plug 'tpope/vim-jdaddy'
            "Plug 'vim-coffee-script'
            Plug 'pangloss/vim-javascript', { 'for': 'js' }
        "}}}
    " }}}

    " Textobjects {{{
        " Plug 'kana/vim-textobj-user.git'
        " r
        " Plug 'textobj-rubyblock' | Plug 'textobj-user'
        " f
        " ERROR: Plug 'textobj-function'
        " e
        " Plug 'textobj-entire'
        " i/I
        " Plug 'textobj-indent'
        " z
        " Plug 'textobj-fold'
        " d...
        "Plug 'textobj-datetime'
        " a
        Plug 'argtextobj.vim'
        " `
        " Plug 'vim-textobj-quoted'
        " :
        " Plug 'bootleq/vim-textobj-rubysymbol'
        " v
        " Plug 'Julian/vim-textobj-variable-segment'
    "}}}

    " Mail {{{
        "Plug 'CheckAttach.vim'
    " }}}

    " Git {{{
        "Plug 'git.zip'
        Plug 'tpope/vim-fugitive'
        "Plug 'mattn/webapi-vim'
        "Plug 'Gist.vim'
        " Plug 'gregsexton/gitv'
        "Plug 'airblade/vim-gitgutter'
    " }}}

    " Sourround {{{
        Plug 'surround.vim'
        "Plug 'delete-surround-html'
    " }}}

    " Web {{{
        "Plug 'XML-Folding'
        "Plug 'xmledit'
        "Plug 'Haml'
        "Plug 'rstacruz/sparkup'
        "Plug 'ragtag.vim'

        " Dependency for rubyblock text object
        " Plug 'edsono/vim-matchit'

        "Plug 'vim-octopress'
        "Plug 'tsaleh/vim-align'

        " Markdown {{{
            "Plug 'tpope/vim-markdown'
            Plug 'plasticboy/vim-markdown'
            "Plug 'Markdown-syntax'
        "}}}

        " CSS {{{
            "Plug 'groenewege/vim-less'
            "Plug 'cakebaker/scss-syntax'
            "Plug 'skammer/vim-css-color'
            "Plug 'hail2u/vim-css3-syntax'
        "}}}
    " }}}

    " LaTeX {{{
        "Plug 'dnebauer/AutomaticLaTeXPlugin.git'
    "}}}

    " CSS {{{
        "Plug 'groenewege/vim-less'
        "Plug 'cakebaker/scss-syntax'
        "Plug 'skammer/vim-css-color'
    "}}}

    " errors {{{
        "Plug 'Align.vim' " ERROR
        "Plug 'checklist.vim' " ERROR
        "Plug 'css_color.vim' " CPU raises up
        "Plug 'vim-recovery' " NOT FOUND
        "Plug 'minibufexpl.vim' ERROR with plugin "fugitive in diff mode"

        "Plug 'endwise.vim'
        " ERROR with "pumvisible"

        "Plug 'Solarized' " ERROR with comments (background is too dark)
    " }}}

    " Add plugins to &runtimepath
    call plug#end()
" }}}

" General {{{
    " Set filetype stuff to on
    filetype on
    filetype plugin on
    filetype indent on

    set ffs=unix ",dos " sets line end to UNIX

    set sh=zsh " Set shell

    syntax on " Switch on syntax highlighting.

    " Make the 'cw' and like commands put a $ at the end instead of just deleting
    " the text and replacing it
    set cpoptions+=c$

    set history=1000 " Keep some stuff in the history

    set mousehide " Hide the mouse pointer while typing

    set autowrite    " e.g. before :make
    set noautochdir  " auto change dir of file
    set autoread

    set vb " set visual bell -- i hate that damned beeping

    " Allow the cursor to go in to "invalid" places
    set virtualedit=all

    " Disable encryption (:X)
    " set key=

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
    "set diffopt+=iwhite
    set diffopt+=vertical

    " These things start comment lines
    set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:-

    " Same as default except that I remove the 'u' option
    set complete=.,w,b,t,i
    set completeopt=menu,preview

    " When completing by tag, show the whole tag, not just the function name
    set showfulltag

    " set clipboard=unnamed

    set splitright
    set splitbelow

    " get rid of the silly characters in window separators
    set fillchars=""

    " Don't reset cursor to start of line when moving around.
    set nostartofline

    " Search {{{
        set nohlsearch " Enable search highlighting

        set incsearch " Incrementally match the search

        set wrapscan " set the search scan to wrap lines

        " set the search scan so that it ignores case when the search is all lower
        " case but recognizes uppercase if it's specified
        set ignorecase
        set smartcase

        " Use ag over grep
        set grepprg=ag\ --nogroup\ --nocolor
    " }}}

    " Insert only one space when joining lines that contain sentence-terminating
    " punctuation like `.`.
    set nojoinspaces

    " For regular expressions turn magic on
    set magic

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
        endif
    " }}}

    " Could use * rather than *.*, but I prefer to leave .files unsaved
    " au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
    " au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)

    " Backup {{{
        " Save your backups to a less annoying place than the current directory.
        " If you have .vim-backup in the current directory, it'll use that.
        " Otherwise it saves it to ~/.vim/backup or . if all else fails.
        if isdirectory($HOME . '/.vim/.tmp/backup') == 0
          :silent !mkdir -p ~/.vim/.tmp/backup >/dev/null 2>&1
        endif
        set backupdir=~/.vim/.tmp/backup/
        set backupdir+=~/.vim/backup/
        set backupdir+=~/.vim/tmp/
        set backupdir+=.
        set backup
        " Prevent backups from overwriting each other. The naming is weird,
        " since I'm using the 'backupext' variable to append the path.
        " So the file '/home/docwhat/.vimrc' becomes '.vimrc%home%docwhat~'
        if has("autocmd")
          autocmd BufWritePre * let &backupext = substitute(expand('%:p:h'), '/', '%', 'g') . '~'
        endif
    " }}}

    " Swap {{{
        " Save your swp files to a less annoying place than the current directory.
        " If you have .vim-swap in the current directory, it'll use that.
        " Otherwise it saves it to ~/.vim/swap, ~/tmp or .
        if isdirectory($HOME . '/.vim/.tmp/swap') == 0
          :silent !mkdir -p ~/.vim/.tmp/swap >/dev/null 2>&1
        endif
        set directory=./.vim-swap//
        set directory+=~/.vim/.tmp/swap//
        set directory+=~/.vim/swap//
        set directory+=.
    " }}}

    " Session {{{
        " viminfo stores the state of your previous editing session
        set sessionoptions=blank,curdir,folds,help,tabpages,winpos
        "           +--Disable hlsearch while loading viminfo
        "           | +--Remember marks for last 500 files
        "           | |    +--Remember up to 10000 lines in each register
        "           | |    |      +--Remember up to 1MB in each register
        "           | |    |      |     +--Remember last 1000 search patterns
        "           | |    |      |     |     +---Remember last 1000 commands
        "           | |    |      |     |     |
        "           v v    v      v     v     v
        " set viminfo=h,'500,<10000,s1000,/1000,:1000
        " set viminfo+=n~/.vim/.tmp/viminfo
    " }}}

    " View {{{
        set viewdir=~/.vim/.tmp/view
    " }}}

    " Undo {{{
        if has('persistent_undo')
            set undofile                "so is persistent undo ...
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif

        if exists("+undofile")
          " undofile - This allows you to use undos after exiting and restarting
          " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
          " :help undo-persistence
          " This is only present in 7.3+
          if isdirectory($HOME . '/.vim/.tmp/undo') == 0
            :silent !mkdir -p ~/.vim/.tmp/undo > /dev/null 2>&1
          endif
          set undodir=./.vim-undo//
          set undodir+=~/.vim/.tmp/undo//
          set undodir+=~/.vim/undo//
          set undofile
        endif
    " }}}
" }}}

" Vim UI {{{
    set nu " Set linenumbers
    " set relativenumber

    " solarized {{{
        hi IndentGuidesOdd  ctermbg=black
        hi IndentGuidesEven ctermbg=darkgrey
        "hi IndentGuidesOdd  ctermbg=white
        "hi IndentGuidesEven ctermbg=lightgrey
        "color xoria256
        set background=light
        colorscheme solarized                 " load a colorscheme
        let g:solarized_termtrans=0
        let g:solarized_termcolors=256
        let g:solarized_contrast="high"
        let g:solarized_visibility="low"
        let g:solarized_italic=1
        let g:solarized_bold=1
        let g:solarized_diffmode="high"
        let g:solarized_hitrail=1
        let g:solarized_underline=0
        set t_Co=256
    " }}}
    set showmode " Show the current mode
    " set showbreak=↪

    " highlight {{{
        " highlight matching parens:
        " Default for matchpairs: (:),[:],{{{:}}},<:>
        set matchpairs+=<:>
        highlight MatchParen term=reverse ctermbg=7 guibg=cornsilk

        " I like it when the matching parens are automatically highlighted
        let loaded_matchparen = 0

        set matchtime=3
        " Turn on: showmatching brackets
        set showmatch
    " }}}

    " tell VIM to always put a status line in, even if there is only one window
    set laststatus=2

    set ch=2 " Make command line two lines high

    set cursorline
    set hidden  " allow buffer switching without saving

    set wildmenu " Make the command-line completion better
    set wildmode=longest,list:longest  " command <Tab> completion, list matches, then longest common part, then all.
    set wildignore=*.o,*.obj,*~,*.swp
    " Ignore case on insert completion
    set infercase

    set lazyredraw " Don't update the display while executing macros

    set updatecount=10 "Save buffer every 10 chars typed

    set winminheight=0 " windows can be 0 line high

    " Syntax coloring lines that are too long just slows down the world
    set synmaxcol=300

    set list
    set listchars=tab:▸\ ,trail:·,extends:#,nbsp:· ",eol:¬ " Highlight problematic whitespace: ﹁

    set scrolloff=8                 " minimum lines to keep above and below cursor
    set scrolljump=5                " lines to scroll when cursor leaves screen

    " Prevent Vim from clobbering the scrollback buffer. See
    " http://www.shallowsky.com/linux/noaltscreen.html
    set t_ti= t_te=

    if has('cmdline_info')
      "set ruler                   " show the ruler
      "set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
      set showcmd                 " show partial commands in status line and
      " selected characters/lines in visual mode
    endif

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
        "set timeout timeoutlen=500 ttimeoutlen=100

        " Improve the speed for updating the status line when leaving insert mode.
        set timeout
        set ttimeoutlen=10
        augroup FastEscape
            autocmd!
            set timeoutlen=400 ttimeoutlen=100
            au InsertEnter * set timeoutlen=0
            au InsertLeave * set timeoutlen=1000
            au InsertLeave * set timeout timeoutlen=400 ttimeoutlen=100
        augroup END
    " }}}

    " folding {{{
        " These commands open folds
        set foldmethod=syntax " folding by syntax
        "set foldclose=all " if curser out of fold, then close
        set foldcolumn=2 " set the column of the left side
        "set nofoldenable " folding isn't enabled
        "set foldmethod=marker " Fold on the marker
        set nofoldenable " Turn folding off
        set foldlevel=30 " Don't autofold anything (but I can still fold manually)
        "set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo,hor
        set foldopen=block,jump,mark,percent,quickfix,search,tag,undo,hor

        set foldtext=MyFoldLabel()
    " }}}

    " Don't show the intro message when starting vim.
    set shortmess=atI
" }}}

" Formatting {{{
    set textwidth=120      " Set the textwidth to be 120 chars (if 0: screen_width)
    set wrapmargin=5
    set formatoptions=     " ta

    set expandtab          " Turn tabs into spaces
    set shiftwidth=2       " use indents of 2 spaces
    set tabstop=2
    set softtabstop=2      " for backspace in insert-mod
    set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

    " Format text width the external programm "par" . Use "gq" for the external program; or use "gw" for internal program of vim
    "set formatprg=par\ -re

    set linebreak
    set wrap               " wrap long lines
    set whichwrap=b,s,h,l,<,>,[,] " move freely between files

    set autoindent         " indent at the same level of the previous line
    set copyindent

    " Highlight VCS conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" }}}

" Key (re)Mappings {{{
    let mapleader=","

    " Use Caps-Lock as ESC key
    exec "silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"

    if filereadable(expand("~/.vim/mapping.vim"))
        source ~/.vim/mapping.vim
    endif
" }}}

" Plugins {{{

    " Ctags {{{
        set tags=./tags;/,~/.vimtags,./tags,tags
    " }}}

    " Fugitive {{{
        fun! MyGstatus()
            Gstatus | wincmd K | resize 15
        endf
        nnoremap <silent> <leader>gs :call MyGstatus()<CR>

        nnoremap <silent> <leader>gd :Gdiff<CR>
        fun! GdiffCached()
            split | wincmd K | resize 15
            Git! diff --cached
        endf
        command! GdiffCached call GdiffCached()
        nnoremap <silent> <leader>gdc :call GdiffCached()<CR>

        fun! Gadd()
            silent !git add %
            echo "Added to Git"
        endf
        command! Gadd call Gadd()
        nnoremap <silent> <leader>ga :call Gadd()<CR>

        nnoremap <silent> <leader>gi :Gcommit<CR>
        nnoremap <leader>gC :update<cr>:Gcommit -am ""<left>
        nnoremap <leader>gc :update<cr>:Gcommit -m ""<left>

        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>:sleep 1<CR>
        nnoremap <silent> <leader>gu :Git pull<CR>
        "cmap Gbrowser Gbrowse | redraw!
    "}}}

    " TagBar {{{
        nnoremap <silent> <leader>T :TagbarToggle<CR>
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
        let g:tagbar_width = 30
        let g:tagbar_sort = 0
        let g:tagbar_compact = 1
        "let g:tagbar_autoshowtag = 1
        let g:tagbar_type_javascript = {}
                    "\ 'ctagstype' : 'javascript',
                    "\ 'ctagsbin' : '/usr/bin/jsctags'
                    "\ }
    "}}}

    " EasyGrep {{{
        " let g:EasyGrepFileAssociations=expand("~/.vim/bundle/EasyGrep/plugin/EasyGrepFileAssociations")
        " let g:EasyGrepMode=1
        " let g:EasyGrepCommand=0
        " let g:EasyGrepRecursive=0
        " let g:EasyGrepIgnoreCase=1
        " let g:EasyGrepHidden=0
        " let g:EasyGrepSearchCurrentBufferDir=1
        " let g:EasyGrepAllOptionsInExplorer=1
        " let g:EasyGrepWindow=0
        " let g:EasyGrepReplaceWindowMode=1
        " let g:EasyGrepOpenWindowOnMatch=0
        " let g:EasyGrepEveryMatch=1
        " let g:EasyGrepJumpToMatch=1
        " let g:EasyGrepInvertWholeWord=1
        " let g:EasyGrepFileAssociationsInExplorer=1
        " let g:EasyGrepExtraWarnings=1
        " let g:EasyGrepOptionPrefix='<leader>vy'
        " let g:EasyGrepReplaceAllPerFile=0
    " }}}

    " Substitute {{{
        let g:substitute_PromptMap = "<leader>sw"
        let g:substitute_NoPromptMap = "<leader>Sw"
        "let g:substitute_GlobalMap = "<leader>sg"
        "let g:substitute_SingleWordSize = 3
    " }}}

    " ATP {{{
        "nmap :makelatex :MakeLatex
        "nmap :viewoutput :ViewOutput
        let g:atp_Python = "/usr/bin/python2"
        let b:atp_Viewer = "evince"
    " }}}

    " Tabular {{{
        "if exists(":Tabularize")
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:\zs<CR>
        vmap <Leader>a: :Tabularize /:\zs<CR>
        "endif
    " }}}

    " UndoTree {{{
        nnoremap <silent> <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=0
        let g:undotree_DiffAutoOpen=0
        let g:undotree_WindowLayout="4" " right
        let g:undotree_SplitWidth=35
    " }}}

    " Taglist {{{
        " if exists(":TlistToggle")
        "     let Tlist_Ctags_Cmd = "/usr/bin/ctags" " The packge 'ctags' have to be installed!
        "     let Tlist_GainFocus_On_ToggleOpen = 1
        "     let Tlist_Close_On_Select = 1

        "     noremap <silent> <F6> :TlistToggle<CR>
        "     inoremap <silent> <F6> <C-C>:TlistToggle<CR>
        " endif
    " }}}

    " CtrlP  {{{
        nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
        nnoremap <silent> <Leader>a :CtrlPMixed<CR>
        nnoremap <silent> <Leader>m :CtrlPMRUFiles<CR>

        let g:ctrlp_map = '<leader>f'
        let g:ctrlp_show_hidden = 1 " show hidden files
        let g:ctrlp_max_height = 20 " height of file list
        let g:ctrlp_match_window_bottom = 0 " Show list on top
        let g:ctrlp_match_window_reversed = 0 " Go to bottom
        let g:ctrlp_mruf_default_order = 1
        let g:ctrlp_by_filename = 0 " Search only by filename
        let g:ctrlp_max_files = 300 " Max files to scan
        let g:ctrlp_max_depth = 50 " Max directory tree depth
        let g:ctrlp_switch_buffer = 0 " Allow opening mutlipe splits with same file via CtrlP
        let g:ctrlp_jump_to_buffer = 0
        "let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        let g:ctrlp_use_caching = 0
        "TODO
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|vendor)$',
            \ }
        " Don't let ctrlp change the working directory. Instead it now uses
        " the directory where vim was started. This fixes issues with some
        " projects that have nested git directories.
        let g:ctrlp_working_path_mode = 'r'
    " }}}

    " SnipMate {{{
        " Shortcut for reloading snippets, useful when developing
        au BufWritePost *.snippet call ReloadAllSnippets()
    " }}}

    " Unimpaired {{{
        " Bubble single lines
        " nmap <C-Up> [e
        " nmap <C-Down> ]e
        " Bubble multiple lines
        " vmap <C-Up> [egv
        " vmap <C-Down> ]egv
        " Overwrite useless mapping for next/prev method
        nmap [f [m
        nmap 8f [m
        nmap ]f ]m
        nmap 9f ]m
    " }}}

    " XMLFolding {{{
        " au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/bundle/vim-xmlfolding/plugin/XMLFolding.vim
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

    " SplitJoin {{{
        nmap sj :SplitjoinSplit<cr>
        nmap sk :SplitjoinJoin<cr>
    " }}}

    " Airline {{{
        let g:airline_theme='solarized'
        " let g:bufferline_echo = 0
        let g:airline#extensions#bufferline#enabled = 0
        let g:airline#extensions#tabline#show_buffers = 0
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#show_tab_nr = 0
        let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
        let g:airline#extensions#quickfix#location_text = 'Location'
        let g:airline_powerline_fonts = 1
        " let g:airline_left_sep = ''
        let g:airline_left_sep = "\u2b80"
        " let g:airline_left_alt_sep = ''
        let g:airline_left_alt_sep = "\u2b81"
        " let g:airline_right_sep = ''
        let g:airline_right_sep = "\u2b82"
        " let g:airline_right_alt_sep = ''
        let g:airline_right_alt_sep = "\u2b83"
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif
        " let g:airline_symbols.branch = ''
        let g:airline_symbols.branch = "\u2b60"
        " let g:airline_symbols.readonly = ''
        let g:airline_symbols.readonly = "\u2b64"
        let g:airline_symbols.linenr = ''
        " let g:airline_symbols.linenr = "\u2b61"
        let g:airline_symbols.space = "\ua0"
        let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'VL',
            \ '' : 'VB',
            \ 's'  : 'S',
            \ 'S'  : 'SL',
            \ '' : 'SB',
            \ }

    " }}}

    " DelimitMate {{{
        " let g:delimitMate_excluded_ft = "mail,txt"
        " let delimitMate_autoclose = 1
        " let delimitMate_expand_space = 1
        " let delimitMate_balance_matchpairs = 1
        " let delimitMate_quotes = "\" ' `"
        " let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
        " au FileType ruby let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }}}

    " Sideways {{{
        nnoremap <leader>> :SidewaysRight<CR>
        nnoremap <leader>< :SidewaysLeft<CR>
    " }}}

    " Switch {{{
        nnoremap <silent> - :Switch<CR>
    " }}}

    " Gitv {{{
        " nmap <leader>gv :Gitv --all<cr>
        " nmap <leader>gV :Gitv! --all<cr>
        " vmap <leader>gV :Gitv! --all<cr>
    " }}}

    " UnconditionalPaste {{{
        " nmap <Leader>Pc <Plug>UnconditionalPasteCharBefore
        " nmap <Leader>pc <Plug>UnconditionalPasteCharAfter
        " nmap <Leader>Pl <Plug>UnconditionalPasteLineBefore
        " nmap <Leader>pl <Plug>UnconditionalPasteLineAfter
        " nmap <Leader>Pb <Plug>UnconditionalPasteBlockBefore
        " nmap <Leader>pb <Plug>UnconditionalPasteBlockAfter
        " nmap <Leader>P, <Plug>UnconditionalPasteCommaBefore
        " nmap <Leader>p, <Plug>UnconditionalPasteCommaAfter
        " nmap <Leader>Pq <Plug>UnconditionalPasteQueriedBefore
        " nmap <Leader>pq <Plug>UnconditionalPasteQueriedAfter
        " nmap <Leader>PQ <Plug>UnconditionalPasteRecallQueriedBefore
        " nmap <Leader>pQ <Plug>UnconditionalPasteRecallQueriedAfter
        " nmap <Leader>Pu <Plug>UnconditionalPasteUnjoinBefore
        " nmap <Leader>pu <Plug>UnconditionalPasteUnjoinAfter
        " nmap <Leader>PU <Plug>UnconditionalPasteRecallUnjoinBefore
        " nmap <Leader>pU <Plug>UnconditionalPasteRecallUnjoinAfter

        " imap <C-G>c <Plug>UnconditionalPasteChar
        " imap <C-G>, <Plug>UnconditionalPasteComma
        " imap <C-G>q <Plug>UnconditionalPasteQueried
        " imap <C-G>Q <Plug>UnconditionalPasteRecallQueried
        " imap <C-G>u <Plug>UnconditionalPasteUnjoin
        " imap <C-G>U <Plug>UnconditionalPasteRecallUnjoin
    " }}}

    " UltiSnips {{{
        " Filename function, taken from snipMate.vim
        let did_UltiSnips_snipmate_compatibility = 1
        fun! Filename(...)
            let filename = expand('%:t:r')
            if filename == '' | return a:0 == 2 ? a:2 : '' | endif
            return !a:0 || a:1 == '' ? filename : substitute(a:1, '$1', filename, 'g')
        endf

        let g:UltiSnips = {}
        "let g:UltiSnips.always_use_first_snippet = 1
        let g:UltiSnips.snipmate_ft_filter = {
                    \ 'default' : {'filetypes': ["FILETYPE", "_"] },
                    \ 'html'    : {'filetypes': ["html", "javascript", "_"] },
                    \ 'cpp'    : {'filetypes': [] },
                    \ }
        let g:UltiSnips.UltiSnips_ft_filter = {
            \ 'default' : {'filetypes': [] },
            \ }
    "" }}}

    " Rooter {{{
        let g:rooter_patterns = ['Gemfile', 'Rakefile', '.git/']
        let g:rooter_use_lcd = 1
        "autocmd BufEnter * :Rooter
    " }}}

    " Rails {{{
        " autocmd User Rails cmap Rroutes edit config/routes.rb
        autocmd User Rails silent! Lcd
        autocmd User Rails command! Rstop call RailsServerStop()<CR>
        nmap <f6> :Rrefresh<CR>

        let g:rails_projections = {
              \ "config/projections.json": {
              \   "command": "projections"
              \ },
              \ "config/routes.rb": {
              \   "command": "routes"
              \ },
              \ "config/locales/*.yml": {
              \   "command": "locale"
              \ },
              \ "app/delayed_jobs/*_job.rb": {
              \   "command": "job"
              \ },
              \ "app/forms/*_form.rb": {
              \   "command": "form"
              \ },
              \ "app/serializers/*_serializer.rb": {
              \   "command": "serializer"
              \ },
              \ "app/decorators/*_decorator.rb": {
              \   "command": "decorator"
              \ },
              \ "db/seeds/*.rb": {
              \   "command": "seeds"
              \ },
              \ "spec/features/*_spec.rb": {
              \   "command": "feature",
              \   "template": "require 'spec_helper'\n\nfeature '%h' do\n\nend",
              \ }}
    " }}}

    " Git Gutter {{{
        "highlight clear SignColumn
    " }}}

    " Ruby {{{
        command! VA vsplit | A
        let ruby_operators = 1
    " }}}

    " Dispatch {{{
        " autocmd FileType ruby let b:dispatch = 'rspec %'
        nnoremap <F9> :Dispatch<CR>
        " nnoremap ,t :Dispatch<CR>
    " }}}

    " LastBuf {{{
        " this option decides to reopen which level of hided buffer.
        " :hid   bufhidden  (will always be reopened)
        " :bun   bufunload  (will be reopened if level >= 1)
        " :bd    bufdelete  (will be reopened if level >= 2)
        " :bw    bufwipeout (will never be reopened!CAUTION!!)
        " default is 1 , means :bd and :bw not be reopened.
        " if you want the same effect of 'nohidden'. 
        " set it to 0 and  set 'nohidden'
        let g:lastbuf_level=3
    " }}}

    " vim-rspec {{{
        let g:rspec_command = "Dispatch bin/rspec {spec}"
        nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
        nnoremap <Leader>ts :call RunNearestSpec()<CR>
        nnoremap <Leader>tl :call RunLastSpec()<CR>
    " }}}

    " Crunch {{{
        map <silent> <plug>NoCrunchEvalLine <plug>CrunchEvalLine
        command Calc Crunch
    " }}}

    " Investigate {{{
        " unmap gK
        nnoremap <silent> K :call investigate#Investigate()<CR>
    " }}}

    " Django {{{
        " let g:django_projects = '~/.module/sdf/projekt/code' "Sets all projects under project
        " let g:django_activate_virtualenv = 1 "Try to activate the associated virtualenv
        " let g:django_activate_nerdtree = 1 "Try to open nerdtree at the project root.
    " }}}

    " Commentary {{{
        autocmd FileType apache setlocal commentstring=#\ %s
        autocmd FileType crontab setlocal commentstring=#\ %s
        autocmd FileType gnuplot setlocal commentstring=#\ %s
        autocmd FileType xdefaults setlocal commentstring=!\ %s
        autocmd FileType conkyrc setlocal commentstring=--\ %s
    " }}}

    " VMath {{{
        vmap <expr>  ++  VMATH_YankAndAnalyse()
        nmap         ++  vip++
    " }}}

    " Schlepp {{{
        vmap <unique> <up>    <Plug>SchleppUp
        vmap <unique> <down>  <Plug>SchleppDown
        vmap <unique> <left>  <Plug>SchleppLeft
        vmap <unique> <right> <Plug>SchleppRight
    " }}}

    " Languagetool {{{
        let g:languagetool_lang='de'
        let g:languagetool_jar='$HOME/sys/lib/LanguageTool-3.2/languagetool-commandline.jar'
    " }}}

    " Limelight {{{
        let g:limelight_default_coefficient = 0.8
    " }}}
" }}}

" Functions {{{
    " Auto commands {{{
        augroup Text "{{{
            au!
            au BufReadPre   *.txt setl textwidth=72
            au BufReadPre   *.txt setl wrapmargin=5
            au BufReadPre   *.txt setl formatoptions=tl
        augroup END
        "}}}
        augroup gitcommit "{{{
            au!
            au FileType gitcommit setl textwidth=72
            au FileType gitcommit setl wrapmargin=5
            au FileType gitcommit setl formatoptions=tl
        augroup END
        "}}}
        augroup Python "{{{
            au!
            au FileType python setl ts=4 sts=4 sw=4 expandtab
        "}}}
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
        augroup Pass "{{{
            au!
            au BufNewFile,BufRead /dev/shm/pass.* setlocal noswapfile nobackup noundofile ft=yaml
        augroup END
        "}}}
        augroup Coffee "{{{
            au!
            au BufNewFile,BufRead *.coffee setl filetype=coffee
            au BufNewFile,BufRead *.coffee setl foldmethod=indent
            au Filetype coffee setl foldmethod=indent nofoldenable
            au Filetype coffee setl shiftwidth=2 expandtab
        augroup END
        "}}}
        augroup Shebang "{{{
            au!
            au BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># encoding: utf-8\<nl>\"|$
            au BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
            au BufNewFile *.pl 0put =\"#!/usr/bin/env perl\<nl>\"|$
            autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
        augroup END
        "}}}
        augroup Executable "{{{
            " automatically give executable permissions if file begins with #! and contains '/bin/' in the path
            au!
            au BufWritePost * call MakeExecutable()
        augroup END
        "}}}
        " augroup MakeNonExistingDirectory "{{{
            " automatically create missing directories
            " au!
            " au BufWritePre * call MakeNonExistingDir()
        " augroup END
        "}}}
        augroup Latex "{{{
            au!
            au BufNewFile,BufRead *.tex set filetype=tex
            au BufNewFile,BufRead *.lco set filetype=tex
            au FileType tex setl textwidth=120
            au FileType tex setl wrapmargin=5
            au FileType tex setl formatoptions=tl
            au FileType tex setl noexpandtab
            au FileType tex setl spell spelllang=de,de_DE_frami,en_us | let g:myLang = 4
            au FileType tex vmap ,it c\textit{<C-R>*}<esc>
            au FileType tex vmap ,tt c\texttt{<C-R>*}<esc>
            au FileType tex vmap ,bf c\textbf{<C-R>*}<esc>
            au FileType tex vmap ,td c\todo{<C-R>*}<esc>
            au FileType tex nmap ds\ f}F\deds}
            au FileType tex vmap ,ia c„<C-R>*“<esc>
            au FileType tex nmap <F11> :silent !make -B<CR> | echo 'Compilation done.'<CR>
        augroup END

        "}}}

        " Source the vimrc file after saving it
        "au Bufwritepost vimrc source $MYVIMRC

        " Treat .rss files as XML
        au BufNewFile,BufRead *.rss,*.atom set filetype=xml
        au BufNewFile,BufRead *.asm,*.ASM,*.s,*.S source $VIM/syntax/gasm.vim
        au BufNewFile,BufRead *.ldif set filetype=ldif
        au BufNewFile,BufRead *.gnuplot set filetype=gnuplot
        au BufNewFile,BufRead *.pl set filetype=prolog
        au BufNewFile,BufRead Guardfile set filetype=ruby

        au BufNewFile,BufRead TODO.txt nnoremap <leader>x 0f]hrx
        " au BufWritePost *.c :make
        au BufReadPost fugitive://* set bufhidden=delete

        au FileType make       setlocal ts=8 sts=8 sw=8 noexpandtab
        au FileType yaml       setlocal ts=2 sts=2 sw=2 expandtab
        au FileType html       setlocal ts=4 sts=4 sw=4 expandtab
        au FileType css        setlocal ts=2 sts=2 sw=2 expandtab
        au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

        " Omni Completion
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS

        " Resize splits when the window is resized
        au VimResized * :wincmd ="

        " au FocusLost,InsertEnter   * set norelativenumber
        " au FocusGained,InsertLeave * set relativenumber

        au FocusLost * silent! update
    " }}}

    " Clean whitespace at EOL {{{
        " source: https://github.com/bronson/vim-trailing-whitespace/blob/master/plugin/trailing-whitespace.vim
        highlight ExtraWhitespace ctermbg=darkred guibg=#DC322F
        autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=#DC322F
        autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
        " the above flashes annoyingly while typing, be calmer in insert mode
        "autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        "autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        function! s:FixWhitespace(line1,line2)
          let l:save_cursor = getpos(".")
          silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
          call setpos('.', l:save_cursor)
        endfunction
        " Run :FixWhitespace to remove end of line white space.
        command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)
    " }}}

    " Set up spell function {{{
        let g:myLang = 0
        let g:myLangList = [ "Off", "german", "english", "german & english" ]
        function! ChangeSpellLang()
            if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
            if g:myLang == 0 | set nospell | endif
            if g:myLang == 1 | setlocal spell spelllang=de,de_DE_frami | endif
            if g:myLang == 2 | setlocal spell spelllang=en_us | endif
            if g:myLang == 3 | setlocal spell spelllang=de,de_DE_frami,en_us | endif
            echo "language:" g:myLangList[g:myLang]
            let g:myLang = g:myLang + 1
        endfunction
        map <F12> :call ChangeSpellLang()<CR>
        "format the bad spelled words
        hi SpellBad ctermbg=52 ctermfg=9
        "set spell suggestion to 8
        set spellsuggest=8
    " }}}

    " Make executable {{{
    " automatically give executable permissions if file begins with #! and contains '/bin/' in the path
        function! MakeExecutable()
            if getline(1) =~ "^#!.*/bin/"
                silent !chmod a+x <afile>
            endif
        endfunction
    " }}}

    " Foldtext {{{
        function! MyFoldLabel() " {{{
            let line = getline(v:foldstart)

            let nucolwidth = &fdc + &number * &numberwidth
            let windowwidth = winwidth(0) - nucolwidth - 3
            let foldedlinecount = v:foldend - v:foldstart

            " Remove foldmarkers
            let opening_foldmarker = split(&foldmarker, ",")[0]
            let line = substitute(line, opening_foldmarker, "", 'g')

            " expand tabs into spaces
            let onetab = strpart('          ', 0, &tabstop)
            let line = substitute(line, '\t', onetab, 'g')

            "let linestart = substitute(v:folddashes, ".", '»', 'g')
            "let line = linestart . line

            let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
            let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
            return line . ' ' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
        endfunction " }}}
    " }}}

    " Merge a tab into a split in the previous window {{{
        function! MergeTabs()
          if tabpagenr() == 1
            return
          endif
          let bufferName = bufname("%")
          if tabpagenr("$") == tabpagenr()
            close!
          else
            close!
            tabprev
          endif
          split
          execute "buffer " . bufferName
        endfunction
        nmap <C-W>m :call MergeTabs()<CR>
    " }}}

    " Extract a buffer to a new tab {{{
        command! ExtractToTab tabedit % | tabprev | close
    " }}}

    " Make backup {{{
        function! MakeBackup()
            silent exec "!cp % %.bak"
            redraw!
        endfunction
        command! MkBackup call MakeBackup()
    " }}}

    " Diff {{{
        command! Diffall windo diffthis
    " }}}

    " Create non-existing directory {{{
        " function MakeNonExistingDir()
        "     let dir = expand('%:p:h')

        "     if !isdirectory(dir)
        "         call mkdir(dir, 'p')
        "         echo 'Created non-existing directory: '.dir
        "     endif
        " endfunction
        function! AskQuit (msg, options, quit_option)
            if confirm(a:msg, a:options) == a:quit_option
                exit
            endif
        endfunction

        function! EnsureDirExists ()
            let required_dir = expand("%:h")
            if !isdirectory(required_dir)
                call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
                            \       "&Create it\nor &Quit?", 2)

                try
                    call mkdir( required_dir, 'p' )
                catch
                    call AskQuit("Can't create '" . required_dir . "'",
                                \            "&Quit\nor &Continue anyway?", 1)
                endtry
            endif
        endfunction

        augroup AutoMkdir
            autocmd!
            autocmd  BufNewFile  *  :call EnsureDirExists()
        augroup END
    " }}}

    " Clean registers {{{
        function! CleanRegisters()
            let @a = ''
            let @b = ''
            let @c = ''
            let @d = ''
            let @e = ''
            let @f = ''
            let @g = ''
            let @h = ''
            let @i = ''
            let @j = ''
            let @k = ''
            let @l = ''
            let @m = ''
            let @n = ''
            let @o = ''
            let @p = ''
            let @q = ''
            let @r = ''
            let @s = ''
            let @t = ''
            let @u = ''
            let @v = ''
            let @w = ''
            let @x = ''
            let @y = ''
            let @z = ''
        endfunction
        command! CleanRegisters call CleanRegisters()
    " }}}

    " Clean double empty lines {{{
        function! CleanDoubleEmptyLines()
          silent! execute '%s/\v^\s*\n^\s*\n/\r/g'
        endfunction
        command! CleanDoubleEmptyLines call CleanDoubleEmptyLines()
    " }}}

    " Convert Win2Unix {{{
        function! Win2Unix()
          silent! execute ':e ++ff=unix'
          echo "CRLF > LF"
        endfunction
        command! Win2Unix call Win2Unix()
    " }}}

    " Convert to UTF-8 {{{
        function! WriteUTF8()
          silent! execute ':w ++enc=utf-8'
          echo "Convert to UTF-8"
        endfunction
        command! WriteUTF8 call WriteUTF8()
    " }}}

    " Convert Unix2Win {{{
        function! Unix2Win()
          normal mz
          silent! execute ':%s/\r$/\r/g'
          echo "LF > CRLF"
          normal 'z
        endfunction
        command! Unix2Win call Unix2Win()
    " }}}

    " Decode Bas64 {{{
        function! Base64DecodeLine()
          normal mz
          silent! execute ':ruby require "base64"'
          silent! execute ':.rubydo $_=Base64.decode64 $_'
          silent! execute ':%s//\r/g'
          normal 'z
        endfunction
        command! Base64DecodeLine call Base64DecodeLine()
    " }}}

    " Encode Bas64 {{{
        function! Base64EncodeLine()
          normal mz
          silent! execute ':ruby require "base64"'
          silent! execute ':%rubydo $_=Base64.encode64 $_'
          normal 'z
        endfunction
        command! Base64EncodeLine call Base64EncodeLine()
    " }}}

    " Reformat JSON {{{
        function! s:ReformatJSON(line1,line2)
          let l:save_cursor = getpos(".")
          silent! execute ':' . a:line1 . ',' . a:line2 . '!python -m json.tool'
          call setpos('.', l:save_cursor)
        endfunction
        command! -range=% ReformatJSON call <SID>ReformatJSON(<line1>,<line2>)
    " }}}

    " Extract visual selection to separate file {{{
        command! -bang -range -nargs=1 -complete=file Extract set noshowcmd | <line1>,<line2>write<bang> <args> | <line1>,<line2>delete _ | vsplit <args> | set showcmd
    " }}}

    " Diff with current file {{{
        command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
    " }}}

    " Scratch window {{{
        command VScratch vert new | set bt=nofile
        command Scratch new | set bt=nofile
    " }}}

    " Markdown to LaTeX {{{
        function! MarkdownToLaTeX()
          let basename = expand('%:p:r')
          let source = basename.'.md'
          let destination = basename.'.tex'
          silent! execute '! pandoc -t latex -f markdown -o '.destination.' '.source
          echo 'LaTeX erstellt unter '.destination
        endfunction
        command! Md2Tex call MarkdownToLaTeX()
    " }}}

    " Open a split for each dirty file in git {{{
        function! OpenChangedFiles()
        only " Close all windows, unless they're modified
        let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
        let filenames = split(status, "\n")
        exec "edit " . filenames[0]
        for filename in filenames[1:]
            exec "sp " . filename
        endfor
        endfunction
        command! OpenChangedFiles :call OpenChangedFiles()
    " }}}
" }}}

" Programming {{{
    set cin         " C code ident

    " Let the syntax highlighting for Java files allow cpp keywords
    let java_allow_cpp_keywords = 1
" }}}

" Neovim settings {{{
    if has('nvim')
        tnoremap <Esc> <C-\><C-n>

        let viminfopath='~/.config/nvim/shada/main.shada'
    endif
" }}}

" Sources {{{
    " vimspell: http://www.vim.org/scripts/script.php?script_id=465
    if filereadable(expand("~/.vim/abbrev.vim"))
        source ~/.vim/abbrev.vim
    endif
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }}}

" Use local gvimrc if available and gui is running {{{
    if has('gui_running')
        if filereadable(expand("~/.gvimrc"))
            source ~/.gvimrc
        endif
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }}}
