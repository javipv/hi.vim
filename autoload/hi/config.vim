" Script Name: hi/config.vim
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


if !exists('g:HiLoaded')
    finish
endif


function! hi#config#Reload()
    " Reload custom highlights
    let l:file = g:HiPluginPath.g:HiPrevDirSep.g:HiPrevDirSep."colors/hi.vim"
    if empty(glob(l:file))
        call hi#log#Error("Config file not found ".l:file)
        return 1
    endif
    silent exec("source ".l:file)

    if !exists("g:HiColorDefinitionList")
        call hi#log#Error("Config not found g:HiColorDefinitionList")
        return 1
    endif
    let g:HiColorDefinitionList = g:HiColorDefinitionList

    if !exists("g:HiBaseColors")
        call hi#log#Error("Config not found g:HiBaseColors")
        return 1
    endif
    let g:HiBaseColors = g:HiBaseColors

    if !exists("g:HiColorIds")
        call hi#log#Error("Config not found g:HiColorIds")
        return 1
    endif
    let g:HiBaseColorIds = g:HiColorIds
    return 0
endfunction


" Disable all highlights
" Command: Hi0, Hioff
function! hi#config#Off()
    let l:file = g:HiPluginPath.g:HiPrevDirSep.g:HiPrevDirSep."colors/hi_off.vim"
    if empty(glob(l:file))
        call hi#log#Error("Config file not found ".l:file)
        return 1
    endif
    silent exec("source ".l:file)
    echo "Highlighting off"
    return 0
endfunction


" Enable all highlights
" Command: Hi1
function! hi#config#On()
    let l:file = g:HiPluginPath.g:HiPrevDirSep.g:HiPrevDirSep."colors/hi.vim"
    if empty(glob(l:file))
        call hi#log#Error("Config file not found ".l:file)
        return 1
    endif
    silent exec("source ".l:file)
    echo "Highlighting on"
    return 0
endfunction


" Enable highlights on current window
" Command: Hiw1
function! hi#config#WindowOn()
    call hi#config#SyntaxReload()
    echo "Window highlighting on"
    return 0
endfunction


" Disable highlights on current window
" Command: Hiw0
function! hi#config#WindowOff()
    call hi#config#SyntaxClear()
    echo "Window highlighting off"
    return 0
endfunction


" Clear all saved highlight settings
function! hi#config#ListClear()
    if exists("w:ColoredPatternsList")
        let n = len(w:ColoredPatternsList) -1
        if l:n > 0
            call remove(w:ColoredPatternsList, 0, l:n)
        endif
    endif
    if exists('w:LastConfigType')
        unlet w:LastConfigType
    endif
    if exists('w:ConfigTypeName')
        unlet w:ConfigTypeName
    endif
endfunction


" Clear syntax highlight, and remove all saved highlight settings
function! hi#config#SyntaxClear()
    let l:ft = &ft
    syntax clear
    if l:ft != ""
        " reload file syntax
        silent exec("set ft=".l:ft)
    endif
endfunction


" Reload the syntax highliting
function! hi#config#SyntaxReload()
    call hi#config#SyntaxClear()

    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return
    endif

    " Reload again all highlights
    for coloredPatterns in w:ColoredPatternsList
        if l:coloredPatterns[0] == "Mark"
            call hi#log#Verbose(4, expand('<sfile>'), l:coloredPatterns[1]." ".l:coloredPatterns[2]." ".l:coloredPatterns[3])
            silent call hi#config#ColorReload(l:coloredPatterns[1],l:coloredPatterns[2],l:coloredPatterns[3])
        endif
    endfor
endfunction


" Return: string with all color IDs used on current window
function! hi#config#GetAllColorIDs()
    let colorIDList = []
    for coloredPatterns in w:ColoredPatternsList
        if l:coloredPatterns[0] == "Mark"
            let colorIDList += [ l:coloredPatterns[1] ]
        endif
    endfor
    call uniq(l:colorIDList)
    let colorIDStr = join(l:colorIDList)
endfunction


" Check color available on color list
" Return: 0 on success, 1 elsewise
function! hi#config#ColorCheck(color)
    let l:color = substitute(a:color, '\*', '', 'g')
    let l:color = substitute(l:color, '\^', '', 'g')
    let l:color = substitute(l:color, '\.', '', 'g')
    let l:color = substitute(l:color, '&', '', 'g')
    let l:color = substitute(l:color, '0',  '', 'g')
    let l:color = substitute(l:color, '-',  '', 'g')
    let l:color = substitute(l:color, ',',  '', 'g')
    let found = 0
    for colorDefinitions in g:HiColorDefinitionList
        call hi#log#Verbose(5, expand('<sfile>'), colorDefinitions[0]." ".toupper(l:color))
        if colorDefinitions[0] == toupper(l:color)
            "let found = 1
            call hi#log#Verbose(5, expand('<sfile>'), "Found: ".toupper(l:color))
            return 0
        endif
    endfor
    "if l:found == 0
        call hi#log#Verbose(2, expand('<sfile>'), "Not found: ".toupper(l:color))
        return 1
    "endif
    "call hi#log#Verbose(5, expand('<sfile>'), "Found: ".toupper(l:color))
    "return 0
endfunction


