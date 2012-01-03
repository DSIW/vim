set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let Vundle manage Vundle
" required! 
"Bundle 'gmarik/vundle.git'
Bundle 'vundle'
"Bundle 'gmarik/github-search.vim'
Bundle 'https://github.com/gmarik/github-search.vim.git'
"Bundle 'https://github.com/gmarik/ingretu.git'
"
" My Bundles here:
Bundle 'SearchComplete'
Bundle 'Buffer-Search'
Bundle 'c.vim'
Bundle 'vimshell-ssh'
Bundle 'ShowPairs'
Bundle 'hexman.vim'
Bundle 'Gundo'
Bundle 'taglist.vim'
Bundle 'lastpos.vim'
Bundle 'AutomaticLaTexPlugin'
Bundle 'SudoEdit.vim'
Bundle 'sudo.vim'
Bundle 'SuperTab'
Bundle 'Tabular'
Bundle 'ProtoDef'
Bundle 'The-NERD-Commenter'
Bundle 'The-NERD-tree'
Bundle 'LustyJuggler'
Bundle 'minibufexpl.vim'
Bundle 'vim-coffee-script'
Bundle 'unicode.vim'
Bundle 'csv.vim'
Bundle 'unimpaired.vim'
Bundle 'rails.vim'
Bundle 'Haml'
Bundle 'endwise.vim'
Bundle 'ragtag.vim'
Bundle 'speeddating.vim'
Bundle 'surround.vim'
Bundle 'delete-surround-html'
Bundle 'repeat.vim'
Bundle 'recover.vim'
Bundle 'ShowMarks'
Bundle 'fugitive.vim'
Bundle 'gitdiff.vim'
Bundle 'git.zip'
"Bundle 'gitvimdiff'
Bundle 'XML-Folding'
Bundle 'snipMate'
Bundle 'snipMate'
Bundle 'snipmate-snippets'
Bundle 'xoria256.vim'
Bundle 'xptemplate'
Bundle 'neverland.vim--All-colorschemes-suck'
Bundle 'VisIncr'

"Bundle 'mirell/vim-matchit.git'
Bundle 'matchit.zip'
"Bundle 'tpope/vim-markdown.git'
Bundle 'Markdown-syntax'
"Bundle 'tsaleh/vim-align.git'

" ERRORS
"Bundle 'Align.vim' " ERROR
"Bundle 'checklist.vim' " ERROR
"Bundle 'css_color.vim'
"Bundle 'vim-recovery' " NOT FOUND

"Bundle 'FSwitch'
"Bundle 'EasyGrep'
"Bundle 'taglist.vim'
"Bundle 'SuperTab'
"Bundle 'javacomplete'
"Bundle 'cespare/vjde.git'
"Bundle 'ervandew/eclim.git'
"Bundle 'pep8'
"Bundle 'mitechie/pyflakes-pathogen.git'
"Bundle 'fs111/pydoc.vim.git'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...
"
filetype plugin indent on     " required! 
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" NOTE: comments after Bundle command are not allowed.
" see :h vundle for more details or wiki for FAQ
