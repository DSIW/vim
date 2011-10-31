" Author: 	Marcin Szamotulski	
" Note:		this file contain the main compiler function and related tools, to
" 		view the output, see error file.
" Note:		This file is a part of Automatic Tex Plugin for Vim.
" Language:	tex

" Internal Variables
" {{{
" This limits how many consecutive runs there can be maximally.
" Note: compile.py script has hardcoded the same value.
let atplib#compiler#runlimit		= 9

try
    compiler tex
catch E666:
endtry
" }}}

" This is the function to view output. It calls compiler if the output is a not
" readable file.
" {{{ atplib#compiler#ViewOutput
" a:1 == "RevSearch" 	if run from RevSearch() function and the output file doesn't
" exsists call compiler and RevSearch().
function! atplib#compiler#ViewOutput(bang,...)

    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)

    let fwd_search	= ( a:bang == "!" ? 1 : 0 )

    call atplib#outdir()

    " Set the correct output extension (if nothing matches set the default '.pdf')
    let ext		= get(g:atp_CompilersDict, matchstr(b:atp_TexCompiler, '^\s*\zs\S\+\ze'), ".pdf") 

    " Read the global options from g:atp_{b:atp_Viewer}Options variables
    let global_options 	= join((exists("g:atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? g:atp_{matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')}Options : []), " ")
    let local_options 	= join((exists("b:atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? getbufvar(bufnr("%"), "atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") : []), " ")

    " Follow the symbolic link
    let link=resolve(atp_MainFile)
    if link != ""
	let outfile	= fnamemodify(link,":r") . ext
    else
	let outfile	= fnamemodify(atp_MainFile,":r"). ext 
    endif

    if b:atp_Viewer == "xpdf"	
	let viewer	= b:atp_Viewer . " -remote " . shellescape(b:atp_XpdfServer)
    else
	let viewer	= b:atp_Viewer . " "
    endif


    if g:atp_debugV
	let g:global_options = global_options
	let g:local_options  = local_options
	let g:viewer         = viewer
    endif
    let view_cmd	= viewer." ".global_options." ".local_options." ".shellescape(outfile)." &"

    if g:atp_debugV
	let g:view_cmd	= view_cmd
    endif

    if filereadable(outfile)
	if b:atp_Viewer == "xpdf"
	    call system(view_cmd)
	else
	    call system(view_cmd)
	    redraw!
	endif
    else
	echomsg "[ATP:] output file do not exists. Calling " . b:atp_TexCompiler
	if fwd_search
	    if g:atp_Compiler == 'python'
		call atplib#compiler#PythonCompiler( 0, 2, 1, 'silent' , "AU" , atp_MainFile, "")
	    else
		call atplib#compiler#Compiler( 0, 2, 1, 'silent' , "AU" , atp_MainFile, "")
	    endif
	else
	    if g:atp_Compiler == 'python'
		call atplib#compiler#PythonCompiler( 0, 1, 1, 'silent' , "AU" , atp_MainFile, "")
	    else
		call atplib#compiler#Compiler( 0, 1, 1, 'silent' , "AU" , atp_MainFile, "")
	    endif
	endif
    endif
    if fwd_search
	let msg = "[SyncTex:] waiting for the viewer "
	let i=1
	while !atplib#compiler#IsRunning(viewer, outfile) && i<10
	    echo msg
	    sleep 100m
	    redraw
	    let msg.="."
	    let i+=1
	endwhile
	if i<15
	    call atplib#compiler#SyncTex("", 0)
	else
	    echohl WarningMsg
	    echomsg "[SyncTex:] viewer is not running"
	    echohl Normal
	endif
    endif
endfunction
"}}}

" Forward Search:
" {{{ atplib#compiler#GetSyncData
function! atplib#compiler#GetSyncData(line, col)

     	if !filereadable(fnamemodify(atplib#FullPath(b:atp_MainFile), ":r").'.synctex.gz') 
	    redraw!
	    let cmd=b:atp_TexCompiler." ".join(split(b:atp_TexOptions, ','), " ")." ".shellescape(atplib#FullPath(b:atp_MainFile))
	    if b:atp_TexOptions !~ '\%(-synctex\s*=\s*1\|-src-specials\>\)'
		echomsg "[SyncTex:] b:atp_TexOptions does not contain -synctex=1 or -src-specials switches!"
		return
	    else
		echomsg "[SyncTex:] calling ".get(g:CompilerMsg_Dict, b:atp_TexCompiler, b:atp_TexCompiler)." to generate synctex data. Wait a moment..."
	    endif
 	    call system(cmd) 
 	endif
	" Note: synctex view -i line:col:tex_file -o output_file
	" tex_file must be full path.
	let synctex_cmd="synctex view -i ".a:line.":".a:col.":'".fnamemodify(b:atp_MainFile, ":p"). "' -o '".fnamemodify(b:atp_MainFile, ":p:r").".pdf'"

	" SyncTex is fragile for the file name: if it is file name or full path, it
	" must agree literally with what is written in .synctex.gz file
	" first we try with full path then with file name without path.
	let synctex_output=split(system(synctex_cmd), "\n")
	if get(synctex_output, 1, '') =~ '^SyncTex Warning: No tag for'
	    " Write better test (above)
	    let synctex_cmd="synctex view -i ".a:line.":".a:col.":'".b:atp_MainFile. "' -o '".fnamemodify(b:atp_MainFile, ":r").".pdf'"
	    let synctex_output=split(system(synctex_cmd), "\n")
" 	    call add(g:debug,get(synctex_output, 1, ''))
	    if get(synctex_output, 1, '') =~ '^SyncTex Warning:'
		return [ "no_sync", get(synctex_output, 1, ''), 0 ]
	    endif
	endif

	if g:atp_debugSync
	    let g:synctex_cmd=synctex_cmd
	    let g:synctex_output=copy(synctex_output)
	endif

	let page_list=copy(synctex_output)
	call filter(page_list, "v:val =~ '^\\cpage:\\d\\+'")
	let page=get(page_list, 0, "no_sync") 

	let y_coord_list=copy(synctex_output) 
	call filter(y_coord_list, "v:val =~ '^\\cy:\\d\\+'")
	let y_coord=get(y_coord_list, 0, "no sync data")
	let y_coord= ( y_coord != "no sync data" ? matchstr(y_coord, 'y:\zs[0-9.]*') : y_coord )

	let x_coord_list=copy(synctex_output) 
	call filter(x_coord_list, "v:val =~ '^\\cx:\\d\\+'")
	let x_coord=get(x_coord_list, 0, "no sync data")
	let x_coord= ( x_coord != "no sync data" ? matchstr(x_coord, 'x:\zs[0-9.]*') : x_coord )

	if g:atp_debugSync
	    let g:page=page
	    let g:y_coord=y_coord
	    let g:x_coord=x_coord
	endif

	if page == "no_sync"
	    return [ "no_sync", "No SyncTex Data: try on another line (or recompile the document).", 0 ]
	endif
	let page_nr=matchstr(page, '^\cPage:\zs\d\+') 
	let [ b:atp_synctex_pagenr, b:atp_synctex_ycoord, b:atp_synctex_xcoord ] = [ page_nr, y_coord, x_coord ]
	return [ page_nr, y_coord, x_coord ]
endfunction
function! atplib#compiler#SyncShow( page_nr, y_coord)
    if a:y_coord < 300
	let height="top"
    elseif a:y_coord < 500
	let height="middle"
    else
	let height="bottom"
    endif
    if a:page_nr != "no_sync"
	echomsg "[SyncTex:] ".height." of page ".a:page_nr
    else
	echohl WarningMsg
	echomsg "[SyncTex:] ".a:y_coord
" 	echomsg "       You cannot forward search on comment lines, if this is not the case try one or two lines above/below"
	echohl Normal
    endif
endfunction "}}}
" {{{ atplib#compiler#SyncTex
function! atplib#compiler#SyncTex(bang, mouse, ...)
    if g:atp_debugSyncTex
	exe "redir! > ".g:atp_TempDir."/SyncTex.log"
    endif
    let output_check 	= ( a:0 >= 1 && a:1 == 0 ? 0 : 1 )
    let IsRunning_check = ( a:bang == "!" ? 0 : 1 )
    let dryrun 		= ( a:0 >= 2 && a:2 == 1 ? 1 : 0 )
    " Mouse click <S-LeftMouse> is mapped to <LeftMouse>... => thus it first changes
    " the cursor position.
    let [ line, col ] 	= [ line("."), col(".") ]
    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
    let ext		= get(g:atp_CompilersDict, matchstr(b:atp_TexCompiler, '^\s*\zs\S\+\ze'), ".pdf")
    let output_file	= fnamemodify(atp_MainFile,":p:r") . ext
    if !filereadable(output_file) && output_check
	" Here should be a test if viewer is running, this can be made with python.
	" this is way viewer starts not well when using :SyncTex command while Viewer
	" is not running.
"        call atplib#compiler#ViewOutput("sync")
"        if g:atp_debugSyncTex
" 	   silent echo "ViewOutput sync"
" 	   redir END
"        endif
       echohl WarningMsg
       echomsg "[SyncTex:] no output file"
       echohl Normal
       return 2
    endif
    let atp_MainFile         = atplib#FullPath(b:atp_MainFile)
    let ext		     = get(g:atp_CompilersDict, matchstr(b:atp_TexCompiler, '^\s*\zs\S\+\ze'), ".pdf")
    let link=resolve(atp_MainFile)
    if link != ""
        let outfile     = fnamemodify(link,":r") . ext
    else
        let outfile     = fnamemodify(atp_MainFile,":r"). ext 
    endif

    if IsRunning_check
	if (!atplib#compiler#IsRunning(b:atp_Viewer, atplib#FullPath(outfile), b:atp_XpdfServer) && output_check) 
	    "Note: I should test here if Xpdf is not holding a file (it might be not
	    "visible through cmdline arguments -> this happens if file is opened in
	    "another server. We can use: xpdf -remote b:atp_XpdfServer "run('echo %f')"
	    echohl WarningMsg
	    echomsg "[SyncTex:] please open the file first. (if file is opend add bang \"!\")"
	    echohl Normal
	    return
	endif
    endif

    if b:atp_Viewer == "xpdf"
	let [ page_nr, y_coord, x_coord ] = atplib#compiler#GetSyncData(line, col)
	let sync_cmd_page = "xpdf -remote " . shellescape(b:atp_XpdfServer) . " -exec 'gotoPage(".page_nr.")'"
	let sync_cmd_y 	= "xpdf -remote " . shellescape(b:atp_XpdfServer) . " -exec 'scrollDown(".y_coord.")'"
        let sync_cmd_x 	= "xpdf -remote " . shellescape(b:atp_XpdfServer) . " -exec 'scrollRight(".x_coord.")'"
	" There is a bug in xpdf. We need to sleep between sending commands:
	let sleep    = ( g:atp_XpdfSleepTime ? 'sleep '.string(g:atp_XpdfSleepTime).'s;' : '' )
	let sync_cmd = "(".sync_cmd_page.";".sleep.sync_cmd_y.")&"
	if !dryrun
	    call system(sync_cmd)
	    call atplib#compiler#SyncShow(page_nr, y_coord)
	endif
    elseif b:atp_Viewer == "okular"
	let [ page_nr, y_coord, x_coord ] = atplib#compiler#GetSyncData(line, col)
	" This will not work in project files. (so where it is mostly needed.) 
	let sync_cmd = "okular --unique ".shellescape(expand("%:p:r")).".pdf\\#src:".line.shellescape(expand("%:p"))." &"
	let sync_args = " ".shellescape(expand("%:p:r")).".pdf\\#src:".line.shellescape(expand("%:p"))." "
	if !dryrun
	    call system(sync_cmd)
	    call atplib#compiler#SyncShow(page_nr, y_coord)
	endif
    elseif b:atp_Viewer == "skim"
	let [ page_nr, y_coord, x_coord ] = atplib#compiler#GetSyncData(line, col)
	let sync_cmd = "displayline ".line." ".shellescape(expand("%:p:r")).".pdf ".shellescape(expand("%:p"))." &"
	if !dryrun
	    call system(sync_cmd)
	    call atplib#compiler#SyncShow(page_nr, y_coord)
	endif
"     elseif b:atp_Viewer == "evince"
" 	let rev_searchcmd="synctex view -i ".line(".").":".col(".").":".fnameescape(b:atp_MainFile). " -o ".fnameescape(fnamemodify(b:atp_MainFile, ":p:r").".pdf") . " -x 'evince %{output} -i %{page}'"
"     endif
    elseif b:atp_Viewer =~ '^\s*xdvi\>'
	let options = (exists("g:atp_xdviOptions") ? " ".join(g:atp_xdviOptions, " ") : " " ) ." ".join(getbufvar(bufnr(""), "atp_xdviOptions"), " ")
	let sync_cmd = "xdvi ".options.
		\ " -editor '".v:progname." --servername ".v:servername.
		\ " --remote-wait +%l %f' -sourceposition ". 
		\ line.":".col.shellescape(fnameescape(fnamemodify(expand("%"),":p"))). 
		\ " ".fnameescape(output_file)." &"
	let sync_args = " -sourceposition ".line.":".col.shellescape(fnameescape(fnamemodify(expand("%"),":p")))." "
	if !dryrun
	    call system(sync_cmd)
	endif
	if g:atp_debugSyncTex
	    silent echo "sync_cmd=".sync_cmd
	endif
    else
	let sync_cmd=""
	if g:atp_debugSyncTex
	    silent echo "sync_cmd=EMPTY"
	endif
    endif
    if g:atp_debugSyncTex
	let g:sync_cmd = sync_cmd
    endif
   if g:atp_debugSyncTex
       redir END
   endif
    return
endfunction 
"}}}
"
" This function gets the pid of the running compiler
" ToDo: review LatexBox has a better approach!
"{{{ Get PID Functions
function! atplib#compiler#getpid()
	let atplib#compiler#command="ps -ef | grep -v " . $SHELL  . " | grep " . b:atp_TexCompiler . " | grep -v grep | grep " . fnameescape(expand("%")) . " | awk 'BEGIN {ORS=\" \"} {print $2}'" 
	let atplib#compiler#var	= system(atplib#compiler#command)
	return atplib#compiler#var
endfunction
" The same but using python (it is not used)
" TODO: end this.
function! atplib#compiler#PythonGetPID() 
python << EOF
import psutil
latex = vim.eval("b:atp_TexCompiler")
# Make dictionary: xpdf_servername : file
# to test if the server host file use:
# basename(xpdf_server_file_dict().get(server, ['_no_file_'])[0]) == basename(file)
ps_list=psutil.get_pid_list()
latex_running	= False
for pr in ps_list:
	try:
		name=psutil.Process(pr).name
		cmdline=psutil.Process(pr).cmdline
		if name == latex:
			latex_pid=pr
			latex_running=True
			break
	except psutil.error.NoSuchProcess:
		pass
	except psutil.error.AccessDenied:
		pass

if latex_running:
	vim.command("let atplib#compiler#var="+str(latex_pid))
else:
	vim.command("let atplib#compiler#var=''")
EOF
endfunction
function! atplib#compiler#GetPID()
    if g:atp_Compiler == "bash"
	let atplib#compiler#var=atplib#compiler#getpid()
	if atplib#compiler#var != ""
	    echomsg "[ATP:] ".b:atp_TexCompiler . " pid(s): " . atplib#compiler#var 
	else
	    let b:atp_running	= 0
	    echomsg "[ATP:] ".b:atp_TexCompiler . " is not running"
	endif
    else
	call atplib#callback#PIDsRunning("b:atp_LatexPIDs")
	if len(b:atp_LatexPIDs) > 0
	    echomsg "[ATP:] ".b:atp_TexCompiler . " pid(s): " . join(b:atp_LatexPIDs, ", ") 
	else
	    let b:atp_LastLatexPID = 0
	    echomsg "[ATP:] ".b:atp_TexCompiler . " is not running"
	endif
    endif
endfunction
"}}}

" This function compares two files: file written on the disk a:file and the current
" buffer
"{{{ atplib#compiler#compare
" relevant variables:
" g:atp_compare_embedded_comments
" g:atp_compare_double_empty_lines
" Problems:
" This function is too slow it takes 0.35 sec on file with 2500 lines.
	" Ideas:
	" Maybe just compare current line!
	" 		(search for the current line in the written
	" 		file with vimgrep)
function! atplib#compiler#compare(file)
    let l:buffer=getbufline(bufname("%"),"1","$")

    " rewrite l:buffer to remove all comments 
    let l:buffer=filter(l:buffer, 'v:val !~ "^\s*%"')

    let l:i = 0
    if g:atp_compare_double_empty_lines == 0 || g:atp_compare_embedded_comments == 0
    while l:i < len(l:buffer)-1
	let l:rem=0
	" remove comment lines at the end of a line
	if g:atp_compare_embedded_comments == 0
	    let l:buffer[l:i] = substitute(l:buffer[l:i],'%.*$','','')
	endif

	" remove double empty lines (i.e. from two conecutive empty lines
	" the first one is deleted, the second remains), if the line was
	" removed we do not need to add 1 to l:i (this is the role of
	" l:rem).
	if g:atp_compare_double_empty_lines == 0 && l:i< len(l:buffer)-2
	    if l:buffer[l:i] =~ '^\s*$' && l:buffer[l:i+1] =~ '^\s*$'
		call remove(l:buffer,l:i)
		let l:rem=1
	    endif
	endif
	if l:rem == 0
	    let l:i+=1
	endif
    endwhile
    endif
 
    " do the same with a:file
    let l:file=filter(a:file, 'v:val !~ "^\s*%"')

    let l:i = 0
    if g:atp_compare_double_empty_lines == 0 || g:atp_compare_embedded_comments == 0
    while l:i < len(l:file)-1
	let l:rem=0
	" remove comment lines at the end of a line
	if g:atp_compare_embedded_comments == 0
	    let l:file[l:i] = substitute(a:file[l:i],'%.*$','','')
	endif
	
	" remove double empty lines (i.e. from two conecutive empty lines
	" the first one is deleted, the second remains), if the line was
	" removed we do not need to add 1 to l:i (this is the role of
	" l:rem).
	if g:atp_compare_double_empty_lines == 0 && l:i < len(l:file)-2
	    if l:file[l:i] =~ '^\s*$' && l:file[l:i+1] =~ '^\s*$'
		call remove(l:file,l:i)
		let l:rem=1
	    endif
	endif
	if l:rem == 0
	    let l:i+=1
	endif
    endwhile
    endif

"     This is the way to make it not sensitive on new line signs.
"     let file_j		= join(l:file)
"     let buffer_j	= join(l:buffer)
"     return file_j !=# buffer_j

    return l:file !=# l:buffer
endfunction
" function! atplib#compiler#sompare(file) 
"     return Compare(a:file)
" endfunction
" This is very fast (0.002 sec on file with 2500 lines) 
" but the proble is that vimgrep greps the buffer rather than the file! 
" so it will not indicate any differences.
function! atplib#compiler#NewCompare()
    let line 		= getline(".")
    let lineNr		= line(".")
    let saved_loclist 	= getloclist(0)
    try
	exe "lvimgrep /^". escape(line, '\^$') . "$/j " . fnameescape(expand("%:p"))
    catch /E480:/ 
    endtry
"     call setloclist(0, saved_loclist)
    let loclist		= getloclist(0)
    call map(loclist, "v:val['lnum']")
    return !(index(loclist, lineNr)+1)
endfunction

"}}}

" This function copies the file a:input to a:output
"{{{ atplib#compiler#copy
function! atplib#compiler#copy(input,output)
	call writefile(readfile(a:input),a:output)
endfunction
"}}}
"{{{ atplib#compiler#GetSid
function! atplib#compiler#GetSid()
    return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\ze.*$')
endfunction 
let atplib#compiler#compiler_SID = atplib#compiler#GetSid() "}}}
"{{{ atplib#compiler#SidWrap
function! atplib#compiler#SidWrap(func)
    return atplib#compiler#compiler_SID . a:func
endfunction "}}}
" {{{ atplib#compiler#SetBiberSettings
function! atplib#compiler#SetBiberSettings()
    if b:atp_BibCompiler !~# '^\s*biber\>'
	return
    elseif !exists("atplib#compiler#biber_keep_done")
	let atplib#compiler#biber_keep_done = 1
	if index(g:atp_keep, "run.xml") == -1
	    let g:atp_keep += [ "run.xml" ]
	endif
	if index(g:atp_keep, "bcf") == -1
	    let g:atp_keep += [ "bcf" ]
	endif
    endif
endfunction "}}}
" {{{ atplib#compiler#IsRunning
" This function checks if program a:program is running a file a:file.
" a:file should be full path to the file.
function! atplib#compiler#IsRunning(program, file, ...)
    " Since there is an issue in psutil on OS X, we cannot run this function:
    " http://code.google.com/p/psutil/issues/detail?id=173
    " Reported by F.Heiderich.
    if has("mac") || has("gui_mac")
	let atplib#compiler#running=1
	return atplib#compiler#running
    endif

let s:return_is_running=0
python << EOF
import vim, psutil, os, pwd
from psutil import NoSuchProcess
x=0
program =vim.eval("a:program")
f       =vim.eval("a:file")
pat     ="|".join(vim.eval("a:000"))
for pid in psutil.get_pid_list():
    try:
        p=psutil.Process(pid)
        if p.username == pwd.getpwuid(os.getuid())[0] and re.search(program, p.cmdline[0]):
            for arg in p.cmdline:
                if arg == f or re.search(pat, arg):
                    x=1
                    break
        if x:
            break
    except psutil.error.NoSuchProcess:
        pass
    except psutil.error.AccessDenied:
        pass
    except IndexError:
        pass
vim.command("let s:return_is_running="+str(x))
EOF
let l:return=s:return_is_running
unlet s:return_is_running
return l:return
endfunction
" }}}
"{{{ atplib#compiler#KillAll
" This function kills all running latex processes.
" a slightly better approach would be to kill compile.py scripts
" the argument is a list of pids
" a:1 if present supresses a message.
function! atplib#compiler#Kill(bang)
    if !has("python")
	if a:bang != "!"
	    echohl WarningMsg
	    echomsg "[ATP:] you need python suppor" 
	    echohl Normal
	endif
	return
    endif
    if len(b:atp_LatexPIDs)
	call atplib#KillPIDs(b:atp_LatexPIDs)
    endif
    if len(b:atp_PythonPIDs)
	call atplib#KillPIDs(b:atp_PythonPIDs)
    endif
    let b:atp_ProgressBar={}
endfunction

"}}}

" THE MAIN COMPILER FUNCTIONs:
" This function is called to run TeX compiler and friends as many times as necessary.
" Makes references and bibliographies (supports bibtex), indexes.  
"{{{ atplib#compiler#MakeLatex
" Function Arguments:
function! atplib#compiler#MakeLatex(bang, mode, start)

    if a:mode =~# '^s\%[ilent]$'
	let mode = 'silent'
    elseif a:mode =~# '^d\%[ebug]$'
	let mode = 'debug'
    elseif a:mode =~# 'D\%[ebug]$'
	let mode = 'Debug'
    elseif a:mode =~#  '^v\%[erbose]$'
	let mode = 'debug'
    else
	let mode = t:atp_DebugMode
    endif

    " and a:bang are not yet used by makelatex.py
    let PythonMakeLatexPath = split(globpath(&rtp, "ftplugin/ATP_files/makelatex.py"), "\n")[0]
    let interaction 	    = ( mode=="verbose" ? b:atp_VerboseLatexInteractionMode : 'nonstopmode' )
    let tex_options	    = shellescape(b:atp_TexOptions.',-interaction='.interaction)
    let ext			= get(g:atp_CompilersDict, matchstr(b:atp_TexCompiler, '^\s*\zs\S\+\ze'), ".pdf") 
    let ext			= substitute(ext, '\.', '', '')
    let global_options 		= join((exists("g:atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? g:atp_{matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')}Options : []), ";")
    let local_options 		= join((exists("b:atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? getbufvar(bufnr("%"), "atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") : []), ";")
    if global_options !=  "" 
	let viewer_options  	= global_options.";".local_options
    else
	let viewer_options  	= local_options
    endif
    let reload_viewer 		= ( index(g:atp_ReloadViewers, b:atp_Viewer)+1  ? ' --reload-viewer ' : '' )
    let reload_on_error 	= ( b:atp_ReloadOnError ? ' --reload-on-error ' : '' )
    let bibliographies 		= join(keys(filter(copy(b:TypeDict), "v:val == 'bib'")), ',')

    let cmd=g:atp_Python." ".PythonMakeLatexPath.
		\ " --texfile ".shellescape(atplib#FullPath(b:atp_MainFile)).
		\ " --start ".a:start.
		\ " --output-format ".ext.
		\ " --verbose ".mode.
		\ " --cmd ".b:atp_TexCompiler.
		\ " --bibcmd ".b:atp_BibCompiler.
		\ " --bibliographies ".shellescape(bibliographies).
		\ " --outdir ".shellescape(b:atp_OutDir).
		\ " --keep ". shellescape(join(g:atp_keep, ',')).
		\ " --tex-options ".tex_options.
		\ " --servername ".v:servername.
		\ " --viewer ".shellescape(b:atp_Viewer).
		\ " --xpdf-server ".shellescape(b:atp_XpdfServer).
		\ " --viewer-options ".shellescape(viewer_options).
		\ " --progname ".v:progname.
		\ " --tempdir ".shellescape(g:atp_TempDir).
		\ (t:atp_DebugMode=='verbose'||mode=='verbose'?' --env ""': " --env ".shellescape(b:atp_TexCompilerVariable)).
		\ reload_viewer . reload_on_error
    unlockvar g:atp_TexCommand
    let g:atp_TexCommand=cmd
    lockvar g:atp_TexCommand

    " Write file
    call atplib#write("silent")

    if mode == "verbose"
	exe ":!".cmd
    elseif has("win16") || has("win32") || has("win64")
	let output=system(cmd)
    else
	let output=system(cmd." &")
    endif
endfunction

"}}}
" {{{ atplib#compiler#PythonCompiler
function! atplib#compiler#PythonCompiler(bibtex, start, runs, verbose, command, filename, bang)

    " Kill comiple.py scripts if there are too many of them.
    if len(b:atp_PythonPIDs) >= b:atp_MaxProcesses && b:atp_MaxProcesses
	let a=copy(b:atp_LatexPIDs)
	try
	    if b:atp_KillYoungest
		" Remove the newest PIDs (the last in the b:atp_PythonPIDs)
		let pids=remove(b:atp_LatexPIDs, b:atp_MaxProcesses, -1) 
	    else
		" Remove the oldest PIDs (the first in the b:atp_PythonPIDs) /works nicely/
		let pids=remove(b:atp_LatexPIDs, 0, max([len(b:atp_PythonPIDs)-b:atp_MaxProcesses-1,0]))
	    endif
	    echomsg string(a)." ".string(pids)." ".string(b:atp_LatexPIDs)
	    call atplib#KillPIDs(pids)
	catch E684:
	endtry
	echomsg string(b:atp_LatexPIDs)
    endif

    " Set biber setting on the fly
    call atplib#compiler#SetBiberSettings()

    if !has('gui') && a:verbose == 'verbose' && len(b:atp_LatexPIDs) > 0
	redraw!
	echomsg "[ATP:] please wait until compilation stops."
	return

	" This is not working: (I should kill compile.py scripts)
	echomsg "[ATP:] killing all instances of ".get(g:CompilerMsg_Dict,b:atp_TexCompiler,'TeX')
	call atplib#KillPIDs(b:atp_LatexPIDs,1)
	sleep 1
	PID
    endif

    " Debug varibles
    " On Unix the output of compile.py run by this function is available at
    " g:atp_TempDir/compiler.py.log
    if g:atp_debugPythonCompiler
	call atplib#Log("PythonCompiler.log", "", "init")
	call atplib#Log("PythonCompiler.log", "a:bibtex=".a:bibtex)
	call atplib#Log("PythonCompiler.log", "a:start=".a:start)
	call atplib#Log("PythonCompiler.log", "a:runs=".a:runs)
	call atplib#Log("PythonCompiler.log", "a:verbose=".a:verbose)
	call atplib#Log("PythonCompiler.log", "a:command=".a:command)
	call atplib#Log("PythonCompiler.log", "a:filename=".a:filename)
	call atplib#Log("PythonCompiler.log", "a:bang=".a:bang)
    endif

    if !exists("t:atp_DebugMode")
	let t:atp_DebugMode = g:atp_DefaultDebugMode
    endif

    if t:atp_DebugMode != 'verbose' && a:verbose != 'verbose'
	let b:atp_LastLatexPID = -1
    endif
    
    if t:atp_DebugMode != "silent" && b:atp_TexCompiler !~ "luatex" &&
		\ (b:atp_TexCompiler =~ "^\s*\%(pdf\|xetex\)" && b:atp_Viewer == "xdvi" ? 1 :  
		\ b:atp_TexCompiler !~ "^\s*pdf" && b:atp_TexCompiler !~ "xetex" &&  (b:atp_Viewer == "xpdf" || b:atp_Viewer == "epdfview" || b:atp_Viewer == "acroread" || b:atp_Viewer == "kpdf"))
	 
	echohl WaningMsg | echomsg "[ATP:] your ".b:atp_TexCompiler." and ".b:atp_Viewer." are not compatible:" 
	echomsg "       b:atp_TexCompiler=" . b:atp_TexCompiler	
	echomsg "       b:atp_Viewer=" . b:atp_Viewer	
    endif
    if !has('clientserver')
	if has("win16") || has("win32") || has("win64") || has("win95")
	    echohl WarningMsg
	    echomsg "[ATP:] ATP needs +clientserver vim compilation option."
	    echohl Normal
	else
	    echohl WarningMsg
	    echomsg "[ATP:] python compiler needs +clientserver vim compilation option."
	    echomsg "       falling back to g:atp_Compiler=\"bash\""
	    echohl Normal
	    let g:atp_Compiler = "bash"
	    return
	endif
    endif


    " Set options for compile.py
    let interaction 		= ( a:verbose=="verbose" ? b:atp_VerboseLatexInteractionMode : 'nonstopmode' )
    let tex_options		= b:atp_TexOptions.',-interaction='.interaction
"     let g:tex_options=tex_options
    let ext			= get(g:atp_CompilersDict, matchstr(b:atp_TexCompiler, '^\s*\zs\S\+\ze'), ".pdf") 
    let ext			= substitute(ext, '\.', '', '')

    let global_options 		= join((exists("g:atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? g:atp_{matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')}Options : []), ";") 
    let local_options 		= join(( exists("atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? getbufvar(bufnr("%"), "atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") : []), ";")
    if global_options !=  "" 
	let viewer_options  	= global_options.";".local_options
    else
	let viewer_options  	= local_options
    endif
    let bang 			= ( a:bang == '!' ? ' --bang ' : '' ) 
    let bibtex 			= ( a:bibtex ? ' --bibtex ' : '' )
    let reload_on_error 	= ( b:atp_ReloadOnError ? ' --reload-on-error ' : '' )
    let gui_running 		= ( has("gui_running") ? ' --gui-running ' : '' )
    let reload_viewer 		= ( index(g:atp_ReloadViewers, b:atp_Viewer)+1  ? ' --reload-viewer ' : '' )
    let aucommand 		= ( a:command == "AU" ? ' --aucommand ' : '' )
    let no_progress_bar 	= ( g:atp_ProgressBar ? '' : ' --no-progress-bar ' )
    let bibliographies 		= join(keys(filter(copy(b:TypeDict), "v:val == 'bib'")), ',')
    let autex_wait		= ( b:atp_autex_wait ? ' --autex_wait ' : '') 

    " Set the command
    let cmd=g:atp_Python." ".g:atp_PythonCompilerPath." --command ".b:atp_TexCompiler
		\ ." --tex-options ".shellescape(tex_options)
		\ ." --verbose ".a:verbose
		\ ." --file ".shellescape(atplib#FullPath(a:filename))
		\ ." --output-format ".ext
		\ ." --runs ".a:runs
		\ ." --servername ".v:servername
		\ ." --start ".a:start 
		\ ." --viewer ".shellescape(b:atp_Viewer)
		\ ." --xpdf-server ".shellescape(b:atp_XpdfServer)
		\ ." --viewer-options ".shellescape(viewer_options) 
		\ ." --keep ". shellescape(join(g:atp_keep, ','))
		\ ." --progname ".v:progname
		\ ." --bibcommand ".b:atp_BibCompiler
		\ ." --bibliographies ".shellescape(bibliographies)
		\ ." --logdir ".shellescape(g:atp_TempDir)
		\ .(t:atp_DebugMode=='verbose'||a:verbose=='verbose'?' --env ""': " --env ".shellescape(b:atp_TexCompilerVariable))
		\ . bang . bibtex . reload_viewer . reload_on_error . gui_running . aucommand . no_progress_bar
		\ . autex_wait

    " Write file
    if g:atp_debugPythonCompiler
	call atplib#Log("PythonCompiler.log", "PRE WRITING b:atp_changedtick=".b:atp_changedtick." b:changedtick=".b:changedtick)
    endif

    call atplib#write("silent")

    if g:atp_debugPythonCompiler
	call atplib#Log("PythonCompiler.log", "POST WRITING b:atp_changedtick=".b:atp_changedtick." b:changedtick=".b:changedtick)
    endif
    unlockvar g:atp_TexCommand
    let g:atp_TexCommand	= cmd
    lockvar g:atp_TexCommand

    " Call compile.py
    let b:atp_running += ( a:verbose != "verbose" ?  1 : 0 )
    if a:verbose == "verbose"
	exe ":!".cmd
    elseif g:atp_debugPythonCompiler && has("unix") 
	call system(cmd." 2".g:atp_TempDir."/PythonCompiler.log &")
    elseif has("win16") || has("win32") || has("win64")
	call system(cmd)
    else
	call system(cmd." &")
    endif
    if g:atp_debugPythonCompiler
	call atplib#Log("PythonCompiler.log", "END b:atp_changedtick=".b:atp_changedtick." b:changedtick=".b:changedtick)
    endif
endfunction
" }}}
" {{{ atplib#compiler#Compiler 
" This is the MAIN FUNCTION which sets the command and calls it.
" NOTE: the <filename> argument is not escaped!
" a:verbose	= silent/verbose/debug
" 	debug 	-- switch to show errors after compilation.
" 	verbose -- show compiling procedure.
" 	silent 	-- compile silently (gives status information if fails)
" a:start	= 0/1/2
" 		1 start viewer
" 		2 start viewer and make reverse search
"
function! atplib#compiler#Compiler(bibtex, start, runs, verbose, command, filename, bang)
    
    " Set biber setting on the fly
    call atplib#compiler#SetBiberSettings()

    if !has('gui') && a:verbose == 'verbose' && b:atp_running > 0
	redraw!
	echomsg "[ATP:] please wait until compilation stops."
	return
    endif

    if g:atp_debugCompiler
	exe "redir! > ".g:atp_TempDir."/Compiler.log"
	silent echomsg "________ATP_COMPILER_LOG_________"
	silent echomsg "changedtick=" . b:changedtick . " atp_changedtick=" . b:atp_changedtick
	silent echomsg "a:bibtex=" . a:bibtex . " a:start=" . a:start . " a:runs=" . a:runs . " a:verbose=" . a:verbose . " a:command=" . a:command . " a:filename=" . a:filename . " a:bang=" . a:bang
	silent echomsg "1 b:changedtick=" . b:changedtick . " b:atp_changedtick" . b:atp_changedtick . " b:atp_running=" .  b:atp_running
    endif

    if has('clientserver') && !empty(v:servername) && g:atp_callback && a:verbose != 'verbose'
	let b:atp_running+=1
    endif
    call atplib#outdir()
    	" IF b:atp_TexCompiler is not compatible with the viewer
	" ToDo: (move this in a better place). (luatex can produce both pdf and dvi
	" files according to options so this is not the right approach.) 
	if !exists("t:atp_DebugMode")
	    let t:atp_DebugMode = g:atp_DefaultDebugMode
	endif
	if t:atp_DebugMode !=? "silent" && b:atp_TexCompiler !~? "luatex" &&
		    \ (b:atp_TexCompiler =~ "^\s*\%(pdf\|xetex\)" && b:atp_Viewer == "xdvi" ? 1 :  
		    \ b:atp_TexCompiler !~ "^\s*pdf" && b:atp_TexCompiler !~ "xetex" &&  (b:atp_Viewer == "xpdf" || b:atp_Viewer == "epdfview" || b:atp_Viewer == "acroread" || b:atp_Viewer == "kpdf"))
	     
	    echohl WaningMsg | echomsg "[ATP:] your ".b:atp_TexCompiler." and ".b:atp_Viewer." are not compatible:" 
	    echomsg "       b:atp_TexCompiler=" . b:atp_TexCompiler	
	    echomsg "       b:atp_Viewer=" . b:atp_Viewer	
	endif

	" there is no need to run more than atplib#compiler#runlimit (=5) consecutive runs
	" this prevents from running tex as many times as the current line
	" what can be done by a mistake using the range for the command.
	if a:runs > atplib#compiler#runlimit
	    let runs = atplib#compiler#runlimit
	else
	    let runs = a:runs
	endif

	let tmpdir=b:atp_TempDir . matchstr(tempname(), '\/\w\+\/\d\+')
	let tmpfile=atplib#append(tmpdir, "/") . fnamemodify(a:filename,":t:r")
	if g:atp_debugCompiler
	    let g:tmpdir=tmpdir
	    let g:tmpfile=tmpfile
	endif
	call system("mkdir -m 0700 -p ".shellescape(tmpdir))
" 	if exists("*mkdir")
" 	    call mkdir(tmpdir, "p", 0700)
" 	else
" 	    echoerr "[ATP:] Your vim doesn't have mkdir function, please try the python compiler."
" 	    return
" 	endif

	" SET THE NAME OF OUTPUT FILES
	" first set the extension pdf/dvi
	let ext	= get(g:atp_CompilersDict, matchstr(b:atp_TexCompiler, '^\s*\zs\S\+\ze'), ".pdf") 

	" check if the file is a symbolic link, if it is then use the target
	" name.
	let link=system("readlink " . a:filename)
	if link != ""
	    let basename=fnamemodify(link,":r")
	else
	    let basename=a:filename
	endif

	" finally, set the output file names. 
	let outfile 	= b:atp_OutDir . fnamemodify(basename,":t:r") . ext
	let outaux  	= b:atp_OutDir . fnamemodify(basename,":t:r") . ".aux"
	let outbbl  	= b:atp_OutDir . fnamemodify(basename,":t:r") . ".bbl"
	let tmpaux  	= fnamemodify(tmpfile, ":r") . ".aux"
	let tmpbbl  	= fnamemodify(tmpfile, ":r") . ".bbl"
	let tmptex  	= fnamemodify(tmpfile, ":r") . ".tex"
	let outlog  	= b:atp_OutDir . fnamemodify(basename,":t:r") . ".log"
	let syncgzfile 	= b:atp_OutDir . fnamemodify(basename,":t:r") . ".synctex.gz"
	let syncfile 	= b:atp_OutDir . fnamemodify(basename,":t:r") . ".synctex"

"	COPY IMPORTANT FILES TO TEMP DIRECTORY WITH CORRECT NAME 
"	except log and aux files.
	let list	= copy(g:atp_keep)
	call filter(list, 'v:val != "log"')
	for i in list
	    let ftc	= b:atp_OutDir . fnamemodify(basename,":t:r") . "." . i
	    if filereadable(ftc)
		call atplib#compiler#copy(ftc,tmpfile . "." . i)
	    endif
	endfor

" 	HANDLE XPDF RELOAD 
	let reload_viewer = ( index(g:atp_ReloadViewers, b:atp_Viewer) == '-1' ? ' --reload-viewer ' : '' )
	if b:atp_Viewer =~ '^\s*xpdf\>' && reload_viewer
	    if a:start
		"if xpdf is not running and we want to run it.
		let Reload_Viewer = b:atp_Viewer . " -remote " . shellescape(b:atp_XpdfServer) . " " . shellescape(outfile) . " ; "
	    else
" TIME: this take 1/3 of time! 0.039
		call atplib#compiler#xpdfpid()
		" I could use here atplib#compiler#XpdPid(), the reason to not use it is that
		" then there is a way to run ATP without python.
		if atplib#compiler#xpdfpid != ""
		    "if xpdf is running (then we want to reload it).
		    "This is where I use 'ps' command to check if xpdf is
		    "running.
		    let Reload_Viewer = b:atp_Viewer . " -remote " . shellescape(b:atp_XpdfServer) . " -reload ; "
		else
		    "if xpdf is not running (but we do not want
		    "to run it).
		    let Reload_Viewer = " "
		endif
	    endif
	else
	    if a:start
		" if b:atp_Viewer is not running and we want to open it.
		" the name of this variable is not missleading ...
		let Reload_Viewer = b:atp_Viewer . " " . shellescape(outfile) . " ; "
		" If run through RevSearch command use source specials rather than
		" just reload:
		if str2nr(a:start) == 2
		    let synctex		= atplib#compiler#SidWrap('SyncTex')
		    let callback_rs_cmd = v:progname . " --servername " . v:servername . " --remote-expr " . "'".synctex."()' ; "
		    let Reload_Viewer	= callback_rs_cmd
		endif
	    else
		" If b:atp_Viewer is not running then we do not want to
		" open it.
		let Reload_Viewer = " "
	    endif	
	endif
	if g:atp_debugCompiler
	    let g:Reload_Viewer = Reload_Viewer
	endif

" 	IF OPENING NON EXISTING OUTPUT FILE
"	only xpdf needs to be run before (we are going to reload it)
	if a:start && b:atp_Viewer == "xpdf"
	    let xpdf_options	= ( exists("g:atp_xpdfOptions")  ? join(g:atp_xpdfOptions, " ") : "" )." ".(exists("b:xpdfOptions") ? join(getbufvar(0, "atp_xpdfOptions"), " ") : " ")
	    let start 	= b:atp_Viewer . " -remote " . shellescape(b:atp_XpdfServer) . " " . xpdf_options . " & "
	else
	    let start = ""	
	endif

"	SET THE COMMAND 
	let interaction = ( a:verbose=="verbose" ? b:atp_VerboseLatexInteractionMode : 'nonstopmode' )
	let variable	= ( a:verbose!="verbose" ? substitute(b:atp_TexCompilerVariable, ';', ' ', 'g') : '' ) 
	let comp	= variable . " " . b:atp_TexCompiler . " " . substitute(b:atp_TexOptions, ',', ' ','g') . " -interaction=" . interaction . " -output-directory=" . shellescape(tmpdir) . " " . shellescape(a:filename)
	let vcomp	= variable . " " . b:atp_TexCompiler . " " . substitute(b:atp_TexOptions, ',', ' ','g')  . " -interaction=". interaction . " -output-directory=" . shellescape(tmpdir) .  " " . shellescape(a:filename)
	
	" make function:
" 	let make	= "vim --servername " . v:servername . " --remote-expr 'MakeLatex\(\"".tmptex."\",1,0\)'"

	if a:verbose == 'verbose' 
	    let texcomp=vcomp
	else
	    let texcomp=comp
	endif
	if runs >= 2 && a:bibtex != 1
	    " how many times we want to call b:atp_TexCompiler
	    let i=1
	    while i < runs - 1
		let i+=1
		let texcomp=texcomp . " ; " . comp
	    endwhile
	    if a:verbose != 'verbose'
		let texcomp=texcomp . " ; " . comp
	    else
		let texcomp=texcomp . " ; " . vcomp
	    endif
	endif
	
	if a:bibtex == 1
	    " this should be decided using the log file as well.
	    if filereadable(outaux)
" 		call atplib#compiler#copy(outaux,tmpfile . ".aux")
		let texcomp="bibtex " . shellescape(fnamemodify(outaux, ":t")) . "; ".g:atp_cpcmd." ".shellescape(outbbl)." ".shellescape(tmpbbl).";" . comp . "  1>/dev/null 2>&1 "
	    else
		let texcomp=comp.";clear;".g:atp_cpcmd." ".shellescape(tmpaux)." ".shellescape(outaux)."; bibtex ".shellescape(fnamemodify(outaux, ":t")).";".g:atp_cpcmd." ".shellescape(outbbl)." ".shellescape(tmpbbl)."; ".comp." 1>/dev/null 2>&1 "
	    endif
	    if a:verbose != 'verbose'
		let texcomp=texcomp . " ; " . comp
	    else
		let texcomp=texcomp . " ; " . vcomp
	    endif
	endif

	" catch the status
	if has('clientserver') && v:servername != "" && g:atp_callback == 1

	    let catchstatus_cmd = v:progname . ' --servername ' . v:servername . ' --remote-expr ' . 
			\ shellescape('atplib#callback#TexReturnCode')  . '\($?\) ; ' 
	else
	    let catchstatus_cmd = ''
	endif

	" copy output file (.pdf\|.ps\|.dvi)
" 	let cpoptions	= "--remove-destination"
	let cpoptions	= ""
	let cpoutfile	= g:atp_cpcmd." ".cpoptions." ".shellescape(atplib#append(tmpdir,"/"))."*".ext." ".shellescape(atplib#append(b:atp_OutDir,"/"))." ; "

	if a:start
	    let command	= "(" . texcomp . " ; (" . catchstatus_cmd . " " . cpoutfile . " " . Reload_Viewer . " ) || ( ". catchstatus_cmd . " " . cpoutfile . ") ; " 
	else
	    " 	Reload on Error:
	    " 	for xpdf it copies the out file but does not reload the xpdf
	    " 	server for other viewers it simply doesn't copy the out file.
	    if b:atp_ReloadOnError || a:bang == "!"
		if a:bang == "!"
		    let command="( ".texcomp." ; ".catchstatus_cmd." ".g:atp_cpcmd." ".cpoptions." ".shellescape(tmpaux)." ".shellescape(b:atp_OutDir)." ; ".cpoutfile." ".Reload_Viewer 
		else
		    let command="( (".texcomp." && ".g:atp_cpcmd." ".cpoptions." ".shellescape(tmpaux)." ".shellescape(b:atp_OutDir)." ) ; ".catchstatus_cmd." ".cpoutfile." ".Reload_Viewer 
		endif
	    else
		if b:atp_Viewer =~ '\<xpdf\>'
		    let command="( ".texcomp." && (".catchstatus_cmd.cpoutfile." ".Reload_Viewer." ".g:atp_cpcmd." ".cpoptions." ".shellescape(tmpaux)." ".shellescape(b:atp_OutDir)." ) || (".catchstatus_cmd." ".cpoutfile.") ; " 
		else
		    let command="(".texcomp." && (".catchstatus_cmd.cpoutfile." ".Reload_Viewer." ".g:atp_cpcmd." ".cpoptions." ".shellescape(tmpaux)." ".shellescape(b:atp_OutDir)." ) || (".catchstatus_cmd.") ; " 
		endif
	    endif
	endif

    if g:atp_debugCompiler
	silent echomsg "Reload_Viewer=" . Reload_Viewer
	let g:Reload_Viewer 	= Reload_Viewer
	let g:command		= command
    elseif g:atp_debugCompiler >= 2 
	silent echomsg "command=" . command
    endif

	" Preserve files with extension belonging to the g:atp_keep list variable.
	let copy_cmd=""
	let j=1
	for i in g:atp_keep 
" ToDo: this can be done using internal vim functions.
	    if i != "aux"
		let copycmd=g:atp_cpcmd." ".cpoptions." ".shellescape(atplib#append(tmpdir,"/")).
			    \ "*.".i." ".shellescape(atplib#append(b:atp_OutDir,"/")) 
	    else
		let copycmd=g:atp_cpcmd." ".cpoptions." ".shellescape(atplib#append(tmpdir,"/")).
			    \ "*.".i." ".shellescape(atplib#append(b:atp_OutDir,"/".fnamemodify(b:atp_MainFile, ":t:r")."_aux")) 
	    endif

	    if j == 1
		let copy_cmd=copycmd
	    else
		let copy_cmd=copy_cmd . " ; " . copycmd	  
	    endif
	    let j+=1
	endfor
	if g:atp_debugCompiler
	    let g:copy_cmd = copy_cmd
	endif
	let command=command . " " . copy_cmd . " ; " 

	" Callback:
	if has('clientserver') && v:servername != "" && g:atp_callback == 1

" 	    let callback	= atplib#compiler#SidWrap('CallBack')
	    let callback_cmd 	= v:progname . ' --servername ' . v:servername . ' --remote-expr ' . 
				    \ shellescape('atplib#callback#CallBack').'\(\"'.a:verbose.'\",\"'.a:command.'\",\"'.a:bibtex.'\"\)'. " ; "

	    let command = command . " " . callback_cmd

	    if g:atp_debugCompiler
		silent echomsg "callback_cmd=" . callback_cmd
	    endif
	endif


 	let rmtmp="rm -rf " . shellescape(fnamemodify(tmpdir, ":h")) . "; "
	let command=command . " " . rmtmp . ") &"

	if str2nr(a:start) != 0 
	    let command=start . command
	endif

	" Take care about backup and writebackup options.
	if g:atp_debugCompiler
	    silent echomsg "BEFORE WRITING: b:changedtick=" . b:changedtick . " b:atp_changedtick=" . b:atp_changedtick . " b:atp_running=" .  b:atp_running
	endif

	call atplib#write("silent")

	if g:atp_debugCompiler
	    silent echomsg "AFTER WRITING: b:changedtick=" . b:changedtick . " b:atp_changedtick=" . b:atp_changedtick . " b:atp_running=" .  b:atp_running
	endif

	if a:verbose != 'verbose'
" "cd ".shellescape(tmpdir).";".
	    let g:atp_TexOutput=system(command)
	else
	    let command="!clear;" . texcomp . " " . cpoutfile . " " . copy_cmd
	    exe command
	endif

	unlockvar g:atp_TexCommand
	let g:atp_TexCommand=command
	lockvar g:atp_TexCommand

    if g:atp_debugCompiler
	silent echomsg "command=" . command
	redir END
    endif
endfunction
"}}}
"{{{ aptlib#compiler#ThreadedCompiler
function! atplib#compiler#ThreadedCompiler(bibtex, start, runs, verbose, command, filename, bang)

    " Write file:
    if g:atp_debugPythonCompiler
	call atplib#Log("ThreadedCompiler.log", "", "init")
	call atplib#Log("ThreadedCompiler.log", "PRE WRITING b:atp_changedtick=".b:atp_changedtick." b:changedtick=".b:changedtick)
    endif

    call atplib#write("silent")

    if g:atp_debugPythonCompiler
	call atplib#Log("ThreadedCompiler.log", "POST WRITING b:atp_changedtick=".b:atp_changedtick." b:changedtick=".b:changedtick)
    endif

    " Kill comiple.py scripts if there are too many of them.
    if len(b:atp_PythonPIDs) >= b:atp_MaxProcesses && b:atp_MaxProcesses
	let a=copy(b:atp_LatexPIDs)
	try
	    if b:atp_KillYoungest
		" Remove the newest PIDs (the last in the b:atp_PythonPIDs)
		let pids=remove(b:atp_LatexPIDs, b:atp_MaxProcesses, -1) 
	    else
		" Remove the oldest PIDs (the first in the b:atp_PythonPIDs) /works nicely/
		let pids=remove(b:atp_LatexPIDs, 0, max([len(b:atp_PythonPIDs)-b:atp_MaxProcesses-1,0]))
	    endif
	    echomsg string(a)." ".string(pids)." ".string(b:atp_LatexPIDs)
	    call atplib#KillPIDs(pids)
	catch E684:
	endtry
	echomsg string(b:atp_LatexPIDs)
    endif

    " Set biber setting on the fly
    call atplib#compiler#SetBiberSettings()

    if !has('gui') && a:verbose == 'verbose' && len(b:atp_LatexPIDs) > 0
	redraw!
	echomsg "[ATP:] please wait until compilation stops."
	return

	" This is not working: (I should kill compile.py scripts)
	echomsg "[ATP:] killing all instances of ".get(g:CompilerMsg_Dict,b:atp_TexCompiler,'TeX')
	call atplib#KillPIDs(b:atp_LatexPIDs,1)
	sleep 1
	PID
    endif

    " Debug varibles
    " On Unix the output of compile.py run by this function is available at
    " g:atp_TempDir/compiler.py.log
    if g:atp_debugPythonCompiler
	call atplib#Log("ThreadedCompiler.log", "", "init")
	call atplib#Log("ThreadedCompiler.log", "a:bibtex=".a:bibtex)
	call atplib#Log("ThreadedCompiler.log", "a:start=".a:start)
	call atplib#Log("ThreadedCompiler.log", "a:runs=".a:runs)
	call atplib#Log("ThreadedCompiler.log", "a:verbose=".a:verbose)
	call atplib#Log("ThreadedCompiler.log", "a:command=".a:command)
	call atplib#Log("ThreadedCompiler.log", "a:filename=".a:filename)
	call atplib#Log("ThreadedCompiler.log", "a:bang=".a:bang)
    endif

    if !exists("t:atp_DebugMode")
	let t:atp_DebugMode = g:atp_DefaultDebugMode
    endif

    if t:atp_DebugMode != 'verbose' && a:verbose != 'verbose'
	let b:atp_LastLatexPID = -1
    endif
    
    if t:atp_DebugMode != "silent" && b:atp_TexCompiler !~ "luatex" &&
		\ (b:atp_TexCompiler =~ "^\s*\%(pdf\|xetex\)" && b:atp_Viewer == "xdvi" ? 1 :  
		\ b:atp_TexCompiler !~ "^\s*pdf" && b:atp_TexCompiler !~ "xetex" &&  (b:atp_Viewer == "xpdf" || b:atp_Viewer == "epdfview" || b:atp_Viewer == "acroread" || b:atp_Viewer == "kpdf"))
	 
	echohl WaningMsg | echomsg "[ATP:] your ".b:atp_TexCompiler." and ".b:atp_Viewer." are not compatible:" 
	echomsg "       b:atp_TexCompiler=" . b:atp_TexCompiler	
	echomsg "       b:atp_Viewer=" . b:atp_Viewer	
    endif
    if !has('clientserver')
	if has("win16") || has("win32") || has("win64") || has("win95")
	    echohl WarningMsg
	    echomsg "[ATP:] ATP needs +clientserver vim compilation option."
	    echohl Normal
	else
	    echohl WarningMsg
	    echomsg "[ATP:] python compiler needs +clientserver vim compilation option."
	    echomsg "       falling back to g:atp_Compiler=\"bash\""
	    echohl Normal
	    let g:atp_Compiler = "bash"
	    return
	endif
    endif


    " Set options for compile.py
    let interaction 		= ( a:verbose=="verbose" ? b:atp_VerboseLatexInteractionMode : 'nonstopmode' )
    let tex_options		= b:atp_TexOptions.',-interaction='.interaction
"     let g:tex_options=tex_options
    let ext			= get(g:atp_CompilersDict, matchstr(b:atp_TexCompiler, '^\s*\zs\S\+\ze'), ".pdf") 
    let ext			= substitute(ext, '\.', '', '')

    let global_options 		= join((exists("g:atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? g:atp_{matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')}Options : []), ";") 
    let local_options 		= join(( exists("atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") ? getbufvar(bufnr("%"), "atp_".matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')."Options") : []), ";")
    if global_options !=  "" 
	let viewer_options  	= global_options.";".local_options
    else
	let viewer_options  	= local_options
    endif
    let file                    = atplib#FullPath(a:filename)
    let bang 			= ( a:bang == '!' ? ' --bang ' : '' ) 
    let bibtex 			= ( a:bibtex ? ' --bibtex ' : '' )
    let reload_on_error 	= ( b:atp_ReloadOnError ? ' --reload-on-error ' : '' )
    let gui_running 		= ( has("gui_running") ? ' --gui-running ' : '' )
    let reload_viewer 		= ( index(g:atp_ReloadViewers, b:atp_Viewer)+1  ? ' --reload-viewer ' : '' )
    let aucommand 		= ( a:command == "AU" ? ' --aucommand ' : '' )
    let no_progress_bar 	= ( g:atp_ProgressBar ? '' : ' --no-progress-bar ' )
    let bibliographies 		= join(keys(filter(copy(b:TypeDict), "v:val == 'bib'")), ',')
    let autex_wait		= ( b:atp_autex_wait ? ' --autex_wait ' : '') 
    let keep                    = join(g:atp_keep, ',')

python << ENDPYTHON
import vim, threading
import sys, errno, os.path, shutil, subprocess, psutil, re, tempfile, optparse, glob
import traceback, atexit

from os import chdir, mkdir, putenv, devnull
from collections import deque

####################################
#
#       Functions:   
#
####################################

def nonempty(string):
    if str(string) == '':
        return False
    else:
        return True

def decode_list(byte):
    return byte.decode()

def latex_progress_bar(cmd):
# Run latex and send data for progress bar,

    child = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    pid   = child.pid
    vim.eval("atplib#callback#LatexPID("+str(pid)+")")
    debug_file.write("latex pid "+str(pid)+"\n")
    stack = deque([])
    while True:
        try:
            out = child.stdout.read(1).decode()
        except UnicodeDecodeError:
            debug_file.write("UNICODE DECODE ERROR:\n")
            debug_file.write(child.stdout.read(1))
            debug_file.write("\n")
            debug_file.write("stack="+''.join(stack)+"\n")
            out = ""
        if out == '' and child.poll() != None:
            break
        if out != '':
            stack.append(out)

            if len(stack)>10:
                stack.popleft()
            match = re.match('\[(\n?\d(\n|\d)*)({|\])',str(''.join(stack)))
            if match:
                vim.eval("atplib#callback#ProgressBar("+match.group(1)[match.start():match.end()]+","+str(pid)+")")
    child.wait()
    vim.eval("atplib#callback#ProgressBar('end',"+str(pid)+")")
    vim.eval("atplib#callback#PIDsRunning(\"b:atp_LatexPIDs\")")
    return child

def xpdf_server_file_dict():
# Make dictionary of the type { xpdf_servername : [ file, xpdf_pid ] },

# to test if the server host file use:
# basename(xpdf_server_file_dict().get(server, ['_no_file_'])[0]) == basename(file)
# this dictionary always contains the full path (Linux).
# TODO: this is not working as I want to:
#    when the xpdf was opened first without a file it is not visible in the command line
#    I can use 'xpdf -remote <server> -exec "run('echo %f')"'
#    where get_filename is a simple program which returns the filename. 
#    Then if the file matches I can just reload, if not I can use:
#          xpdf -remote <server> -exec "openFile(file)"
    ps_list=psutil.get_pid_list()
    server_file_dict={}
    for pr in ps_list:
        try:
            name=psutil.Process(pr).name
            cmdline=psutil.Process(pr).cmdline
            if name == 'xpdf':
                try:
                    ind=cmdline.index('-remote')
                except:
                    ind=0
                if ind != 0 and len(cmdline) >= 1:
                    server_file_dict[cmdline[ind+1]]=[cmdline[len(cmdline)-1], pr]
        except psutil.error.NoSuchProcess:
            pass
        except psutil.error.AccessDenied:
            pass
    return server_file_dict


####################################
#
#       Options:   
#
####################################
tex_file        = vim.eval("b:atp_MainFile")
command         = vim.eval("b:atp_TexCompiler")
bibcommand      = vim.eval("b:atp_BibCompiler")
progname        = vim.eval("v:progname")
if vim.eval("aucommand") == ' --aucommand ':
    aucommand_bool  = True
    aucommand="AU"
else:
    aucommand_bool  = False
    aucommand="COM"
command_opt     = list(filter(nonempty,re.split('\s*,\s*', vim.eval("tex_options"))))
mainfile_fp     = vim.eval("file")
output_format   = vim.eval("ext")
if output_format == "pdf":
    extension = ".pdf"
else:
    extension = ".dvi"
runs            = int(vim.eval("a:runs"))
servername      = vim.eval("v:servername")
start           = str(vim.eval("a:start"))
viewer          = vim.eval("b:atp_Viewer")
if vim.eval("autex_wait") == "--autex_wait":
    autex_wait      = True
else:
    autex_wait      = False
XpdfServer      = vim.eval("b:atp_XpdfServer")
viewer_rawopt   = re.split('\s*;\s*', vim.eval("viewer_options"))
viewer_it       = list(filter(nonempty, viewer_rawopt))
viewer_opt      =[]
for opt in viewer_it:
    viewer_opt.append(opt)
viewer_rawopt   = viewer_opt
if viewer == "xpdf" and XpdfServer != None:
    viewer_opt.extend(["-remote", XpdfServer])
verbose         = vim.eval("a:verbose")
keep            = vim.eval("keep").split(',')
keep            = list(filter(nonempty, keep))

def keep_filter_aux(string):
    if string == 'aux':
        return False
    else:
        return True

def keep_filter_log(string):
    if string == 'log':
        return False
    else:
        return True

def mysplit(string):
        return re.split('\s*=\s*', string)

env             = list(map(mysplit, list(filter(nonempty, re.split('\s*;\s*',vim.eval("b:atp_TexCompilerVariable"))))))

# Boolean options
if vim.eval("reload_viewer") == ' --reload-viewer ':
    reload_viewer   = True
else:
    reload_viewer   = False
if vim.eval("bibtex") == ' --bibtex ':
    bibtex          = True
else:
    bibtex          = False
bibliographies  = vim.eval("bibliographies").split(",")
bibliographies  = list(filter(nonempty, bibliographies))
if vim.eval("a:bang") == "!":
    bang            = True
else:
    bang            = False
if vim.eval("reload_on_error") == ' --reload-on-error ':
    reload_on_error = True
else:
    reload_on_error = False
if vim.eval("gui_running") == ' --gui-running ':
    gui_running     = True
else:
    gui_running     = False
if vim.eval("no_progress_bar") == ' --no-progress-bar ':
    progress_bar    = False
else:
    progress_bar    = True

# Debug file should be changed for sth platform independent
# There should be a switch to get debug info.
logdir          = vim.eval("g:atp_TempDir")
script_logfile  = os.path.join(logdir, 'compile.log')
debug_file      = open(script_logfile, 'w')

debug_file.write("COMMAND "+command+"\n")
debug_file.write("BIBCOMMAND "+bibcommand+"\n")
debug_file.write("BIBCOMMAND "+bibcommand+"\n")
debug_file.write("AUCOMMAND "+aucommand+"\n")
debug_file.write("PROGNAME "+progname+"\n")
debug_file.write("COMMAND_OPT "+str(command_opt)+"\n")
debug_file.write("MAINFILE_FP "+str(mainfile_fp)+"\n")
debug_file.write("OUTPUT FORMAT "+str(output_format)+"\n")
debug_file.write("EXT "+extension+"\n")
debug_file.write("RUNS "+str(runs)+"\n")
debug_file.write("VIM_SERVERNAME "+str(servername)+"\n")
debug_file.write("START "+str(start)+"\n")
debug_file.write("VIEWER "+str(viewer)+"\n")
debug_file.write("XPDF_SERVER "+str(XpdfServer)+"\n")
debug_file.write("VIEWER_OPT "+str(viewer_opt)+"\n")
debug_file.write("DEBUG MODE (verbose) "+str(verbose)+"\n")
debug_file.write("KEEP "+str(keep)+"\n")
debug_file.write("BIBLIOGRAPHIES "+str(bibliographies)+"\n")
# debug_file.write("ENV OPTION "+str(options.env)+"\n")
debug_file.write("ENV "+str(env)+"\n")
debug_file.write("*BIBTEX "+str(bibtex)+"\n")
debug_file.write("*BANG "+str(bang)+"\n")
debug_file.write("*RELOAD_VIEWER "+str(reload_viewer)+"\n")
debug_file.write("*RELOAD_ON_ERROR "+str(reload_on_error)+"\n")
debug_file.write("*GUI_RUNNING "+str(gui_running)+"\n")
debug_file.write("*PROGRESS_BAR "+str(progress_bar)+"\n")

class LatexThread( threading.Thread ):
    def run( self ):
# Author: Marcin Szamotulski <mszamot[@]gmail[.]com>
# This file is a part of Automatic TeX Plugin for Vim.



# readlink is not available on Windows.
        readlink=True
        try:
            from os import readlink
        except ImportError:
            readlink=False

# Cleanup on exit:
        def cleanup(debug_file):
            debug_file.close()
            shutil.rmtree(tmpdir)
#         atexit.register(cleanup, debug_file)

####################################
#
#       Arguments:   
#
####################################
        global tex_file, command, bibcommand, progname, aucommand_bool, aucommand
        global command_opt, mainfile_fp, output_format, extension, runs, servername, start
        global viewer, autex_wait, XpdfServer, viewer_rawopt, viewer_it, viewer_opt
        global viewer_rawopt, verbose, keep, env
        global reload_viewer, bibtex, bibliographies, bang, reload_on_error, gui_running, progress_bar

# If mainfile_fp is not a full path make it. 
#     glob=glob.glob(os.path.join(os.getcwd(),mainfile_fp))
#     if len(glob) != 0:
#         mainfile_fp = glob[0]
        mainfile        = os.path.basename(mainfile_fp)
        mainfile_dir    = os.path.dirname(mainfile_fp)
        if mainfile_dir == "":
            mainfile_fp = os.path.join(os.getcwd(), mainfile)
            mainfile    = os.path.basename(mainfile_fp)
            mainfile_dir= os.path.dirname(mainfile_fp)
        if os.path.islink(mainfile_fp):
            if readlink:
                mainfile_fp = os.readlink(mainfile_fp)
            # The above line works if the symlink was created with full path. 
            mainfile    = os.path.basename(mainfile_fp)
            mainfile_dir= os.path.dirname(mainfile_fp)

        mainfile_dir    = os.path.normcase(mainfile_dir)
        [basename, ext] = os.path.splitext(mainfile)
        output_fp       = os.path.splitext(mainfile_fp)[0]+extension

        try:
            # Send pid to ATP:
            if verbose != "verbose":
                vim.eval("atplib#callback#PythonPID("+str(os.getpid())+")")
####################################
#
#       Make temporary directory,
#       Copy files and Set Environment:
#
####################################
            cwd     = os.getcwd()
            if not os.path.exists(os.path.join(mainfile_dir,".tmp")):
                    # This is the main tmp dir (./.tmp) 
                    # it will not be deleted by this script
                    # as another instance might be using it.
                    # it is removed by Vim on exit.
                os.mkdir(os.path.join(mainfile_dir,".tmp"))
            tmpdir  = tempfile.mkdtemp(dir=os.path.join(mainfile_dir,".tmp"),prefix="")
            debug_file.write("TMPDIR: "+tmpdir+"\n")
            tmpaux  = os.path.join(tmpdir,basename+".aux")

            command_opt.append('-output-directory='+tmpdir)
            latex_cmd      = [command]+command_opt+[mainfile_fp]
            debug_file.write("COMMAND "+str(latex_cmd)+"\n")
            debug_file.write("COMMAND "+" ".join(latex_cmd)+"\n")

# Copy important files to output directory:
# /except the log file/
            os.chdir(mainfile_dir)
            for ext in filter(keep_filter_log,keep):
                file_cp=basename+"."+ext
                if os.path.exists(file_cp):
                    shutil.copy(file_cp, tmpdir)

            tempdir_list = os.listdir(tmpdir)
            debug_file.write("\nls tmpdir "+str(tempdir_list)+"\n")

# Set environment
            for var in env:
                debug_file.write("ENV "+var[0]+"="+var[1]+"\n")
                os.putenv(var[0], var[1])

# Link local bibliographies:
            for bib in bibliographies:
                if os.path.exists(os.path.join(mainfile_dir,os.path.basename(bib))):
                    os.symlink(os.path.join(mainfile_dir,os.path.basename(bib)),os.path.join(tmpdir,os.path.basename(bib)))

####################################
#
#       Compile:   
#
####################################
# Start Xpdf (this can be done before compelation, because we can load file
# into afterwards) in this way Xpdf starts faster (it is already running when
# file compiles). 
# TODO: this might cause problems when the tex file is very simple and short.
# Can we test if xpdf started properly?  okular doesn't behave nicely even with
# --unique switch.

# Latex might not run this might happedn with bibtex (?)
            latex_returncode=0
            if bibtex and os.path.exists(tmpaux):
                if bibcommand == 'biber':
                    bibfname = basename
                else:
                    bibfname = basename+".aux"
                debug_file.write("\nBIBTEX1"+str([bibcommand, bibfname])+"\n")
                os.chdir(tmpdir)
                bibtex_popen=subprocess.Popen([bibcommand, bibfname], stdout=subprocess.PIPE)
                vim.eval("atplib#callback#BibtexPID('"+str(bibtex_popen.pid)+"')")
                vim.eval("atplib#callback#redrawstatus()")
                bibtex_popen.wait()
                vim.eval("atplib#callback#PIDsRunning(\"b:atp_BibtexPIDs\")")
                os.chdir(mainfile_dir)
                bibtex_returncode=bibtex_popen.returncode
                bibtex_output=re.sub('"', '\\"', bibtex_popen.stdout.read())
                debug_file.write("BIBTEX RET CODE "+str(bibtex_returncode)+"\nBIBTEX OUTPUT\n"+bibtex_output+"\n")
                if verbose != 'verbose':
                    vim.eval("atplib#callback#BibtexReturnCode('"+str(bibtex_returncode)+"',\""+str(bibtex_output)+"\")")
                else:
                    print(bibtex_output)
                # We need run latex at least 2 times
                bibtex=False
                runs=max([runs, 2])
# If bibtex contained errros we stop:
#     if not bibtex_returncode:
#         runs=max([runs, 2])
#     else:
#         runs=1
            elif bibtex:
                # we need run latex at least 3 times
                runs=max([runs, 3])

            debug_file.write("\nRANGE="+str(range(1,runs+1))+"\n")
            debug_file.write("RUNS="+str(runs)+"\n")
            for i in range(1, runs+1):
                debug_file.write("RUN="+str(i)+"\n")
                debug_file.write("DIR="+str(os.getcwd())+"\n")
                tempdir_list = os.listdir(tmpdir)
                debug_file.write("ls tmpdir "+str(tempdir_list)+"\n")
                debug_file.write("BIBTEX="+str(bibtex)+"\n")

                if verbose == 'verbose' and i == runs:
#       <SIS>compiler() contains here ( and not bibtex )
                    debug_file.write("VERBOSE"+"\n")
                    latex=subprocess.Popen(latex_cmd)
                    pid=latex.pid
                    debug_file.write("latex pid "+str(pid)+"\n")
                    latex.wait()
                    latex_returncode=latex.returncode
                    debug_file.write("latex ret code "+str(latex_returncode)+"\n")
                else:
                    if progress_bar and verbose != 'verbose':
                        latex=latex_progress_bar(latex_cmd)
                    else:
                        latex = subprocess.Popen(latex_cmd, stdout=subprocess.PIPE)
                        pid   = latex.pid
                        vim.eval("atplib#callback#LatexPID("+str(pid)+")")
                        debug_file.write("latex pid "+str(pid)+"\n")
                        latex.wait()
                        vim.eval("atplib#callback#PIDsRunning(\"b:atp_LatexPIDs\")")
                    latex_returncode=latex.returncode
                    debug_file.write("latex return code "+str(latex_returncode)+"\n")
                    tempdir_list = os.listdir(tmpdir)
                    debug_file.write("JUST AFTER LATEX ls tmpdir "+str(tempdir_list)+"\n")
                # Return code of compilation:
                if verbose != "verbose":
                    vim.eval("atplib#callback#TexReturnCode('"+str(latex_returncode)+"')")
                if bibtex and i == 1:
                    if bibcommand == 'biber':
                        bibfname = basename
                    else:
                        bibfname = basename+".aux"
                    debug_file.write("BIBTEX2 "+str([bibcommand, bibfname])+"\n")
                    debug_file.write(os.getcwd()+"\n")
                    tempdir_list = os.listdir(tmpdir)
                    debug_file.write("ls tmpdir "+str(tempdir_list)+"\n")
                    os.chdir(tmpdir)
                    bibtex_popen=subprocess.Popen([bibcommand, bibfname], stdout=subprocess.PIPE)
                    vim.eval("atplib#callback#BibtexPID('"+str(bibtex_popen.pid)+"')")
                    vim.eval("atplib#callback#redrawstatus()")
                    bibtex_popen.wait()
                    vim.eval("atplib#callback#PIDsRunning(\"b:atp_BibtexPIDs\")")
                    os.chdir(mainfile_dir)
                    bibtex_returncode=bibtex_popen.returncode
                    bibtex_output=re.sub('"', '\\"', bibtex_popen.stdout.read())
                    debug_file.write("BIBTEX2 RET CODE"+str(bibtex_returncode)+"\n")
                    if verbose != 'verbose':
                        vim.eval("atplib#callback#BibtexReturnCode('"+str(bibtex_returncode)+"',\""+str(bibtex_output)+"\")")
                    else:
                        print(bibtex_output)
# If bibtex had errors we stop, 
# at this point tex file was compiled at least once.
#         if bibtex_returncode:
#             debug_file.write("BIBTEX BREAKE "+str(bibtex_returncode)+"\n")
#             break

####################################
#
#       Copy Files:
#
####################################

# Copy files:
            os.chdir(tmpdir)
            for ext in list(filter(keep_filter_aux,keep))+[output_format]:
                file_cp=basename+"."+ext
                if os.path.exists(file_cp):
                    debug_file.write(file_cp+' ')
                    shutil.copy(file_cp, mainfile_dir)

# Copy aux file if there were no compilation errors or if it doesn't exists in mainfile_dir.
# copy aux file to _aux file (for atplib#tools#GrepAuxFile)
            if latex_returncode == 0 or not os.path.exists(os.path.join(mainfile_dir, basename+".aux")):
                file_cp=basename+".aux"
                if os.path.exists(file_cp):
                    shutil.copy(file_cp, mainfile_dir)
            file_cp=basename+".aux"
            if os.path.exists(file_cp):
                shutil.copy(file_cp, os.path.join(mainfile_dir, basename+"._aux"))
            os.chdir(cwd)

####################################
#
#       Call Back Communication:   
#
####################################
            if verbose != "verbose":
                debug_file.write("CALL BACK "+"atplib#callback#CallBack('"+str(verbose)+"','"+aucommand+"','"+str(bibtex)+"')"+"\n")
                vim.eval("atplib#callback#CallBack('"+str(verbose)+"','"+aucommand+"','"+str(bibtex)+"')")
                # return code of compelation is returned before (after each compilation).


####################################
#
#       Reload/Start Viewer:   
#
####################################
            if re.search(viewer, '^\s*xpdf\e') and reload_viewer:
                # The condition tests if the server XpdfServer is running
                xpdf_server_dict=xpdf_server_file_dict()
                cond = xpdf_server_dict.get(XpdfServer, ['_no_file_']) != ['_no_file_']
                debug_file.write("XPDF SERVER DICT="+str(xpdf_server_dict)+"\n")
                debug_file.write("COND="+str(cond)+":"+str(reload_on_error)+":"+str(bang)+"\n")
                debug_file.write("COND="+str( not reload_on_error or bang )+"\n")
                debug_file.write(str(xpdf_server_dict)+"\n")
                if start == 1:
                    run=['xpdf']
                    run.extend(viewer_opt)
                    run.append(output_fp)
                    debug_file.write("D1: "+str(run)+"\n")
                    subprocess.Popen(run)
                elif cond and ( reload_on_error or latex_returncode == 0 or bang ):
                    run=['xpdf', '-remote', XpdfServer, '-reload']
                    subprocess.Popen(run, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                    debug_file.write("D2: "+str(['xpdf',  '-remote', XpdfServer, '-reload'])+"\n")
            else:
                if start >= 1:
                    run=[viewer]
                    run.extend(viewer_opt)
                    run.append(output_fp)
                    debug_file.write("RUN "+str(run)+"\n")
                    subprocess.Popen(run, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                if start == 2:
                    vim.eval("atplib#SyncTex()")

####################################
#
#       Clean:
#
####################################
        except Exception:
            error_str=re.sub("'", "''",re.sub('"', '\\"', traceback.format_exc()))
            traceback.print_exc(None, debug_file)
            vim.eval("atplib#callback#Echo(\"[ATP:] error in compile.py, catched python exception:\n"+error_str+"[ATP info:] this error message is recorded in compile.py.log under g:atp_TempDir\",'echo','ErrorMsg')")

# 	cleanup(debug_file)
#         return(latex_returncode)

LatexThread().start()
ENDPYTHON
endfunction "}}}
" {{{ atplib#compiler#tex [test function]
function! atplib#compiler#tex()
python << ENDPYTHON
import vim, threading
import sys, errno, os.path, shutil, subprocess, psutil, re, tempfile, optparse, glob
import traceback, atexit

from os import chdir, mkdir, putenv, devnull
from collections import deque

class LatexThread( threading.Thread ):
    def run( self ):

        file=vim.eval("b:atp_MainFile")
        subprocess.Popen(['pdflatex', file], stdout=subprocess.PIPE)
 LatexThread().start()
ENDPYTHON
endfunction "}}}
" AUTOMATIC TEX PROCESSING:
" {{{ atplib#compiler#auTeX
" This function calls the compilers in the background. It Needs to be a global
" function (it is used in options.vim, there is a trick to put function into
" a dictionary ... )
augroup ATP_changedtick
    au!
    au BufEnter 	*.tex 	:let b:atp_changedtick = b:changedtick
    au BufWritePost 	*.tex 	:let b:atp_changedtick = b:changedtick
augroup END 

function! atplib#compiler#auTeX(...)

    if g:atp_debugauTeX
	echomsg "*****************"
	echomsg "b:atp_changedtick=".b:atp_changedtick." b:changedtick=".b:changedtick
    endif

    if mode() == 'i' && b:atp_updatetime_insert == 0 ||
		\ mode()=='n' && b:atp_updatetime_normal == 0
	if g:atp_debugauTeX
	    echomsg "autex is off for the mode: ".mode()
	endif
	return "autex is off for the mode: ".mode()." (see :help mode())"
    endif

    if mode() == 'i' && g:atp_noautex_in_math && atplib#IsInMath()
	return "noautex in math mode"
    endif


    " Wait if the compiler is running. The problem is that CursorHoldI autocommands
    " are not triggered more than once after 'updatetime'.
"     if index(split(g:atp_autex_wait, ','), mode()) != -1
" " 	\ !b:atp_autex_wait
" 	if g:atp_Compiler == "python"
" 	    call atplib#callback#PIDsRunning("b:atp_PythonPIDs")
" 	else
" 	    call atplib#callback#PIDsRunning("b:atp_LatexPIDs")
" 	endif
" 	call atplib#callback#PIDsRunning("b:atp_BibtexPIDs")
" 	echo string(b:atp_BibtexPIDs)
" 	if g:atp_Compiler == "python" && len(b:atp_PythonPIDs) ||
" 	    \ g:atp_Compiler == "bash" && len(b:atp_LatexPIDs) ||
" 	    \ len(b:atp_BibtexPIDs)
" " 	    unlockvar b:atp_autex_wait
" " 	    let b:atp_autex_wait=1
" " 	    lockvar b:atp_autex_wait
" 	    if g:atp_debugauTeX
" 		echomsg "autex wait"
" 	    endif
" 	    return
" 	endif
" "     else
" " 	unlockvar b:atp_autex_wait
" " 	let b:atp_autex_wait=0
" " 	lockvar b:atp_autex_wait
"     endif


    " Using vcscommand plugin the diff window ends with .tex thus the autocommand
    " applies but the filetype is 'diff' thus we can switch tex processing by:
    if &l:filetype !~ "tex$"
	echo "wrong file type"
	return "wrong file type"
    endif

    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)

    let mode 	= ( g:atp_DefaultDebugMode == 'verbose' ? 'debug' : g:atp_DefaultDebugMode )

    if !b:atp_autex
	if g:atp_debugauTeX
	   echomsg "autex is off"
	endif
	return "autex is off"
    endif

    " if the file (or input file is modified) compile the document 
    if filereadable(expand("%"))
" 	if !exists("b:atp_changedtick")
" 	    let b:atp_changedtick = b:changedtick
" 	endif
	if g:atp_Compare ==? "changedtick"
	    let cond = ( b:changedtick != b:atp_changedtick )
	else
	    let cond = ( atplib#compiler#compare(readfile(expand("%"))) )
	endif
	if g:atp_debugauTeX
	    let g:cond=cond
	    if g:atp_debugauTeX
		echomsg  "COND=".cond
	    endif
	endif
	if cond
	    " This is for changedtick only
	    let b:atp_changedtick = b:changedtick + 1
	    " +1 because atplib#compiler#Compiler saves the file what increases b:changedtick by 1.
	    " this is still needed as I use not nesting BufWritePost autocommand to set
	    " b:atp_changedtick (by default autocommands do not nest). Alternate solution is to
	    " run atplib#compiler#AuTeX() with nested autocommand (|autocmd-nested|). But this seems
	    " to be less user friendly, nested autocommands allows only 10 levels of
	    " nesting (which seems to be high enough).
	    
"
" 	if atplib#compiler#NewCompare()
	let g:debug=0
	    if g:atp_Compiler == 'python'
                if g:atp_devversion == 0
                    call atplib#compiler#PythonCompiler(0, 0, b:atp_auruns, mode, "AU", atp_MainFile, "")
                else
                    call atplib#compiler#ThreadedCompiler(0, 0, b:atp_auruns, mode, "AU", atp_MainFile, "")
                endif
	    else
		call atplib#compiler#Compiler(0, 0, b:atp_auruns, mode, "AU", atp_MainFile, "")
	    endif
	    redraw
	    if g:atp_debugauTeX
		echomsg "compile" 
	    endif
	    return "compile" 
	endif
    " if compiling for the first time
    else
	try 
	    " Do not write project script file while saving the file.
	    let atp_ProjectScript	= ( exists("g:atp_ProjectScript") ? g:atp_ProjectScript : -1 )
	    let g:atp_ProjectScript	= 0
	    w
	    if atp_ProjectScript == -1
		unlet g:atp_ProjectScript
	    else
		let g:atp_ProjectScript	= atp_ProjectScript
	    endif
	catch /E212:/
	    echohl ErrorMsg
	    if g:atp_debugauTeX
		echomsg expand("%") . "E212: Cannon open file for writing"
	    endif
	    echohl Normal
	    if g:atp_debugauTeX
		echomsg " E212"
	    endif
	    return " E212"
	catch /E382:/
	    " This option can be set by VCSCommand plugin using VCSVimDiff command
	    if g:atp_debugauTeX
		echomsg " E382"
	    endif
	    return " E382"
	endtry
	if g:atp_Compiler == 'python'
	    call atplib#compiler#PythonCompiler(0, 0, b:atp_auruns, mode, "AU", atp_MainFile, "")
	else
	    call atplib#compiler#Compiler(0, 0, b:atp_auruns, mode, "AU", atp_MainFile, "")
	endif
	redraw
	if g:atp_debugauTeX
	    echomsg "compile for the first time"
	endif
	return "compile for the first time"
    endif
    if g:atp_debugauTeX
	echomsg "files does not differ"
    endif
    return "files does not differ"
endfunction
" function! ATP_auTeX()
"     call atplib#compiler#auTeX()
" endfunction

" This is set by SetProjectName (options.vim) where it should not!
augroup ATP_auTeX
    au!
    au CursorHold 	*.tex call atplib#compiler#auTeX()
    au CursorHoldI 	*.tex call atplib#compiler#auTeX()
augroup END 
"}}}

" Related Functions
" {{{ atplib#compiler#TeX

" a:runs	= how many consecutive runs
" a:1		= one of 'default','silent', 'debug', 'verbose'
" 		  if not specified uses 'default' mode
" 		  (g:atp_DefaultDebugMode).
function! atplib#compiler#TeX(runs, bang, ...)

    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)

    if !exists("t:atp_DebugMode")
	let t:atp_DebugMode = g:atp_DefaultDebugMode
    endif

    if a:0 >= 1
	let mode = ( a:1 != 'default' ? a:1 : t:atp_DebugMode )
    else
	let mode = t:atp_DebugMode
    endif

    if mode =~# '^s\%[ilent]$'
	let mode = 'silent'
    elseif mode =~# '^d\%[ebug]$'
	let mode = 'debug'
    elseif mode =~# 'D\%[ebug]$'
	let mode = 'Debug'
    elseif mode =~#  '^v\%[erbose]$'
	let mode = 'verbose'
    else
	let mode = t:atp_DebugMode
    endif

    for cmd in keys(g:CompilerMsg_Dict) 
	if b:atp_TexCompiler =~ '^\s*' . cmd . '\s*$'
	    let Compiler = g:CompilerMsg_Dict[cmd]
	    break
	else
	    let Compiler = b:atp_TexCompiler
	endif
    endfor

"     echomsg "TEX_2 CHANGEDTICK=" . b:changedtick . " " . b:atp_running

    if l:mode != 'silent'
	if a:runs > 2 && a:runs <= 5
	    echo "[ATP:] ".Compiler . " will run " . a:1 . " times."
	elseif a:runs == 2
	    echo "[ATP:] ".Compiler . " will run twice."
	elseif a:runs == 1
	    echo "[ATP:] ".Compiler . " will run once."
	elseif a:runs > 5
	    echo "[ATP:] ".Compiler . " will run " . atplib#compiler#runlimit . " times."
	endif
    endif
    if g:atp_Compiler == 'python'
        if g:atp_devversion == 0
            call atplib#compiler#PythonCompiler(0,0, a:runs, mode, "COM", atp_MainFile, a:bang)
        else
            call atplib#compiler#ThreadedCompiler(0,0, a:runs, mode, "COM", atp_MainFile, a:bang)
        endif
    else
	call atplib#compiler#Compiler(0,0, a:runs, mode, "COM", atp_MainFile, a:bang)
    endif
endfunction
" command! -buffer -count=1	VTEX		:call atplib#compiler#TeX(<count>, 'verbose') 
"}}}
"{{{ atplib#compiler#DebugComp()
function! atplib#compiler#DebugComp(A,L,P)
    return "silent\ndebug\nDebug\nverbose"
endfunction "}}}
"{{{ atplib#compiler#Bibtex
function! atplib#compiler#SimpleBibtex()
    let bibcommand 	= b:atp_BibCompiler." "
    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
    if b:atp_BibCompiler =~ '^\s*biber\>'
	let file	= fnamemodify(resolve(atp_MainFile),":t:r")
    else
	let file	= fnamemodify(resolve(atp_MainFile),":t:r") . ".aux"
    endif
    let auxfile	= fnamemodify(resolve(atp_MainFile),":t:r") . ".aux"
    " When oupen_out = p (in texmf.cnf) bibtex can only open files in the working
    " directory and they should no be given with full path:
    "  		p (paranoid)   : as `r' and disallow going to parent directories, and
    "                  		 restrict absolute paths to be under $TEXMFOUTPUT.
    let saved_cwd	= getcwd()
    exe "lcd " . fnameescape(b:atp_OutDir)
    let g:cwd = getcwd()
    if filereadable(auxfile)
	let command	= bibcommand . shellescape(file)
	let b:atp_BibtexOutput=system(command)
	let b:atp_BibtexReturnCode=v:shell_error
	echo b:atp_BibtexOutput
    else
	echo "[ATP:] aux file " . auxfile . " not readable."
    endif
    exe "lcd " . fnameescape(saved_cwd)
endfunction

function! atplib#compiler#Bibtex(bang, ...)
    if a:0 >= 1 && a:1 =~# '^o\%[utput]$'
	redraw!
	if exists("b:atp_BibtexReturnCode")
	    echo "[Bib:] BibTeX returned with exit code " . b:atp_BibtexReturnCode
	endif
	if exists("b:atp_BibtexOutput")
	    echo substitute(b:atp_BibtexOutput, '\(^\zs\|\n\)', '\1       ', "g")
	else
	    echo "No BibiTeX output."
	endif
	return
    elseif a:bang == ""
	call atplib#compiler#SimpleBibtex()
	return
    endif

    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
    let g:a=a:0

    if a:0 >= 1
	let mode = ( a:1 != 'default' ? a:1 : t:atp_DebugMode )
    else
	let mode = t:atp_DebugMode
    endif

    if mode =~# '^s\%[ilent]$'
	let mode = 'silent'
    elseif mode =~# '^d\%[ebug]$'
	let mode = 'debug'
    elseif mode =~# 'D\%[ebug]$'
	let mode = 'Debug'
    elseif mode =~#  '^v\%[erbose]$'
	let mode = 'verbose'
    else
	let mode = t:atp_DebugMode
    endif

    if g:atp_Compiler == 'python'
        if g:atp_devversion == 0
            call atplib#compiler#PythonCompiler(1, 0, 0, mode, "COM", atp_MainFile, "")
        else
            call atplib#compiler#ThreadedCompiler(1, 0, 0, mode, "COM", atp_MainFile, "")
        endif
    else
	call atplib#compiler#Compiler(1, 0, 0, mode, "COM", atp_MainFile, "")
    endif
endfunction
function! atplib#compiler#BibtexComp(A,L,P)
	return "silent\ndebug\nDebug\nverbose\noutput"
endfunction
"}}}

" Show Errors Function
" (some error tools are in various.vim: ':ShowErrors o')
" {{{ SHOW ERRORS
"
" this functions sets errorformat according to the flag given in the argument,
" possible flags:
" e	- errors (or empty flag)
" w	- all warning messages
" c	- citation warning messages
" r	- reference warning messages
" f	- font warning messages
" fi	- font warning and info messages
" F	- files
" p	- package info messages

" {{{ atplib#compiler#SetErrorFormat
" first argument is a word in flags 
" the default is a:1=e /show only error messages/
function! atplib#compiler#SetErrorFormat(...)

    let l:cgetfile = ( a:0 >=2 ? a:2 : 0 )
    " This l:cgetfile == 1 only if run by the command :ErrorFormat 
    if l:cgetfile  == 1 && a:1 == ''	
	echo "[ATP:] current error format: ".getbufvar(bufnr(fnamemodify(&l:errorfile, ":r").".tex"), "atp_ErrorFormat") 
	return
    endif

    let carg_raw = ( a:0 == 0 ? g:atp_DefaultErrorFormat : a:1 )
    let carg_list= split(carg_raw, '\zs')
    if carg_list[0] =~ '^[+-]$'
	let add=remove(carg_list,0)
    else
	let add=0
    endif
    for i in range(0, len(carg_list)-2)
	if carg_list[i] == 'f' && get(carg_list,i+1, "") == "i"
	    call remove(carg_list, i+1)
	    let carg_list[i]="fi"
	endif
    endfor

    " Get the bufnr of tex file corresponding to the &l:errorfile
    let bufnr 	= bufnr(fnamemodify(&l:errorfile, ":r").".tex")
    let carg	= !exists("w:quickfix_title") && exists("b:atp_ErrorFormat")
		\ ? b:atp_ErrorFormat 
		\ : getbufvar((bufnr), "atp_ErrorFormat")
    let atp_ErrorFormat = ( exists("b:atp_ErrorFormat") ? b:atp_ErrorFormat : getbufvar((bufnr), "atp_ErrorFormat") )
    if carg_raw =~ '^+'
	for flag in carg_list
	    if flag != 'f' && atp_ErrorFormat !~ flag || flag == 'f' && atp_ErrorFormat !~ 'fi\@!'
		let carg .= flag
	    endif
	endfor
    elseif carg_raw =~ '^-'
	for flag in carg_list
	    if flag != 'f'
		let carg=substitute(carg, flag, '', 'g')
	    else
		let carg=substitute(carg, 'fi\@!', '', 'g')
	    endif
	endfor
    else
	let carg=carg_raw
    endif
    let b:atp_ErrorFormat = carg
    if exists("w:quickfix_title")
	call setbufvar(bufnr, "atp_ErrorFormat", carg)
    endif

    let &l:errorformat=""
    if ( carg =~ 'e' || carg =~# 'all' ) 
" 	let efm = "!\ LaTeX\ %trror:\ %m,!\ %m,!pdfTeX %trror:\ %m"
	let efm = "%E!\ LaTeX\ Error:\ %m,\%E!\ %m,%E!pdfTeX Error:\ %m"
	if &l:errorformat == ""
	    let &l:errorformat= efm
	else
	    let &l:errorformat= &l:errorformat . "," . efm
	endif
    endif
    if ( carg =~ 'w' || carg =~# 'all' )
	let efm='%WLaTeX\ %tarning:\ %m\ on\ input\ line\ %l%.,
			\%WLaTeX\ %.%#Warning:\ %m,
	    		\%Z(Font) %m\ on\ input\ line\ %l%.,
			\%+W%.%#\ at\ lines\ %l--%*\\d'
" 	let efm=
" 	    \'%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#,
" 	    \%+W%.%#\ at\ lines\ %l--%*\\d,
" 	    \%WLaTeX\ %.%#Warning:\ %m'
	if &l:errorformat == ""
	    let &l:errorformat=efm
	else
	    let &l:errorformat= &l:errorformat . ',' . efm
" 	    let &l:errorformat= &l:errorformat . ',%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#,
" 			\%WLaTeX\ %.%#Warning:\ %m,
" 			\%+W%.%#\ at\ lines\ %l--%*\\d'
	endif
    endif
    if ( carg =~ '\Cc' || carg =~# 'all' )
" NOTE:
" I would like to include 'Reference/Citation' as an error message (into %m)
" but not include the 'LaTeX Warning:'. I don't see how to do that actually. 
" The only solution, that I'm aware of, is to include the whole line using
" '%+W' but then the error messages are long and thus not readable.
	if &l:errorformat == ""
	    let &l:errorformat = "%WLaTeX\ Warning:\ Citation\ %m\ on\ input\ line\ %l%.%#"
	else
	    let &l:errorformat = &l:errorformat . ",%WLaTeX\ Warning:\ Citation\ %m\ on\ input\ line\ %l%.%#"
	endif
    endif
    if ( carg =~ '\Cr' || carg =~# 'all' )
	if &l:errorformat == ""
	    let &l:errorformat = "%WLaTeX\ Warning:\ Reference %m on\ input\ line\ %l%.%#,%WLaTeX\ %.%#Warning:\ Reference %m,%C %m on input line %l%.%#"
	else
	    let &l:errorformat = &l:errorformat . ",%WLaTeX\ Warning:\ Reference %m on\ input\ line\ %l%.%#,%WLaTeX\ %.%#Warning:\ Reference %m,%C %m on input line %l%.%#"
	endif
    endif
    if carg =~ '\Cf'
	if &l:errorformat == ""
	    let &l:errorformat = "%WLaTeX\ Font\ Warning:\ %m,%Z(Font) %m on input line %l%.%#"
	else
	    let &l:errorformat = &l:errorformat . ",%WLaTeX\ Font\ Warning:\ %m,%Z(Font) %m on input line %l%.%#"
	endif
    endif
    if carg =~ '\Cfi'
	if &l:errorformat == ""
	    let &l:errorformat = '%ILatex\ Font\ Info:\ %m on input line %l%.%#,
			\%ILatex\ Font\ Info:\ %m,
			\%Z(Font) %m\ on input line %l%.%#,
			\%C\ %m on input line %l%.%#'
	else
	    let &l:errorformat = &l:errorformat . ',%ILatex\ Font\ Info:\ %m on input line %l%.%#,
			\%ILatex\ Font\ Info:\ %m,
			\%Z(Font) %m\ on input line %l%.%#,
			\%C\ %m on input line %l%.%#'
	endif
    endif
    if carg =~ '\CF'
	let efm = '%+P)%#%\\s%#(%f,File: %m,Package: %m,Document Class: %m,LaTeX2e %m'
	if &l:errorformat == ""
	    let &l:errorformat = efm
	else
	    let &l:errorformat = &l:errorformat . ',' . efm
	endif
    endif
    if carg =~ '\Cp'
	if &l:errorformat == ""
	    let &l:errorformat = 'Package: %m'
	else
	    let &l:errorformat = &l:errorformat . ',Package: %m'
	endif
    endif
    if &l:errorformat != ""

" 	let pm = ( g:atp_show_all_lines == 1 ? '+' : '-' )

" 	let l:dont_ignore = 0
" 	if carg =~ '\CA\cll'
" 	    let l:dont_ignore = 1
" 	    let pm = '+'
" 	endif

	let l:dont_ignore= 1
	let pm = '+'

	let &l:errorformat = &l:errorformat.",
			    \%-C<%.%#>%.%#,
			    \%-Zl.%l\ ,
		    	    \%-Zl.%l\ %m,
			    \%-ZI've inserted%.%#,
			    \%-ZThe control sequence%.%#,
			    \%-ZYour command was ignored%.%#,
			    \%-ZYou've closed more groups than you opened%.%#,
			    \%-ZThe `$' that I just saw%.%#,
			    \%-ZA number should have been here%.%#,
			    \%-ZI'm ignoring this;%.%#,
			    \%-ZI suspect you've forgotten%.%#,
			    \%-GSee LaTeX%.%#,
			    \%-GType\ \ H\ <return>%m,
			    \%-C\\s%#%m,
			    \%-C%.%#-%.%#,
			    \%-C%.%#[]%.%#,
			    \%-C[]%.%#,
			    \%-C%.%#%[{}\\]%.%#,
			    \%-G ...%.%#,
			    \%-G%.%#\ (C)\ %.%#,
			    \%-G(see\ the\ transcript%.%#),
			    \%-G\\s%#,
			    \%-G%.%#"
" These two appeared before l.%l (cannot be -Z):
" 			    \%-GSee LaTeX%.%#,
" 			    \%-GType\ \ H\ <return>%m,
	let &l:errorformat = &l:errorformat.",
			    \%".pm."O(%*[^()])%r,
			    \%".pm."O%*[^()](%*[^()])%r,
			    \%".pm."P(%f%r,
			    \%".pm."P\ %\\=(%f%r,
			    \%".pm."P%*[^()](%f%r,
			    \%".pm."P[%\\d%[^()]%#(%f%r"
	let &l:errorformat = &l:errorformat.",
			    \%".pm."Q)%r,
			    \%".pm."Q%*[^()])%r,
			    \%".pm."Q[%\\d%*[^()])%r"
    endif
    if l:cgetfile
	try
	    cgetfile
	catch E40:
	endtry
    endif
    if t:atp_QuickFixOpen
	let winnr=winnr()
	" Quickfix is opened, jump to it and change the size
	copen
	exe "resize ".min([atplib#qflength(), g:atp_DebugModeQuickFixHeight])
	exe winnr."wincmd w"
    endif
    if add != "0"
	echo "[ATP:] current error format: ".b:atp_ErrorFormat 
    endif
endfunction
"}}}
"{{{ ShowErrors
" each argument can be a word in flags as for atplib#compiler#SetErrorFormat (except the
" word 'whole') + two other flags: all (include all errors) and ALL (include
" all errors and don't ignore any line - this overrides the variables
" g:atp_ignore_unmatched and g:atp_show_all_lines.
function! atplib#compiler#ShowErrors(...)
    " It is not atplib#compiler# because it is run from atplib#callback#CallBack()

    let errorfile	= &l:errorfile
    " read the log file and merge warning lines 
    " filereadable doesn't like shellescaped file names not fnameescaped. 
    " The same for readfile() and writefile()  built in functions.
    if !filereadable(errorfile)
	echohl WarningMsg
	echo "[ATP:] no error file: " . errorfile  
	echohl Normal
	return
    endif

    let log=readfile(errorfile)

    let nr=1
    for line in log
	if line =~ "LaTeX Warning:" && log[nr] !~ "^$" 
	    let newline=line . log[nr]
	    let log[nr-1]=newline
	    call remove(log,nr)
	endif
	let nr+=1
    endfor
    call writefile(log, errorfile)
    
    " set errorformat 
    let l:arg = ( a:0 >= 1 ? a:1 : b:atp_ErrorFormat )

    if l:arg =~ 'o'
	OpenLog
	return
    elseif l:arg =~ 'b'
	echo b:atp_BibtexOutput
	return
    endif
    call atplib#compiler#SetErrorFormat(l:arg)
    let show_message = ( a:0 >= 2 ? a:2 : 1 )

    " read the log file
    cgetfile

    " signs
    if g:atp_signs
	call atplib#callback#Signs()
    endif

    " final stuff
    if len(getqflist()) == 0 
	if show_message
	    echo "[ATP:] no errors :)"
	endif
	return ":)"
    else
	cl
	return 1
    endif
endfunction
"}}}
if !exists("*ListErrorsFlags")
function! atplib#compiler#ListErrorsFlags(A,L,P)
    return "all\nAll\nc\ne\nF\nf\nfi\no\nr\nw\nb"
endfunction
endif
if !exists("*ListErrorsFlags_A")
function! atplib#compiler#ListErrorsFlags_A(A,L,P)
    " This has no o flag.
    return "all\nAll\nc\ne\nF\nf\nfi\nr\nw\nb"
endfunction
endif
"}}}

" vim:fdm=marker:tw=85:ff=unix:noet:ts=8:sw=4:fdc=1
