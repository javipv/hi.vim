" Script Name: hi/filter.vim
" Description: Highlight text patterns in different colors.
"   Allows to save, reload and modify the highlighting configuration.
"   Allows to filter by color the lines and show then on a new split/tab.
"
" Copyright:   (C) 2017-2020 Javier Puigdevall
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Puigdevall <javierpuigdevall@gmail.com>
" Contributors:
"


"- functions -------------------------------------------------------------------

if !exists('g:HiLoaded')
    finish
endif


" Check if buffer or file with this name already exists
function! s:CheckBuffFileExist(filename)
    let all = range(0, bufnr('$'))
    for b in all
        if !buflisted(b) | continue | endif
        if bufname(b) == a:filename
            return 1
        endif
        if filereadable(a:filename)
            return 1
        endif
    endfor
    return 0
endfunction


" Change current buffer name.
" Get a name not used for this file on current path and not
" loaded on any other buffer.
" Filename format: curren_name-filtN.current_ext
function! s:GetFiltFileName(filepath,filename,extension)
    let tmp = substitute(a:filename, "-filt[0-9].*", "", "")
    let n = 0
    while n <= 100
        "let file = a:filepath.'/'.l:tmp.'-filt'.l:n.'.'.a:extension
        let file = a:filepath.g:HiDirSep.l:tmp.'-filt'.l:n.'.'.a:extension
        if s:CheckBuffFileExist(l:file) == 0 | break | endif
        let n+=1
    endwhile
    return l:file
endfunction


function! s:AddHeader(baseFilePath,patterns,rm_patterns)
    if g:HiFilterAddHeader != 1 | return | endif

    let l:patterns    = hi#utils#TrimString(a:patterns)
    let l:rm_patterns = hi#utils#TrimString(a:rm_patterns)

    let linesList  = []

    if exists("w:HiPrevFilterHeaderList")
        let linesList += w:HiPrevFilterHeaderList
        "let linesList += [ "    ----------------------"]
    else
        let linesList  = [ " HI PLUGIN. FILTER WINDOW " ]
        let w:HiPrevFilterHeaderList = []
        let linesList += [ " Base file: ".a:baseFilePath." " ]
    endif

    if  l:patterns != ""
        let linesList += [ " Keep patterns:   \"".l:patterns."\" " ]
    endif

    if  l:rm_patterns != ""
        let linesList += [ " Remove patterns: \"".l:rm_patterns."\" " ]
    endif

    let l:config   = hi#utils#EncloseOnRectangle(linesList,"bold","")

    normal ggO
    silent put = l:config
    normal ggdd

    let w:HiPrevFilterHeaderList += l:linesList

    " Scroll down, hide the header and leve first data line on top.
    if line('.') == 1 
        let scrollLines = len(l:linesList) + 2
        exec("normal L".l:scrollLines."jH")
    endif
endfunction


" Filter lines containing patterns.
function! s:BasicFilter(split,rename,patterns)
        call input("using basic filter")
    "let @a = ""
    "let patterns = substitute(a:patterns, '|', '\\|', 'g')
    "let cmd = 'g/'.l:patterns.'/y A'
    "call hi#log#Verbose(1, expand('<sfile>'), l:cmd)
    "silent exec(l:cmd)
    silent normal ggVG"ay

    if @a == ""
        call hi#log#Warn("No results found")
        return 1
    endif

    if a:split != "split"
        call input(a:split)
        silent exec(a:split)
    else
        silent new
    endif

    put! a

    if getline(1) == "" && line('$') == 1
        call hi#log#Warn("No results found")
        wincmd q
        return 1
    else
        if a:split != ""
            silent exec '0file | file '.a:rename
        endif
    endif

    let patterns = substitute(a:patterns, '|', '\\|', 'g')
    silent exec('%g!/'.l:patterns.'/d')
    return 0
endfunction