" Highlight a pattern with the selected color.
" Return: 0 on success, error number elsewise
function! hi#config#PatternHighlight(color,pattern,opt)
    "echom "hi#config#PatternHighlight : '".a:color."'  '".a:pattern."' '".a:opt."'"

    "let g:HiLogLevel = 4
    if a:color == ""
        call confirm("Remove all color highlighting")
        echo "Highlight clear"
        call hi#config#SyntaxClear()
        call hi#config#ListClear()
        "let g:HiLogLevel = 0
        return
    endif

    " Check color available on color list
    if hi#config#ColorCheck(a:color) != 0
        call hi#log#Error("Color:".a:color." not found")
        return 1
    endif
    "let found = 0
    "for colorDefinitions in g:HiColorDefinitionList
        "if colorDefinitions[0] == toupper(a:color)
            "let found = 1
        "endif
    "endfor
    "if l:found == 0
        "call hi#log#Error("Color:".a:color." not found")
        ""let g:HiLogLevel = 0
        "return 1
    "endif

    " Check not duplicated highlight
    if exists("w:ColoredPatternsList")
        let newCfgList = [ a:color, a:pattern, a:opt ]
        for cfgList in w:ColoredPatternsList
            if l:cfgList == l:newCfgList
                " Duplicated configuration. Already in use.
                call hi#log#Warn("Duplicated highlight")
                "let g:HiLogLevel = 0
                return 0
            endif
        endfor
    endif

    let pattern = a:pattern
    let pattern = substitute(l:pattern, '/', '\\/', 'g')

    if a:opt =~# "c"
        " Force case insensitive
        let case = "\\c"
    elseif a:opt =~# "C"
        " Force case sensitive
        let case = "\\C"
    else
        let case = ""
    endif

    if a:opt =~# "l"
        let l:line0 = "^.*"
        let l:line1 = ".*"
    else
        let l:line0 = ""
        let l:line1 = ""
    endif

    " Highlight command don't allow using characters: !"·$%&/()=?¿^*{}[]`+-_.,;:¡
    " Transform characters
    "    Bold modifier      : ! change to B
    "    Background color   : @ change to H
    "    Background color   : # change to H
    "    Underline modifier : _ change to U
    "    Highlight on top   : 0 change to T
    "    Highlight only     : - change to h
    let l:color = a:color
    let l:color = substitute(l:color,'!','B','')
    let l:color = substitute(l:color,'#','H','')
    let l:color = substitute(l:color,'@','H','')
    let l:color = substitute(l:color,'_','U','')
    let l:color = substitute(l:color,'0','T','')
    let l:color = substitute(l:color,'-','h','')
    let l:color = substitute(l:color,',','t','')

    let l:contains=""
    "if a:opt =~ "T"
    if a:opt =~# "T"
        ":help syn-containedin
        ":help syn-contains 
        ":help highlight-groups
        ":help naming-conventions
        "let l:contains=" contains=ALL"
        "let l:contains=" containedin=ALL contained"
        let l:contains=" containedin=ALL"
    endif

    if a:opt =~# "b"
        " Highlight a block with init and end pattern, optional skip " pattern.
        let l:skip = ""
        let list = split(l:pattern,">>")
        if len(l:list) < 2
            call hi#log#Error("Block error, not enough arguments ".len(l:list))
            "let g:HiLogLevel = 0
            return
        endif
        let n = 0
        let init = " start=/".l:case.l:line0.l:list[l:n].l:line1."/" | let n += 1
        if len(l:list) > 2
            let skip = " skip=/".l:case.l:list[l:n]."/"
            let n += 1
        endif
        let end  = " end=/".l:case.l:line0.l:list[l:n].l:line1."/"
        let cmd  = "syn region HiColor".toupper(l:color).l:init.l:skip.l:end.l:contains
    else
        " Highlight pattern only
        let pattern = "/".l:case.l:line0.l:pattern.l:line1."/"
        let cmd = "syn match HiColor".toupper(l:color)." ".l:pattern.l:contains
    endif

    call hi#log#Verbose(1, expand('<sfile>'), l:cmd)
    "echom "HilightCmd: ".l:cmd
    silent exec(l:cmd)

    call hi#config#AddColorConfig(a:color,a:pattern,a:opt)
    return 0
endfunction


func! hi#config#AddColorConfig(color,pattern,opt)
    " Save this config
    if !exists("w:ColoredPatternsList")
        let w:ColoredPatternsList = []
    endif
    call hi#log#Verbose(1, expand('<sfile>'), a:color." ".a:pattern." ".a:opt)
    call add(w:ColoredPatternsList, [ "Mark", a:color, a:pattern, a:opt ])
endfunc


func! hi#config#SetTitle(configLine)
    call hi#log#Verbose(1, expand('<sfile>'), a:configLine)
    let l:configLine = substitute(a:configLine, '\[', '', '')
    let l:configLine = substitute(l:configLine, ']', '', '')
    let w:AllConfigTypeNames = hi#utils#TrimString(l:configLine)
endfunc

func! hi#config#AddComment(string)
    if !exists("w:ColoredPatternsList")
        let w:ColoredPatternsList = []
    endif
    call hi#log#Verbose(1, expand('<sfile>'), a:string)
    call add(w:ColoredPatternsList, [ a:string, " ", " ", " " ])
    "call add(w:ColoredPatternsList, [ a:string ])
endfunc


func! hi#config#AddCommand(command,value)
    if !exists("w:ColoredPatternsList")
        let w:ColoredPatternsList = []
    endif
    let l:command = hi#utils#TrimString(a:command)
    call hi#log#Verbose(1, expand('<sfile>'), l:command." ".a:value)
    call add(w:ColoredPatternsList, [ l:command, a:value, " ", " " ])
    "call add(w:ColoredPatternsList, [ l:command, a:value, " ", " " ])
    "call add(w:ColoredPatternsList, [ l:command, a:value ])
endfunc

" Parse the command configurations and its options.
" Perform the required actions.
" Arg1: command: Filt, Conf, Win, Cmd, Goto...
" Arg2: command options separated with '|'.
"
"  Command: Filt/Filtv/Filtt/Filtw. Args: close/sync/
"  Command: Conf. Args: clean/savd/edit/off/on/won/woff
"  Command: Goto. Args: parent/base/son
func! hi#config#ApplyCommand(cmd,options)
    call hi#log#Verbose(1, expand('<sfile>'), a:cmd." = ".a:options)

    let l:cmd = a:cmd

    if a:options =~ "|"
        let l:optionsList = split(a:options, '|')
    else
        let l:optionsList =  [ a:options ]
    endif

    if l:cmd =~ "Filt"
        if a:options =~ "close"
            call hi#windowFamily#CloseAll()
        elseif l:optionsList[0] =~ "sync"
            call hi#filterSynch#SyncWindowPosition("")
        elseif l:optionsList[0] =~ "sync_switch"
            call hi#filterSynch#SyncSwitchWindowPosition("")
        else
            if a:options =~ "all"
                let l:optionsList[0] = substitute(a:options, "all", "", "g")
            endif

            let l:resize = ""

            if len(l:optionsList) >= 2
                let options2 = l:optionsList[1]
            else
                let options2 = ""
            endif

            if l:cmd =~ "Filtt"
                " Open new tab with the selected highlighted lines
                call hi#filter#Color("tabnew",l:optionsList[0],l:options2,"")

            elseif l:cmd =~ "Filtv"
                " Open new vertical split with the selected highlighted lines
                call hi#filter#Color("vnew",l:optionsList[0],l:options2,"")
                let l:resize = "vertical resize"

            elseif l:cmd =~ "Filtw"
                " Do not open split, show filter results on current window.
                call hi#filter#Color("",l:optionsList[0],l:options2,"")
                let l:resize = "resize"
            else
                " Open new split with the selected highlighted lines
                call hi#filter#Color("split",l:optionsList[0],l:options2,"")
                let l:resize = "resize"
            endif

            if l:resize != ""
                if len(l:optionsList) >= 3 && l:optionsList[2] != ""
                    silent exec(l:resize." ".l:optionsList[2])
                endif
            endif
        endif

    elseif l:cmd =~ "Goto"
        " If we're on config editor  window, return to base window.
        call hi#configEditor#GotoBaseWin()

        if l:optionsList[0] =~ "first" || l:optionsList[0] =~ "base"
            call hi#windowFamily#GotoFirstParentWindow()
        elseif l:optionsList[0] =~ "parent"
            call hi#windowFamily#GotoParent()
        elseif l:optionsList[0] =~ "son"
            call hi#windowFamily#GotoFirstSon()
        elseif l:optionsList[0] =~ "last"
            call hi#windowFamily#GotoLastSonWindow()
        elseif l:optionsList[0] =~ "down"
            wincmd j
        elseif l:optionsList[0] =~ "up"
            wincmd k
        else
            return
        endif

    elseif l:cmd == "Conf"
        if l:optionsList[0] =~ "clear" || l:optionsList[0] =~ "clean"
            call hi#config#SyntaxClear()
            call hi#config#ListClear()
        elseif l:optionsList[0] == "on"
            call hi#config#On()
        elseif l:optionsList[0] == "off"
            call hi#config#Off()
        elseif l:optionsList[0] == "won"
            call hi#config#WindowOn()
        elseif l:optionsList[0] == "woff"
            call hi#config#WindowOff()
        elseif l:optionsList[0] =~ "save"
            call hi#fileConfig#SaveModifications()
        elseif l:optionsList[0] =~ "edit"
            "call hi#configEditor#Open(0,"")
            call hi#configEditor#Reload()
            if len(l:optionsList) >= 2 && l:optionsList[1] != ""
                silent exec("vertical resize ".l:optionsList[1])
            endif
        elseif l:optionsList[0] =~ "add"
            "if len(l:optionsList) >= 2 && l:optionsList[1] =~ "disable" || l:optionsList[1] =~ "comment"
                "call hi#configTypes#LoadConfigType(l:optionsList[1], "applyConfig", "noSaveTitle", "comment")
            "else
                "call hi#configTypes#LoadConfigType(l:optionsList[1], "applyConfig", "noSaveTitle", "noComment")
            "endif
            call hi#configTypes#LoadConfigType(l:optionsList[1], 1, 0)
            "call hi#configTypes#LoadConfigType(l:optionsList[0], "applyConfig", "noSaveTitle", , "noComment")
        endif

    elseif l:cmd =~ "Find"
        if len(l:optionsList) >= 2 && l:optionsList[1] != ""
            silent! call hi#hi#Search(l:optionsList[1], l:optionsList[0])
        else
            silent! call hi#hi#Search("fw", l:optionsList[0])
        endif
        normal n

    elseif l:cmd == "Group"

    elseif l:cmd == "Cmd"
        "echom "ExecCmd: ".l:optionsList[0]
        silent exec(l:optionsList[0])

    elseif l:cmd =~ "Tail"
        call hi#tail#Toogle(l:optionsList[0])
    else
        return 1
    endif

    " Save this config
    "call hi#config#AddCommand(l:cmd,l:optionsList[0])
    call hi#config#AddCommand(l:cmd,a:options)
    return 0
endfunction


" Apply again current color highlighting configuration
function! hi#config#ColorReload(color,pattern,opt)
    "echom "ColorReload: ".a:color." ".a:pattern." ".a:opt
    if a:color == ""
        call confirm("Remove all color highlighting")
        echo "Highlight clear"
        call hi#config#SyntaxClear()
        call hi#config#ListClear()
        return
    endif

    if a:pattern == ""
        return 1
    endif

    let pattern = a:pattern
    let pattern = substitute(l:pattern, '/', '\\/', 'g')

    if a:opt =~# "c"
        " Force case insensitive
        let case = "\\\c"
    elseif a:opt =~# "C"
        " Force case sensitive
        let case = "\\\C"
    else
        let case = ""
    endif

    if a:opt =~# "l"
        " Highlight all line
        let line0 = "^.*"
        let line1 = ".*"
    else
        " Highlight pattern only
        let line0 = ""
        let line1 = ""
    endif

    let l:color = a:color
    let l:color = substitute(l:color,'!','B','')
    let l:color = substitute(l:color,'#','H','')
    let l:color = substitute(l:color,'@','H','')
    let l:color = substitute(l:color,'_','U','')
    let l:color = substitute(l:color,'0','T','')
    let l:color = substitute(l:color,'-','h','')
    let l:color = substitute(l:color,',','t','')

    let l:cmd = ""

    if a:opt =~# "b"
        " Highlight a block with init and end pattern, optional skip " pattern.
        let l:skip = ""
        let list = split(a:pattern,">>")
        if len(l:list) < 2
            call hi#log#Error("Block error, not enough arguments ".len(l:list))
            return
        endif
        let n = 0
        let init = " start=/".l:case.l:line0.l:list[l:n].l:line1."/" | let n += 1
        if len(l:list) > 2
            let skip = " skip=/".l:case.l:list[l:n]."/"
            let n += 1
        endif
        let end  = " end=/".l:case.l:line0.l:list[l:n].l:line1."/"
        let cmd  = "syn region HiColor".toupper(l:color).l:init.l:skip.l:end." contains=TOP"
    else
        " Highlight pattern only
        let l:pattern = "/".l:case.l:line0.l:pattern.l:line1."/"
        let cmd = "syn match HiColor".toupper(l:color)." ".l:pattern." contains=TOP"
        "let cmd = "syn match HiColor".toupper(l:color)." ".l:pattern
    endif

    "echom "ColorReload: ".l:cmd
    call hi#log#Verbose(1, expand('<sfile>'), l:cmd)
    silent exec(l:cmd)
endfunction


"
" Get the patterns related to the requested colors.
" If the requested colors are empty, get all patterns.
" Arg1: add patterns with this colors. string with color IDs and patterns (ex: "y m1 c myPattern r! _??  g*@??").
" Arg1: skip patterns with this colors. string with color IDs or patterns (ex: "y1 m2 c! omittPattern _?? g*@??").
" Arg2: pattern separator string (ex: "###").
" Arg3: mode, search/filter. Mode filter will not return patterns with option 'h' (highlight only) set.
" Return: array with all patterns separated with word 'separator'
function! hi#config#GetColorPatterns(colors,ncolors,separator,mode)
    "let g:HiLogLevel = 2
    call hi#log#Verbose(2, expand('<sfile>'), "")

    call hi#log#Verbose(1, expand('<sfile>'), "colors:'".a:colors."' sep:'".a:separator."'")

    let l:skipColors = ""
    let l:showColors = ""

    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0 | return "" | endif

    let l:showColorList = []
    if  a:colors != ""
        call hi#log#Verbose(2, expand('<sfile>'), "keep colorIDs: ".a:colors)
        let showColorList = split(toupper(a:colors), ' ')
        let l:showColors = a:colors
    endif

    let l:omittColorList = []
    if  a:ncolors != ""
        call hi#log#Verbose(2, expand('<sfile>'), "omitt colorIDs: ".a:ncolors)
        let omittColorList = split(toupper(a:ncolors), ' ')
        let l:skipColors = a:ncolors
    endif

    if a:colors == "" && a:ncolors == ""
        let l:showColors = hi#config#GetHihglightColorIDs()
        let showColorList = split(toupper(l:showColors), ' ')
    endif

    let search = ""
    let l:CurrentGroupNames = ""

    " Iterate on all colors highlighted on the current buffer
    for coloredPatterns in w:ColoredPatternsList

        if l:coloredPatterns[0] == "Group"
            let l:CurrentGroupNames = l:coloredPatterns[1]
            "call hi#log#VerboseStop(0, expand('<sfile>'), "Group:'".l:CurrentGroupNames)

        elseif l:coloredPatterns[0] == "Mark"
            let color = l:coloredPatterns[1]
            let pattern  = l:coloredPatterns[2]
            let opt  = l:coloredPatterns[3]

            "call hi#log#VerboseStop(0, expand('<sfile>'), "cmd:'".l:coloredPatterns[0]."' colors:'".l:color."' str:'".l:pattern."' opt:'".l:opt."'")

            " Region pattern
            if l:opt =~# "b" | continue | endif

            " Highlight only, non-filter pattern
            if a:mode =~# "filter" && l:opt =~# "h" | continue | endif

            if l:skipColors != ""
                call hi#log#Verbose(2, expand('<sfile>'), "ncolors: ". l:skipColors )
                let omittFlag = 0
                for omittColor in l:omittColorList
                    call hi#log#Verbose(2, expand('<sfile>'), "check omitt colorID: ".l:color." ".l:omittColor)
                    if l:omittColor == "??" | continue | endif
                    if l:omittColor =~ "??"
                        " Search for similar color configuration name.
                        call hi#log#Verbose(2, expand('<sfile>'), "check omitt similar colorID: ".l:color." ".l:omittColor)
                        if l:color =~ l:omittColor
                            let omittFlag = 1
                            call hi#log#Verbose(2, expand('<sfile>'), "omitt similar colorID: ".l:color." pattern:".l:pattern)
                            break
                        endif
                    else
                        call hi#log#Verbose(2, expand('<sfile>'), "check omitt colorID: ".l:color." ".l:omittColor)
                        if l:color == l:omittColor
                            let omittFlag = 1
                            call hi#log#Verbose(2, expand('<sfile>'), "omitt colorID: ".l:color." pattern:".l:pattern)
                            break
                        endif
                    endif
                    if l:omittFlag == 0
                        if l:search != ""
                            let search .= a:separator
                        endif
                        let search .= l:pattern
                    endif
                    "if l:pattern == l:omittColor
                        "let omittFlag = 1
                        "call hi#log#Verbose(2, expand('<sfile>'), "omitt colorID: ".l:color." pattern:".l:pattern)
                        "break
                    "endif
                endfor
                if l:omittFlag == 1 | continue | endif
            endif

            if l:showColors != ""
                call hi#log#Verbose(2, expand('<sfile>'), "showColors: ". l:showColors )

                let showFlag = 0

                " Iterate on all selected colors to be displayed
                for showColor in l:showColorList
                    call hi#log#Verbose(2, expand('<sfile>'), "check colorID: ". l:color ." ". l:showColor )

                    "call hi#log#Verbose(0, expand('<sfile>'), "check colorID: ". l:color ." ". l:showColor )
                    "call hi#log#VerboseStop(0, expand('<sfile>'), "IsNamedGroup?: ".l:showColor[1:]." ".l:CurrentGroupNames)

                    if l:showColor == "??" | continue | endif

                    if l:showColor =~ "??"
                        " Search for similar color configuration name.
                        let l:showColor = substitute(l:showColor, "??", "", "g")
                        call hi#log#Verbose(2, expand('<sfile>'), "check keep similar colorID: ". l:color ." ". l:showColor )

                        if l:color =~ l:showColor
                            " Color found, add color to the search list
                            call hi#log#VerboseStop(2, expand('<sfile>'), "show colorID: ". l:color ." pattern:". l:pattern )

                            if l:search != ""
                                let search .= a:separator
                            endif
                            let search .= l:pattern
                        endif

                    elseif l:showColor =~ "&g[0-9]"
                        " Highlight numeric group. Ex: &g12
                        if l:opt =~ l:showColor[1:]
                            if l:search != ""
                                let search .= a:separator
                            endif
                            let search .= l:pattern
                            continue
                        endif

                    elseif l:showColor =~ "&[a-zA-Z]"
                        "call hi#log#VerboseStop(0, expand('<sfile>'), "IsSelectedGroup?: ".l:showColor[1:]." ".l:CurrentGroupNames)
                        if l:CurrentGroupNames =~? l:showColor[1:]
                            " Highlight named group. Ex: &myGroupName
                            "call hi#log#VerboseStop(0, expand('<sfile>'), "foundGroup: ".l:showColor[1:]." ".l:CurrentGroupNames)
                            if l:search != ""
                                let search .= a:separator
                            endif
                            let search .= l:pattern
                            continue
                        endif
                    
                    else
                        " Search for exact same color configuration name.
                        call hi#log#Verbose(2, expand('<sfile>'), "check keep colorID: ".l:color." ".l:color)

                        if l:color == l:showColor || l:showColor ==# "all"
                            " Color found, add color to the search list
                            let showFlag = 1 " Found, exit the loop
                            call hi#log#Verbose(2, expand('<sfile>'), "show colorID: ".l:color." pattern:".l:pattern)

                            if l:search != ""
                                let search .= a:separator
                            endif
                            let search .= l:pattern
                            break
                        endif
                    endif
                endfor
                if l:showFlag == 0 | continue | endif
            endif
        endif
    endfor
    call hi#log#Verbose(1, expand('<sfile>'), "patterns:'".l:search."'")
    "call hi#log#VerboseStop(1, expand('<sfile>'), "patterns:'".l:search."'")
    "let g:HiLogLevel = 0
    return l:search
endfunction


" Get only patterns found on Arg1 string, not color IDs.
" Used to separate patterns from color IDs
" Arg1: string with colors and patterns (ex: "y m1 c myPattern r!").
" Arg2: pattern separator string.
" Return: string with all patterns separated with the giver string separator string
function! hi#config#GetNonColorPatterns(colorsPatterns,separator)
    call hi#log#Verbose(1, expand('<sfile>'), "colorsPatterns:'".a:colorsPatterns."' sep:'".a:separator."'")

    if a:colorsPatterns == "" | return "" | endif

    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        let l:result = substitute(a:colorsPatterns, ' ', a:separator, 'g')
        return l:result
    endif

    let patternsStr = ""

    " Iterate every given color/pattern.
    for colorPattern in split(a:colorsPatterns, ' ')
        " Skip highlight color configuration wildcard
        if l:colorPattern =~ "??" | continue | endif
        " Skip highlight configuration numeric groups
        if l:colorPattern =~ "&g[0-9]" | continue | endif
        " Skip highlight configuration named groups
        if l:colorPattern =~ "&[a-zA-Z][a-zA-Z]" | continue | endif

        let l:colorCheck = toupper(l:colorPattern)
        let l:colorIDFound = 0

        " Iterate every defined color ID.
        for colorDefinitions in g:HiColorDefinitionList
            let colorID = l:colorDefinitions[0]

            call hi#log#Verbose(2, expand('<sfile>'), "Check color: ".l:colorID." with given color/pattern: ".l:colorCheck)
            "echom "Check color: ".l:colorID." with given color/pattern: ".l:colorCheck

            " Check if giver color/pattern matches a color ID.
            if l:colorID == l:colorCheck
                let l:colorIDFound = 1
                call hi#log#Verbose(2, expand('<sfile>'), "Found color ID: ".l:colorPattern)
                "echom "Found color ID: ".l:colorPattern
                break
            endif
        endfor

        if l:colorIDFound == 0
            call hi#log#Verbose(2, expand('<sfile>'), "Color ID not found. Pattern: ".l:colorPattern)
            "echom "Color ID not found. Pattern: ".l:colorPattern

            " Non color ID, safe on patterns string.
            if l:patternsStr != ""
                let patternsStr .= a:separator
            endif
            let patternsStr .= l:colorPattern
        endif
    endfor

    call hi#log#Verbose(2, expand('<sfile>'), "patterns:'".l:patternsStr."'")
    "echom "patterns:'".l:patternsStr."'"
    return l:patternsStr
endfunction


" Get the patterns related to regions with requested colors.
" Return: list with all region patterns init>>end
function! hi#config#GetColorRegionPatterns(colors)
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0 | return "" | endif

    let showColorList = []
    if  a:colors != ""
        let showColorList = split(toupper(a:colors), ' ')
    endif

    let searchList = []

    for coloredPatterns in w:ColoredPatternsList
        if l:coloredPatterns[0] == "Mark"
            let color   = l:coloredPatterns[1]
            let pattern = l:coloredPatterns[2]
            let opt     = l:coloredPatterns[3]

            if l:opt !~# "b"
                " NOT Region pattern
                continue
            endif

            if a:colors != ""
                let showFlag = 0
                for showColor in l:showColorList
                    if l:color == l:showColor
                        let showFlag = 1
                        break
                    endif
                endfor
                if l:showFlag == 0 | continue | endif
            endif
            call add(l:searchList, l:pattern)
        endif
    endfor

    return l:searchList
endfunction


" Get the patterns highlighted on current window highlight configuration.
" Return: space separated array with all patterns used.
" Cmd: Hishp
function! hi#config#ShowPatterns()
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return
    endif

    let patterns = "'"
    for coloredPatterns in w:ColoredPatternsList
        if l:coloredPatterns[0] == "Mark"
            if l:patterns != "'"
                let l:patterns .= "|"
            endif
            let l:patterns .= l:coloredPatterns[2]
        endif
    endfor
    let patterns .= "'"
    echo l:patterns
    return l:patterns
endfunction


" Get the color IDs used on current highlights.
" Return: space separated array with all colorIDs used.
function! hi#config#GetHihglightColorIDs()
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return
    endif

    let colorIds = ""
    for coloredPatterns in w:ColoredPatternsList
        if l:coloredPatterns[0] == "Mark"
            let colorIds .= l:coloredPatterns[1]." "
        endif
    endfor
    echo l:colorIds
    return l:colorIds
endfunction


" Clear all highlights for the selected color
" Commands: Hicrm
function! hi#config#RmColor(color)
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return ""
    endif

    if a:color == ""
        call confirm("Remove all color highlighting")
        echo "Highlight clear"
        call hi#config#SyntaxClear()
        call hi#config#ListClear()
        return
    endif

    let color = toupper(a:color)
    let cmd = "syn clear HiColor".l:color
    silent exec(l:cmd)

    let n = 0
    for coloredPatterns in w:ColoredPatternsList
        if l:coloredPatterns[0] !~ "Mark"
            continue
        endif
        if l:coloredPatterns[1] ==# l:color
            " Remove from the highlighted colors/patterns list
            echo "Remove highlight pattern ".l:coloredPatterns[2]." color ".l:coloredPatterns[1]
            call remove(w:ColoredPatternsList, l:n)
        endif
        let n += 1
    endfor

    call hi#fileConfig#AutoSaveColorHiglighting()
    call hi#filterSynch#AutoSyncFiltWindowData()
endfunction


" Show the color configuration
function! hi#config#ShowHighlightCfg(cfgList)
    call hi#log#Verbose(1, expand('<sfile>'), "")

    if exists("w:AllConfigTypeNames")
        if w:AllConfigTypeNames != ""
            "let l:str = hi#utils#EncloseOnRectangle([w:AllConfigTypeNames],"normal",0) | echo l:str
            echo "[".w:AllConfigTypeNames."]"
        endif
    endif

    echo "Pos) Mark Color Opt  Highlight_pattern"
    echo "Pos) Cmd  Arguments"
    echo "--------------------------------------"
    let n = 0
    for cfgList in a:cfgList

        let l:command = hi#utils#TrimString(l:cfgList[0])

        if l:command[0:0] == "#"
            " Do not show comments.
            call hi#log#Verbose(2, expand('<sfile>'), "Comment: ".l:cfgList[0])

        elseif l:command == "Mark"
            call hi#log#Verbose(2, expand('<sfile>'), "Mark: ".l:cfgList[0])

            let colorId = l:cfgList[1]
            let pattern = l:cfgList[2]
            let flags   = l:cfgList[3]

            if l:flags != ""
                let l:flags = "+".l:flags
            endif

            " Highlight command don't allow using characters: !"·$%&/()=?¿^*{}[]`+-_.,;:¡
            " Transform characters
            "    Bold modifier      : ! change to B
            "    Background color   : # change to H
            "    Underline modifier : _ change to U
            "    Highlight on top   : 0 change to T
            "    Bottom highlight   : , change to t
            "    Highlight only     : - change to h
            let l:color = l:colorId
            let l:color = substitute(l:color,'!','B','')
            let l:color = substitute(l:color,'#','H','')
            let l:color = substitute(l:color,'@','H','')
            let l:color = substitute(l:color,'_','U','')
            let l:color = substitute(l:color,'0','T','')
            let l:color = substitute(l:color,'-','h','')
            let l:color = substitute(l:color,',','t','')

            if l:flags =~ "l"
                echo printf("%3d) ", l:n)
                exec("echohl HiColor".toupper(l:color))
                echon printf("%s %' '-5s %' '-8s \"%s\"", l:command , l:colorId, l:flags, l:pattern)
            else
                echo printf("%3d) %s %' '-5S %' '-8s ", l:n, l:command, l:colorId, l:flags)
                exec("echohl HiColor".toupper(l:color))
                echon printf("\"%s\"", l:pattern)
            endif

        elseif l:command == "Conf"
            let l:value = hi#utils#TrimString(l:cfgList[1])
            " Omitt any config command different than: clean, clear, save, edit
            if l:value != "add"
            "if l:value == "clear" || l:value == "clean" || l:value == "save" || l:value == "edit"
                call hi#log#Verbose(2, expand('<sfile>'), "Command: ".l:cfgList[0]." Value: ".l:cfgList[1])
                echo printf("%3d) %s %s\n", l:n, l:command , l:cfgList[1])
            endif

        else
            call hi#log#Verbose(2, expand('<sfile>'), "Command: ".l:cfgList[0]." Value: ".l:cfgList[1])
            echo printf("%3d) %s %s\n", l:n, l:command , l:cfgList[1])
        endif

        echohl None
        let n += 1
        "call input("")
    endfor
    echo ""
    echo "*Opt. +C : case sensitive, +c : case insensitive, +l : highlight all, +b : highlight region"
    echo "*Opt. +T : highlight on top of any other highlight, +B : highlight on bottom of any other highlight."
    echo "*Opt. +h : omitt pattern on any filter."
    echo "*Opt. +g[0-9][0-9] : assign group number."
