if has("autocmd")
  autocmd bufwritepost plugin source $MYVIMRC
endif

"-----------------------------------------------------------------------------
" pathogen
"-----------------------------------------------------------------------------
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

"-----------------------------------------------------------------------------
" xptemplate
"-----------------------------------------------------------------------------
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

"-----------------------------------------------------------------------------
" latex-suite
"-----------------------------------------------------------------------------
"" IMPORTANT: grep will sometimes skip displaying the file name if you
"" search in a singe file. This will confuse Latex-Suite. Set your grep
"" program to always generate a file-name.
"set grepprg=grep\ -nH\ $*

"if has('gui_running')
  "set grepprg=grep\ -nH\ $*
  "let g:tex_flavor='latex'
"endif

"au BufEnter *.tex set autowrite
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats = 'pdf'
"let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
"let g:Tex_GotoError = 0
"let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_ViewRule_dvi = 'xdvi -editor "gvim --servername xdvi --remote +\%l \%f" $* &'
"let g:Tex_ViewRuleComplete_dvi = 'xdvi -editor "gvim --servername xdvi --remote +\%l \%f" $* &'

"let g:Tex_AutoFolding = 1
"let g:Imap_DeleteEmptyPlaceHolders = 1
""let g:Tex_Leader = ','
"let g:Tex_HotKeyMappings = 'eqnarray*,eqnarray,bmatrix,lstlisting' "<S-F1> through <S-F4>
""let g:Tex_IgnoredWarnings

"-----------------------------------------------------------------------------
" ATP
"-----------------------------------------------------------------------------
nmap :makelatex :MakeLatex
nmap :viewoutput :ViewOutput

"-----------------------------------------------------------------------------
" tabular
"-----------------------------------------------------------------------------
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"-----------------------------------------------------------------------------
" OmniCppComplete
"-----------------------------------------------------------------------------
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
" build tags of your own project with Ctrl-F12
map <F8> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
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

"-----------------------------------------------------------------------------
" checkist
"-----------------------------------------------------------------------------
au BufNewFile,BufRead *.chklst setf chklst

"-----------------------------------------------------------------------------
" gundo
"-----------------------------------------------------------------------------
nnoremap ,g :GundoToggle<CR>

"-----------------------------------------------------------------------------
" ragtag
"-----------------------------------------------------------------------------
let g:ragtag_global_maps = 1

"-----------------------------------------------------------------------------
" plugin taglist.vim : toggle the taglist window
"-----------------------------------------------------------------------------
if exists(":TlistToggle")
  noremap <silent> <F6> :TlistToggle<CR>
  inoremap <silent> <F6> <C-C>:TlistToggle<CR>
endif

"-----------------------------------------------------------------------------
" lusty-juggler
" http://www.vim.org/scripts/script.php?script_id=2050
"-----------------------------------------------------------------------------
"nmap <silent> <Leader>b :LustyJuggler<CR>

"-----------------------------------------------------------------------------
" FSwitch Settings
"-----------------------------------------------------------------------------
nmap <silent> ,of :FSHere<CR>
nmap <silent> ,ol :FSRight<CR>
nmap <silent> ,oL :FSSplitRight<CR>
nmap <silent> ,oh :FSLeft<CR>
nmap <silent> ,oH :FSSplitLeft<CR>
nmap <silent> ,ok :FSAbove<CR>
nmap <silent> ,oK :FSSplitAbove<CR>
nmap <silent> ,oj :FSBelow<CR>
nmap <silent> ,oJ :FSSplitBelow<CR>

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile="~/.vim/NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
      \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
      \ '\.embed\.manifest$', '\.embed\.manifest.res$',
      \ '\.intermediate\.manifest$', '^mt.dep$' ]

" Allows to comment lines in different languages
""Comment current line
"nmap ,co ,cc
""uncoment current line
"nmap ,uco ,cu
""toggle comment current line
"nmap ,tco ,c<space>
" Do not yiel about unknown filetypes.
let NERDShutUp=1

"-----------------------------------------------------------------------------
" MiniBufExplorer Plugin Settings
"-----------------------------------------------------------------------------
" Yup, I don't like this one either
"let loaded_minibufexplorer = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
let g:miniBufExplMapWindowNavArrows = 1

"-----------------------------------------------------------------------------
" ShowMarks Plugin Stuff
"-----------------------------------------------------------------------------
" I don't think I like this
"let g:loaded_showmarks = 1
let g:showmarks_enable = 0

"-----------------------------------------------------------------------------
" Source Explorer Plugin Settings
"-----------------------------------------------------------------------------
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

"-----------------------------------------------------------------------------
" FuzzyFinder Settings
"-----------------------------------------------------------------------------
"nmap ,fb :FuzzyFinderBuffer<CR>
"nmap ,ff :FuzzyFinderFile<CR>
"nmap ,ft :FuzzyFinderTag<CR>

"-----------------------------------------------------------------------------
" unimpaired
"-----------------------------------------------------------------------------
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"-----------------------------------------------------------------------------
" Tlist
"-----------------------------------------------------------------------------
let Tlist_Ctags_Cmd = "/usr/bin/ctags" " The packge 'ctags' have to be installed!
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1

"-----------------------------------------------------------------------------
" jcommenter
"-----------------------------------------------------------------------------
"autocmd FileType java source $VIM/macros/jcommenter.vim
autocmd FileType java map <M-c> :call JCommentWriter()<CR>  " Alt-C

"-----------------------------------------------------------------------------
" ShowPairs
"-----------------------------------------------------------------------------
highlight ShowPairsHLp ctermfg=black ctermbg=white
let g:showpairs_enable = 1
let g:showpairs_pairs = "(:),{:},[:]"

"-----------------------------------------------------------------------------
" XMLFolding
"-----------------------------------------------------------------------------
au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/bundle/vim-xmlfolding/plugin/XMLFolding.vim

"-----------------------------------------------------------------------------
" py-flakes
"-----------------------------------------------------------------------------
let g:pyflakes_use_quickfix = 0 " No quickfix window

"-----------------------------------------------------------------------------
" SuperTab
"-----------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "context"