" Filter lines containing patterns with external tool (ag/grep).
function! s:AgGrepFilter(split, rename, keep_patterns, remove_patterns)
    call hi#log#Verbose(1, expand('<sfile>'), "Split: ".a:split." rename: ".a:rename." keep_patterns: ".a:keep_patterns)

    let keep_patterns = a:keep_patterns
    let keep_patterns = substitute(l:keep_patterns, '\\c', '', 'g')
    let keep_patterns = substitute(l:keep_patterns, '\\C', '', 'g')

    call hi#log#Verbose(1, expand('<sfile>'), "keep_patterns: ".l:keep_patterns)
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    let remove_patterns = a:remove_patterns
    let remove_patterns = substitute(l:remove_patterns, '\\c', '', 'g')
    let remove_patterns = substitute(l:remove_patterns, '\\C', '', 'g')

    call hi#log#Verbose(1, expand('<sfile>'), "remove_patterns: ".l:remove_patterns)
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    "let file = fnameescape(expand('%'))
    let file = expand('%')
    let ext  = expand('%:t:e')
    let fileDelete = ""
    let res = 0

    call hi#log#Verbose(1, expand('<sfile>'), "File: ".l:file." Ext: ".l:ext)
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    " Check file exist or file is compressed
    if empty(glob(l:file)) || l:ext == "gz" || l:ext == "Z" || l:ext == "bz2"
        " Buffer not saved on file
        " save a temporary copy
        let file = tempname()
        let fileDelete = l:file
        silent exec(":w! ".l:file)
        call hi#log#Verbose(1, expand('<sfile>'), "Save to file: ".l:file)
        call hi#log#Verbose(1, expand('<sfile>'), " ")
    endif

    let result = tempname()

    if executable('ag') && !g:HiUseGrep
        let bin  = "ag"
        let arg0 = "-s --nofilename"
    else
        if !executable('egrep')
            call hi#log#Error("egrep not found")
            return 1
        endif
        echom "Silver searcher (ag) not found. Using egrep."
        let bin  = "egrep"
        let arg0 = ""
    endif

    " Mount the grep/ag commad:
    let l:cmd  = l:bin . " " . l:arg0
    let l:cmd1  = l:bin . " " . l:arg0
    if  l:keep_patterns != ""
        let l:cmd .= " " . shellescape(l:keep_patterns,1) . " " . shellescape(l:file,1)
        let l:cmd1 .= " \"" . l:keep_patterns . "\""
    endif
    if  l:remove_patterns != ""
        if  l:cmd == ""
            let l:cmd .= " -v " . shellescape(l:remove_patterns,1) . " " . shellescape(l:file,1)
            let l:cmd1 .= " -v \"" . l:remove_patterns . "\""
        else
            let l:cmd .= " | " . l:bin . " -v " . shellescape(l:remove_patterns,1)
            let l:cmd1 .= " | " . l:bin . " -v \"" . l:remove_patterns . "\""
        endif
    endif
    let l:HiFiltCmdExt = l:cmd1
    let l:cmd .= " | " . l:bin . " -v \"vim_hi:|Keep patterns:|Remove patterns:\""
    let l:HiFiltCmd = l:cmd

    let l:cmd .= " > ".l:result

    "call hi#log#VerboseStop(0, expand('<sfile>'), "cmd: ".l:cmd)
    call hi#log#Verbose(1, expand('<sfile>'), "cmd: ".l:cmd)
    call hi#log#Verbose(1, expand('<sfile>'), " ")


    silent call system(l:cmd)
    
    if a:split != ""
        let cmd = a:split." | edit ".l:result
    else
        let cmd = "edit ".l:result
    endif

    call hi#log#Verbose(1, expand('<sfile>'),  "cmd: ".l:cmd." (press enter)")
    call hi#log#Verbose(1, expand('<sfile>'), " ")
    silent exec(l:cmd)

    if getline(1) == "" && line('$') == 1
        call hi#log#Warn("No results found")
        wincmd q
        let res = 1
    else
        let cmd = '0file | file '.a:rename
        silent execute l:cmd
        " Save the ag/grep command used to filter.
        let w:HiFiltCmd = l:HiFiltCmd
        let w:HiFiltCmdExt = l:HiFiltCmdExt
    endif

    call delete(l:result)

    " Clean tmp file used for searching on buffers not saved
    if l:fileDelete != "" | call delete(l:fileDelete) | endif

    return l:res