endfunction


" Show current hightlight settings
" Command: Hish
function! hi#config#ShowCurrentHighlightCfg()
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return 1
    endif
    call hi#config#ShowHighlightCfg(w:ColoredPatternsList)
    call input("(press any key)")
    return 0
endfunction


" Remove pattern hightlight
" Command: Hirm
function! hi#config#RmPattern()
    "if hi#config#ShowCurrentHighlightCfg() != 0
        "return 1
    "endif
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return 1
    endif
    call hi#config#ShowHighlightCfg(w:ColoredPatternsList)

    let n = input("Remove patterns:")
    if l:n == "" | return 1 | endif

    " Remove from the highlighted colors/patterns list
    " First remove content on elment 0 of the list
    " Afterwards remove all list elements with empty position 0.
    " This fixes removing several positions at the same time.
    for i in split(l:n,' ')
        let w:ColoredPatternsList[l:i][0] = ""
    endfor

    echo " "
    echo " "

    let i = 0
    for pattern in w:ColoredPatternsList
        "if l:pattern[0] != "Mark"
            "continue
        "endif
        if l:pattern[0] == ""
            echo "Remove position ".l:i.": ".l:pattern[2]
            call remove(w:ColoredPatternsList, l:i, l:i)
        else
            let i += 1
        endif
    endfor

    call hi#config#SyntaxReload()

    call hi#fileConfig#AutoSaveColorHiglighting()
    call hi#filterSynch#AutoSyncFiltWindowData()
    redraw

    " Update the hihglight config editor window
    call hi#configEditor#Reload()
endfunction


" Remove last pattern hightlight
" Command: Hiu
function! hi#config#RmLastPattern()
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return ""
    endif

    let n = len(w:ColoredPatternsList)-1

    let color   = w:ColoredPatternsList[l:n][1]
    let pattern = w:ColoredPatternsList[l:n][2]

    "let msg = "Remove highlight color ".l:color." pattern ".l:pattern." (pos:".l:n.")"
    "if confirm (l:msg, "&yes\n&no", 2) == 2
        "return
    "endif

    " Remove from the highlighted colors/patterns list
    "call remove(w:ColoredPatternsList, l:n, l:n)
    call remove(w:ColoredPatternsList, l:n)

    silent call hi#config#SyntaxReload()
    silent call hi#fileConfig#AutoSaveColorHiglighting()
    silent call hi#filterSynch#AutoSyncFiltWindowData()

    " Update the hihglight config editor window
    call hi#configEditor#Reload()
endfunction


" Get color Ids for wildmenu
" Return: list with all color IDs matching ArgLead
function! hi#config#ColorsIDWildmenu(ArgLead, CmdLine, CursorPos)
    let resultList = []
    if exists("g:HiColorDefinitionList")
        for tmpList in g:HiColorDefinitionList
            if l:tmpList[0] =~ a:ArgLead
                call add(l:resultList, tolower(l:tmpList[0]))
            endif
        endfor
    endif
    return l:resultList