endfunction


" Filter lines containing patterns and regions with external tool (awk).
function! s:AwkFilter(split,rename, regionList, patterns)

    if !executable('awk')
        call hi#log#Error("awk not found")
        return 1
    endif

    let file = fnameescape(expand('%'))
    let ext  = expand('%:t:e')
    let fileDelete = ""
    let res = 0

    call hi#log#Verbose(1, expand('<sfile>'), "File: ".l:file." Ext: ".l:ext)

    " Check file exist or file is compressed
    if empty(glob(l:file)) || l:ext == "gz" || l:ext == "Z" || l:ext == "bz2"
        " Buffer not saved on file
        " save a temporary copy
        let file = tempname()
        let fileDelete = l:file
        silent exec(":w! ".l:file)
        call hi#log#Verbose(1, expand('<sfile>'), "save to file: ".l:file)
    endif

    let result = tempname()
    let awkScript = tempname()

    let block = g:HiBlockSeparator
    let rmLine = g:HiBlockRemoveLine
    let rmLineNL = g:HiBlockRemoveLineAddNL

    " Create the awk command to perform filter
    let winId = win_getid()
    silent exec("tabedit ".l:awkScript)
    let awkCmd = "BEGIN        { record=0; line=0; }\n"

    for reg in a:regionList
        let tmpList = split(l:reg, l:block)
        if len (tmpList) != 2
            continue
        endif
        let initTag = substitute(l:tmpList[0], '\\c', '', 'g')
        let initTag = substitute(l:initTag, '\\C', '', 'g')

        let endTag = substitute(l:tmpList[1], '\\c', '', 'g')
        let endTag = substitute(l:endTag, '\\C', '', 'g')

        let initTag = substitute(l:initTag,"/","\/","")
        if l:reg =~ "^".l:rmLine.".*".l:block
            " Start of region, remove line content
            let initTag = substitute(l:initTag,"^".l:rmLine,"","")
            let awkCmd .= "/".l:initTag."/ { if (region==0) { region=2; }; }\n"
        elseif l:reg =~ "^".l:rmLineNL."l*".l:block
            " Start of region, remove line content and add new line
            let initTag = substitute(l:initTag,"^".l:rmLineNL,"","")
            let awkCmd .= "/".l:initTag."/  { if (region!=0) { region=2; printf(\"\\n\"); }; }\n"
        else
            " Start of region, show line content
            let awkCmd .= "/".l:initTag."/ { if (region==0) { region=1; }; }\n"
        endif

        let endTag = substitute(l:endTag,"/","\/","")
        if l:reg =~ l:block.l:rmLine
            " End of region, remove line content
            let endTag = substitute(l:endTag,"^".l:rmLine,"","")
            let awkCmd .= "/".l:endTag."/  { region=0; }\n"
        elseif l:reg =~ l:block.l:rmLineNL
            " End of region, remove line content and add new line
            let endTag = substitute(l:endTag,"^".l:rmLineNL,"","")
            let awkCmd .= "/".l:endTag."/  { if (region!=0) { region=0; printf(\"\\n\"); }; }\n"
        else
            " End of region, show line content
            let awkCmd .= "/".l:endTag."/  { if (region!=0) { region=0; printf(\"%s\\n\", $0); }; }\n"
        endif
    endfor

    if a:patterns != ""
        let patterns = substitute(a:patterns, '\\c', '', 'g')
        let patterns = substitute(l:patterns, '\\C', '', 'g')
        let awkCmd .= "/".l:patterns."/     { if (region==0) { line=1; }; }\n"
        call hi#log#Verbose(1, expand('<sfile>'), "Use patterns: ".l:patterns)
    endif

    let awkCmd .= "{ if (region==1 || line==1) { printf(\"%s\\n\", $0); line=0; }; }\n"
    let awkCmd .= "{ if (region==2)            { region=1; }; }\n"
    call append(line('$'), split(l:awkCmd,"\n"))
    normal ggdd
    w
    call win_gotoid(l:winId)

    "if exists("w:hi_filter_save_cmd")
        "if w:hi_filter_save_cmd == 1
            "let w:hi_filter_cmd = l:cmd

            "call delete(l:result)
            "call delete(l:awkScript)

            "" Clean tmp file used for searching on buffers not saved
            "if l:fileDelete != "" | call delete(l:fileDelete) | endif
            "return
        "endif
    "endif

    " Apply awk filter
    call hi#log#Verbose(2, expand('<sfile>'), "r !awk -f ".l:awkScript." ".l:file." > ".l:result)
    silent exec("r !awk -f ".l:awkScript." ".l:file." > ".l:result)

    if a:split != ""
        let cmd = a:split." | edit ".l:result
    else
        let cmd = "edit ".l:result
    endif

    "let cmd = a:split." | edit ".l:result
    call hi#log#Verbose(1, expand('<sfile>'), l:cmd)
    silent exec(l:cmd)

    if getline(1) == "" && line('$') == 1
        call hi#log#Warn("No results found")
        wincmd q
        let res = 1
    else
        let cmd = '0file | file '.a:rename
        call hi#log#Verbose(1, expand('<sfile>'), l:cmd)
        silent execute l:cmd
    endif

    " DEBUG: comment next line to debug the awk script
    silent exec("bd ".l:awkScript)

    call delete(l:result)
    call delete(l:awkScript)

    " Clean tmp file used for searching on buffers not saved
    if l:fileDelete != "" | call delete(l:fileDelete) | endif

    return l:res