endfunction


" Get current patterns for wildmenu
" Return: list with all patterns matching ArgLead
function! hi#config#UsedPatternsWildmenu(ArgLead, CmdLine, CursorPos)
    let resultList = []
    if exists("g:HiColorDefinitionList")
        for tmpList in w:ColoredPatternsList
            if l:tmpList[1] =~ a:ArgLead
                call add(l:resultList, l:tmpList[1])
            endif
        endfor
    endif
    return l:resultList
endfunction


" Get current colors for wildmenu
" Return: list with all patterns matching ArgLead
function! hi#config#UsedColorsWildmenu(ArgLead, CmdLine, CursorPos)
    let resultList = []
    if exists("g:HiColorDefinitionList")
        for tmpList in w:ColoredPatternsList
            if l:tmpList[0] =~ "Mark"
                if l:tmpList[1] =~ a:ArgLead
                    call add(l:resultList, l:tmpList[1])
                endif
            endif
        endfor
    endif
    return l:resultList
endfunction


" Highlight match pattern with selected color
" Commands: Hic
function! hi#config#PatternColorize(...)
    if a:0 < 1
        call hi#log#Error("Args: pattern [colorId]")
        return
    endif

    " Last argument is color ID
    let color = {"a:".a:0}
    call hi#log#Verbose(1, expand('<sfile>'), "color:".l:color)

    if a:0 < 2 || ( a:0 >= 2 && hi#config#ColorCheck(l:color) != 0 )
        " Show color help menu
        call hi#help#ColorIdHelp("")
        " Choose color
        let color = input("select color id: ")
        if  l:color == "" | return | endif
        echo " "
    endif

    "
    let pattern = a:1
    let n = 2
    while l:n < a:0
        let pattern .= " ".{"a:".l:n}
        let n += 1
    endwhile

    let l:searchList = [ ]

    "echom "Color:".l:color | return
    let opt = ""
    if l:color =~ "&"
        " highlight region
        let color = substitute(l:color,'&','','g')
        let opt = "b"
        if l:color =~ "*"
            let color = substitute(l:color,'\*','','g')
            let opt .= "l"
        endif
        let l:list = split(l:pattern, g:HiBlockSeparator)
        let l:len = len(l:list)
        let l:searchList += [ l:list[0] ]
        let l:searchList += [ l:list[l:len-1] ]
    elseif l:color =~ "*"
        " highlight all line
        let color = substitute(l:color,'\*','','g')
        let opt = "l"
        let l:searchList += [ l:pattern ]
    elseif l:color =~ "^"
        " highlight on top
        "let color = substitute(l:color,'0','','g')
        let color = substitute(l:color,'\^','','g')
        let opt = "T"
        let l:searchList += [ l:pattern ]
    elseif l:color =~ "-"
        " highlight omitt for filter
        let color = substitute(l:color,'-','','g')
        let opt = "h"
        let l:searchList += [ l:pattern ]
    "elseif l:color =~ "."
        "" highlight on bottom
        "let color = substitute(l:color,'.','','g')
        "let opt = "B"
        "let l:searchList += [ l:pattern ]
    elseif l:color =~ ","
        echom "bottom option found"
        " highlight on bottom
        let color = substitute(l:color,',','','g')
        let opt = "t"
        let l:searchList += [ l:pattern ]
    else
        " highlight only the matching pattern
        let opt = ""
        let l:searchList += [ l:pattern ]
    endif

    " Check pattern available on the file
    if g:HiCheckPatternAvailable == 1
        for tmp in l:searchList
            if search(l:tmp) <= 0
                call hi#log#Warn("Pattern:".l:tmp." not found")
                if confirm("","Continue? &yes\n&no",2) == 2
                    return
                endif
            endif
        endfor
    endif

    if l:pattern[0:1] ==# "\\c"
        " Case insensitive match
        let opt .= "c"
        let pattern = substitute(l:pattern,'\\c','','g')
    elseif l:pattern[0:1] ==# "\\C"
        " Case sensitive match
        let opt .= "C"
        let pattern = substitute(l:pattern,'\\C','','g')
    else
        let opt .= g:HiDefaultCase
    endif

    if hi#config#PatternHighlight(l:color,l:pattern,l:opt) != 0
        return
    endif

    if l:pattern != ""
        call hi#fileConfig#AutoSaveColorHiglighting()
        call hi#filterSynch#AutoSyncFiltWindowData()
    endif

    " Refresh
    call hi#config#Reload()
    call hi#config#SyntaxReload()

    " Update the hihglight config editor window
    call hi#configEditor#Reload()
endfunction


" Yank current config into register
" Arg1: [optional] register where saving the config, default register
" if empty.
" Return: 0 on success, 1 on error.
" Cmd: Hiy
function! hi#config#ConfigYank(register)
    call hi#log#Verbose(1, expand('<sfile>'), "")

    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return 1
    endif

    let l:configName = "NAME"

    if exists('w:AllConfigTypeNames')
        if w:AllConfigTypeNames != ""
            let l:configName = w:AllConfigTypeNames
        endif
    endif

    if exists('w:LastConfigTypeName')
        if w:LastConfigTypeName != ""
            let l:configName = w:LastConfigTypeName
        endif
    endif

    let configBuff  = ""
    let configLine  = printf("[".l:configName."]\n")
    let configBuff .= l:configLine

    for config in w:ColoredPatternsList
        if l:config[0][0] == "#"
            let configLine  = printf("%s\n", l:config[0])
            let configBuff .= l:configLine
            call hi#log#Verbose(2, expand('<sfile>'), l:configLine)

        elseif l:config[0] == "Mark"
            call hi#log#Verbose(2, expand('<sfile>'), "Mark: ".l:config[0])

            let color   = substitute(l:config[1],'#','@','g')
            let options = l:config[2]
            let pattern = substitute(l:config[3],'\\','\\\','g')
            let pattern = substitute(l:config[3],'\','\\','g')
            let pattern = substitute(l:config[3],'/','\\/','g')
            let pattern = substitute(l:config[3],'"','\\"','g')


            let configLine  = printf("%s = %' '-5S| %' '-10S |%s\n", l:config[0], l:color, l:pattern, l:options )
            let configBuff .= l:configLine
            call hi#log#Verbose(2, expand('<sfile>'), l:configLine)
        else
            let configLine  = printf("%s = %s\n", l:config[0], l:config[1] )
            let configBuff .= l:configLine
            call hi#log#Verbose(2, expand('<sfile>'), l:configLine)
        endif
    endfor
    call hi#log#Verbose(2, expand('<sfile>'), l:configBuff)

    if a:register == ""
        let @" = l:configBuff
        let l:registerName = "default"
    else
        silent exec "let @".a:register." = '".l:configBuff."'"
        let l:registerName = a:register
    endif

    echo "Config copied to register: ".l:registerName
    return 0
endfunction


function! hi#config#HighlightWord()
    call hi#config#PatternColorize(escape(expand('<cword>'),' \'))
endfunction


function! hi#config#HighlightWholeWord()
    call hi#config#PatternColorize(escape(expand('<cword>'),' \'))
endfunction


function! hi#config#HighlightLine(color)
    call hi#config#PatternColorize(escape(getline('.'),' \'),a:color)
endfunction


function! hi#config#IsTitle(command)
    "echom "IsTitle: ".a:command
    let res = 0
    "let l:command = hi#utils#TrimString(a:command)
    "if l:command =~ "^[" && l:command =~ "]$" | let res = 1 | endif
    if a:command[0:0] == "[" && a:command =~ "^\[[a-zA-Z].*]$"
        let res = 1
        "echom "IsTitle found: ".a:command
    endif 
    call hi#log#Verbose(1, expand('<sfile>'), a:command." ".l:res)
    return l:res
endfunction


function! hi#config#IsCommandOrColor(command)
    if hi#config#IsCommand(a:command)   | return 1 | endif
    if hi#config#IsColorMark(a:command) | return 1 | endif
    return 0
endfunction


function! hi#config#IsCommand(command)
    "echom "IsCommand: ".a:command
    let res = 0
    if a:command[0:0] != "[" && a:command =~ "Filt" || a:command == "Conf" || a:command == "Goto" || a:command == "Find" || a:command == "Group" || a:command == "Cmd"
    "if a:command[0:0] != "[" && a:command =~ "^Filt.*=" || a:command == "^Conf.*=" || a:command == "^Goto.*=" || a:command == "^Find.*=" || a:command == "^Group.*=" || a:command == "^Cmd.*="
    "if a:command[0:0] != "[" && a:command =~ "^\(Filt\|Conf\Goto\|Find\|Group\|Cmd).*="
        "echom "iScommand found: ".a:command
        let res = 1
    endif
    call hi#log#Verbose(1, expand('<sfile>'), a:command." ".l:res)
    return l:res
endfunction


function! hi#config#IsColorMark(command)
    "echom "IsColorMark: ".a:command
    let res = 0
    "if a:command == "Mark" | let res = 1 | endif
    if a:command[0:0] != "[" &&  a:command =~ "^Mark.*=.*|.*|"
        "echom "IsColorMark found: ".a:command
        let res = 1
    endif
    call hi#log#Verbose(1, expand('<sfile>'), a:command." ".l:res)
    return l:res
endfunction


function! hi#config#IsComment(command)
    let res = 0
    "if a:command[0] == "#" | let res = 1 | endif
    let l:command = hi#utils#TrimString(a:command)
    if l:command =~ "#"
        let res = 1
    endif
    call hi#log#Verbose(1, expand('<sfile>'), a:command." ".l:res)
    return l:res
endfunction


"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