endfunction


" Ask user to choose where to open the filter: current window, new window split, vertical split, tab...
" Open split window containing all lines matching patterns with the selected color IDs.
" Arg1: filters: space separted colorIDs and/or patterns to keep or remove on filter window.
"   Use prefix -- to remove the pattern or colorId.
"   Ex: keep only magenta yellow and cian1 patterns "m y c1".
"   Ex: keep only magenta yellow and cian1 and myPattern "m y c1 myPattern".
"   Ex: keep magenta and cian1, then remove any yellow colorID and myPatter "m --y c1 --pattern1".
" Arg2: nColorIDs to be omitted from filter window, space separated color names: "m1 y2 c!".
" Arg3: line, string to search on filter window to sync positions.
" Commands: Hifm
function! hi#filter#ColorSplitMenu(filters,nColorIDs,line)
    let l:split = ""

    let l:option = confirm("", "Open filter: hor&izontal split\nvertical &split\nnew &tab\ncurrent &window", 1)

    if l:option == 1
        let l:split = "new"
    elseif l:option == 2
        let l:split = "vnew"
    elseif l:option == 3
        let l:split = "tabnew"
    elseif l:option == 4
        let l:split = "enew"
    else
        "let l:split = g:HiFilterSplit
        call hi#log#Warn("Unkown option ".l:option)
        return
    endif
    call hi#filter#Color(l:split,a:filters,a:nColorIDs,a:line)
endfunction


" Open split window containing all lines matching patterns with the selected color IDs.
" Arg1: split type: "", split, vertical split, tab.
" Arg2: filters: space separted colorIDs and/or patterns to keep or remove on filter window.
"   Use prefix -- to remove the pattern or colorId.
"   Ex: keep only magenta yellow and cian1 patterns "m y c1".
"   Ex: keep only magenta yellow and cian1 and myPattern "m y c1 myPattern".
"   Ex: keep magenta and cian1, then remove any yellow colorID and myPatter "m --y c1 --pattern1".
" Arg3: ncolors to be omitted from filter window, space separated color names: "m1 y2 c!".
" Arg4: line, string to search on filter window to sync positions.
" Commands: Hif, Hifsv, Hifv, Hift.
function! hi#filter#Color(split,filters,ncolors,line)
    "let g:HiLogLevel = 4
    call hi#log#Verbose(1, expand('<sfile>'), " ")
    
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
    endif

    let l:filters = substitute(a:filters,'\s\+$','','g')
    let l:ncolors = substitute(a:ncolors,'\s\+$','','g')


    if a:line != ""
        let line = a:line
    else
        let line = getline('.')
    endif

    call hi#log#Verbose(1, expand('<sfile>'), "Save line : '".l:line."'")

    let baseFilePath = expand('%')
    let baseName = fnameescape(expand('%s'))
    if exists("w:ColoredPatternsList") && len(w:ColoredPatternsList) > 0
        let l:ColoredPatternsList = w:ColoredPatternsList
    endif

    let l:regionsList = []
    let l:keep = ""
    let l:remove = ""

    "call hi#log#VerboseStop(0, expand('<sfile>'), "filters: '".l:filters."'")
    let filtersList = split(l:filters," ")

    if len(l:filtersList) > 0
        for i in l:filtersList
            if l:i[0:1] != "--"
                if l:keep != "" | let l:keep .= " " | endif
                let l:keep .= l:i
            else
                if l:remove != "" | let l:remove .= " " | endif
                let l:remove .= l:i[2:]
            endif
        endfor
    else
        if l:filters[0:1] != "--"
            let l:keep = l:filters
        else
            let l:remove .= l:filters[2:]
        endif
    endif

    let w:HiFiltColors = l:keep
    let w:HiFiltRmColors = l:remove
    let l:separator = "____SEP____"


    " KEEP PATTERNS:
    "call hi#log#VerboseStop(0, expand('<sfile>'), "keep: '".l:keep."'")

    " Get the patterns related to the given highlight color ID.
    if l:keep =~# "ALL"
        let l:keep = substitute(l:keep, "ALL", "all", "")
        let l:patterns = hi#config#GetColorPatterns(l:keep,"",l:separator,"searchMode")
    else
        let l:patterns = hi#config#GetColorPatterns(l:keep,"",l:separator,"filterMode")
    endif

    " Get the patterns not related to to a highlight color ID.
    let l:tmp      = hi#config#GetNonColorPatterns(l:keep,l:separator)
    "call hi#log#VerboseStop(0, expand('<sfile>'), "KeepNonColorPaters: '".l:tmp."'")
    if l:tmp != ""
        if  l:patterns != "" | let patterns .= l:separator | endif
        let l:patterns .= l:tmp
    endif
    call hi#log#Verbose(1, expand('<sfile>'), "Patterns : '".l:patterns."'")

    " Remove regexp .* from patterns end:
    " .*$ makes highlighting until end of the string, but makes filter fail.
    let l:patterns = substitute(l:patterns, '\.\*$', '', 'g')
    call hi#log#Verbose(1, expand('<sfile>'), "Patterns removes regexp: '".l:patterns."'")

    " Region patterns:
    let regionsList = hi#config#GetColorRegionPatterns(l:keep)
    if len(l:regionsList) != 0
        call hi#log#Verbose(1, expand('<sfile>'), "Region patterns: '".join(l:regionsList)."'")
    endif


    " REMOVE PATTERNS:
    if l:remove != "" && l:remove != "all"
        "call hi#log#VerboseStop(0, expand('<sfile>'), "remove: '".l:remove."'")

        " Get the patterns related to the given highlight color ID.
        let separator = "____SEP____"
        let l:rm_patterns = hi#config#GetColorPatterns(l:remove,"",l:separator,"filterMode")
        "call hi#log#VerboseStop(0, expand('<sfile>'), "RmColorPatterns: '".l:rm_patterns."'")

        " Get the patterns not related to to a highlight color ID.
        let l:tmp      = hi#config#GetNonColorPatterns(l:remove,l:separator)
        "call hi#log#VerboseStop(0, expand('<sfile>'), "RmNonColorPatterns: '".l:tmp."'")
        if l:tmp != ""
            if  l:rm_patterns != "" | let rm_patterns .= l:separator | endif
            let l:rm_patterns .= l:tmp
        endif
        call hi#log#Verbose(1, expand('<sfile>'), "RmPatterns : '".l:rm_patterns."'")
        "call hi#log#VerboseStop(0, expand('<sfile>'), "RmPatterns: '".l:rm_patterns."'")

        " Remove regexp .* from patterns end:
        " .*$ makes highlighting until end of the string, but makes filter fail.
        let l:rm_patterns = substitute(l:rm_patterns, '\.\*$', '', 'g')
        "call hi#log#VerboseStop(0, expand('<sfile>'), "RmPatterns removes regexp: '".l:rm_patterns."'")

         " Region patterns:
        "let tmpList = hi#config#GetColorRegionPatterns(l:ncolors)
        "let regionsList += [ l:tmpList ]
        "if len(l:regionsList) != 0
            "call hi#log#Verbose(1, expand('<sfile>'), "Region patterns: '".join(l:regionsList)."'")
        "endif
    else
        let l:rm_patterns = ""
    endif


    if len(l:regionsList) == 0 && l:patterns == "" && l:rm_patterns == ""
        if a:filters != "" && a:ncolors != ""
            call hi#log#Warn("Not found (2) ".a:filters." ".a:ncolors)
        elseif a:filters != ""
            call hi#log#Warn("Not found (2) ".a:filters)
        elseif a:ncolors != ""
            call hi#log#Warn("Not found (2) ".a:ncolors)
        endif
        return
    endif


    "let tmp = substitute(l:patterns, l:separator, ', ', 'g')

    if exists("w:AllConfigTypeNames")
        let l:AllConfigTypeNames = w:AllConfigTypeNames
    else
        let l:AllConfigTypeNames = ""
    endif

    redraw
    echo "Opening filter window. This may take a while ..."
    let patterns = substitute(l:patterns, l:separator, '\|', 'g')
    let rm_patterns = substitute(l:rm_patterns, l:separator, '\|', 'g')
    call hi#log#Verbose(1, expand('<sfile>'), "patterns : ".l:patterns)
    call hi#log#Verbose(1, expand('<sfile>'), "rm_patterns : ".l:rm_patterns)
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    if a:split == ""
        let rename = fnameescape(expand("%"))
    else
        "let name = fnameescape(expand("%:t:r"))
        "let path = fnameescape(expand("%:p:h"))
        let name = expand("%:t:r")
        let path = expand("%:p:h")
        let ext = expand("%:e")
        "let base_filename = expand("%")
        let rename = s:GetFiltFileName(l:path,l:name,l:ext)
    endif
    call hi#log#Verbose(1, expand('<sfile>'), "rename : ".l:rename)
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    let baseWinNr = win_getid()
    let winName = fnameescape(expand('%'))

    if len(l:regionsList) != 0
        if g:HiAwkFilter == 0
            call hi#log#Error("awk not found.")
        endif
        if s:AwkFilter(a:split,l:rename,l:regionsList,l:patterns) != 0
            return
        endif
    elseif line('$') >= g:HiAgGrepFilter 
        if g:HiAgGrepFilter > 0
            if s:AgGrepFilter(a:split, l:rename, l:patterns, rm_patterns) != 0
                return
            endif
        else
            call hi#log#Error("ag and grep not found.")

            if s:BasicFilter(a:split,l:rename,l:patterns) != 0
                call hi#utils#ConcealEscSeq()
                return
            endif
        endif
    else
        if s:BasicFilter(a:split,l:rename,l:patterns) != 0
            call hi#utils#ConcealEscSeq()
            return
        endif
    endif

    " On horizonta split. Fit window to content
    if a:split == "split" || a:split == ""
        if line('$') < winheight(0)
            exec("resize ".line('$'))
        endif
    endif

    normal gg
    set buflisted
    set bufhidden=delete
    set buftype=nofile
    setl noswapfile
    setl nocursorline
    set nohls
    let w:HiFiltColors = a:filters
    let w:AllConfigTypeNames = l:AllConfigTypeNames

    " Try to restore same line position.
    call hi#log#Verbose(1, expand('<sfile>'), "Restore to line : '".l:line."'")
    call hi#utils#SearchLine(l:line)

    " Aplly color config from the base window
    if exists("l:ColoredPatternsList")
        " Remove highlighting on the header text.
        let l:tmpConfigList = [["Mark", "n", "┃", "ClT"]]
        let l:configCleanFound = 0

        for config in l:ColoredPatternsList
            "echo "Conf: ".l:config[0]." ".l:config[1]
            let l:tmpConfigList += [l:config]
            let l:addConfigLine = 0

            if l:config[0] == "Conf" && l:config[1] == "clean"
                let l:addConfigLine = 1
            endif
            if l:config[0] == "Filt" && l:config[1] == "close"
                let l:addConfigLine = 1
            endif
            if l:config[0] == "Mark" && l:config[3] =~ "l"
                " Allow pattern to be highlighted on the header
                let l:opt = substitute(l:config[3], "l", "", "g")
                let l:tmpConfigList += [[l:config[0], l:config[1], l:config[2], l:opt]]
            endif
            if l:addConfigLine == 1
                 " Prevent a pattern highlight to colorize all header line.
                let l:tmpConfigList += [["Mark", "n", "┃", "ClT"]]
            endif
        endfor
        let l:ColoredPatternsList = l:tmpConfigList

        " Save config on current window:
        let w:ColoredPatternsList = l:ColoredPatternsList
        let w:LastConfigType = l:ColoredPatternsList
        call hi#config#SyntaxReload()
    endif

    " Safe filter/base (parent/son) window synchronization parameters
    if g:HiFiltSync == 1
        if a:split == "new" || a:split =~ "vnew" || a:split == "split"

            if hi#windowFamily#NewSonToParent(l:baseWinNr) == 0
                let filtName = fnameescape(expand('%s'))

                silent exec("autocmd CursorMoved ".l:baseName." :call hi#filterSynch#AutoSyncFiltWindowPosition()")
                silent exec("autocmd CursorMoved ".l:filtName." :call hi#filterSynch#AutoSyncFiltWindowPosition()")

                let w:autoSyncFiltPos  = g:HiAutoSyncFiltPos
                let w:autoSyncFiltData = g:HiAutoSyncFiltData

                call hi#filterSynch#UnmapKeys()
            endif
        endif
    endif

    call hi#utils#ConcealEscSeq()
    call s:AddHeader(l:baseFilePath,l:patterns,l:rm_patterns)
    "let g:HiLogLevel = 0
endfunction


" Close all filter windows
" Config: Filt all
func! hi#filter#CloseAll()
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    " If we're on config editor  window, return to base window.
    if hi#configEditor#GotoBaseWin() != 0
        return
    endif

    while hi#windowFamily#GotoLastSonWindow() == 0
        call hi#log#Verbose(4, expand('<sfile>'), "Close Buffer: ".expand("%"))
        silent bd!

        call hi#windowFamily#GotoFirstParentWindow()
    endwhile
endfunc



"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
