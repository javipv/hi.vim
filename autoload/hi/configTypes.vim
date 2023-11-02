" Script Name: hi/configTypes.vim
" Description: Highlight text patterns in different colors.
"   Allows to save, reload and modify the highlighting configuration.
"   Allows to filter by color the lines and show then on a new split/tab.
"
" Copyright:   (C) 2017-2020 Javier Puigdevall Garcia
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Garcia Puigdevall <javierpuigdevall@gmail.com>
" Contributors:
"

" Show menu to select predefined hightlight settings
function! s:TypeMenuSelect()
    "echo "Saved highlight configs types:"

    silent call hi#fileConfig#Reload()

    if !exists("w:HiTypesList") || len(w:HiTypesList) <= 0
        call hi#log#Warn("Highlight predifined configuration not found.")
        return -1
    endif

    let n = 1
    for type in w:HiTypesList
        "Check if hidden config type, do not show on the menu.
        if l:type[0:1] != "__"
            echo printf("%' '3d)  %s",l:n,l:type)
        endif
        let n += 1
    endfor

    "echom " "
    let n = input("Select type: ")
    if l:n == "" | return -1 | endif
    return l:n
endfunction


" Show all available configuration types
" Commands: Hitsh
function! hi#configTypes#ShowConfigType(type)
    call hi#log#Verbose(1, expand('<sfile>'), "Type: ".a:type)
    call hi#fileConfig#Reload()

    if a:type == ""
        " Open menu on screen to choose the config type
        let l:type = s:TypeMenuSelect()
        if l:type <= 0 | return | endif
    else
        let l:type = a:type
    endif

    let configName = ""

    " Check if first letter is numeric value
    if "0123456789" !~ l:type[0:0]
        " type is function name
        let configName = a:type
    else
        " type is number, use function number saved on that position
        let last = len(g:HiPredefinedTypesList) + len(w:HiTypesList)
        if l:type  < 0 || l:type > l:last
            call hi#log#Error("Type ".a:types." above maximum: ".l:last)
            return
        endif

        let l:type -= 1

        if len("w:HiTypesList") <= 0 && len("g:HiPredefinedTypesList") <= 0
            call hi#log#Warn("Highlight predifined configuration not found.")
            return
        endif

        if len("w:HiTypesList") <= 0
            let configName = g:HiPredefinedTypesList[l:type]
        else
            if a:type <= len(w:HiTypesList)
                let configName = w:HiTypesList[l:type]
            else
                let configName = g:HiPredefinedTypesList[l:type]
            endif
        endif
    endif

    if l:configName != "" && l:configName != "clear"
        if !exists("w:".l:configName)
            call hi#log#Error("Error loading w:".l:configName)
            return 1
        endif

        exec("let l:colorPatternsList = w:".l:configName)

        if !exists("l:colorPatternsList")
            call hi#log#Error("Couldn't load config ".l:configName)
            return 1
        endif

        redraw
        echo "Show highlight type ".a:type." ".l:configName
        echo ""
        call hi#config#ShowHighlightCfg(l:colorPatternsList)

        call input("(press key to continue) ")
    endif

    if a:type == ""
        redraw
        call hi#configTypes#ShowConfigType("")
    endif
endfunction



" Load configuration type.
" Arg1: [OPTIONAL] type, config type's names space separated.
" Arg2: [OPTIONAL] applyConfig, if 1 apply the selected config list to the current buffer.
" Return: config list.
" Commands: Hit
"function! hi#configTypes#LoadConfigType(type, applyConfig, saveName, commentConfig)
function! hi#configTypes#LoadConfigType(type, applyConfig, saveName)
    if a:type == ""
        " Open menu on screen to choose the config type
        echo printf("%' '3d)  %s","0","Clear all")
        let l:types = s:TypeMenuSelect()
        if  l:types < 0 | return | endif
    else
        let l:types = a:type
    endif

    call hi#fileConfig#Reload()

    let loadTypeFlag = 0


    let typeList = split(l:types,' ')
    for type in l:typeList
        " Check if first letter is numeric value
        if "0123456789" !~ l:type[0:0]
            if l:type ==? "clear"
                echo "Clear highlighting"
                call hi#config#SyntaxClear()
                call hi#config#ListClear()
                continue
            endif

            " type is config name
            let configName = l:type
        else
            if l:type == 0
                echo "Clear highlighting"
                call hi#config#SyntaxClear()
                call hi#config#ListClear()
                continue
            endif

            " type is number, use function number saved on that position
            let last = len(g:HiPredefinedTypesList) + len(w:HiTypesList)
            if l:type  < 0 || l:type > l:last
                call hi#log#Error("Type ".a:type." above maximum: ".l:last)
                return
            endif

            let l:type -= 1

            if len("w:HiTypesList") <= 0 && len("g:HiPredefinedTypesList") <= 0
                call hi#log#Warn("Highlight predifined configuration not found.")
                return
            endif

            if len("w:HiTypesList") <= 0
                let configName = g:HiPredefinedTypesList[l:type]
            else
                if a:type <= len(w:HiTypesList)
                    let configName = w:HiTypesList[l:type]
                else
                    let configName = g:HiPredefinedTypesList[l:type]
                endif
            endif
        endif

        if !exists("w:".l:configName)
            "call hi#log#Verbose(1, expand('<sfile>'), "Config not found: w:".l:configName)
            call hi#log#Error("Config not found: ".l:configName)
            continue
        endif

        if l:configName == ""
            call hi#log#Verbose(1, expand('<sfile>'), "Empty config name")
            continue
        endif

        if l:configName != ""
            exec("let l:colorPatternsList = w:".l:configName)

            "if a:saveName == "saveTitle"
            if a:saveName == 1
                let w:AllConfigTypeNames = l:configName
            endif

            if a:type == ""
                " Ask user confirmation only when config not send
                " on the command line
                redraw
                "echo "Config type: ".a:type." ".l:configName
                "echo ""
                call hi#config#ShowHighlightCfg(l:colorPatternsList)

                if confirm("","Apply config, &yes\n&no",1) == 2
                    continue
                endif
            endif

            if !exists("w:ColoredPatternsList")
                let w:ColoredPatternsList = []
                call hi#config#SyntaxClear()
                call hi#config#ListClear()
            endif

            " Add to current highlight config
            exec("let l:configList = w:".l:configName)
            let configFlag = 0

            " Comment every config line.
            "if a:commentConfig == "comment"
                "let l:tmpList = []
                "for congigLine in l:configList
                    "if l:configLine[0] != "#"
                        "let l:tmpList .= ["#".l:configLine]
                    "endif
                "endfor
                "let l:configList = l:tmpList
            "endif

            "if a:applyConfig == "applyConfig"
            if a:applyConfig != ""
                for config in l:configList
                    let command = l:config[0]

                    if l:command[0] == "#"
                        " Do not show comments
                        call hi#config#AddComment(l:config[0])
                    elseif l:command =~ "Mark"
                        if hi#config#PatternHighlight(config[1],config[2],config[3]) == 0
                            let l:configFlag = 1
                        endif
                    else
                        if hi#config#ApplyCommand(l:config[0],l:config[1]) == 0
                            let l:configFlag = 1
                        endif
                    endif
                endfor

                if l:configFlag == 0
                    " Every config highlihgt failed.
                    return
                endif
                let loadTypeFlag = 1

                let w:LastConfigTypeName = l:configName
                let w:ConfigTypeName = l:configName
            endif
        endif
    endfor

    if loadTypeFlag == 1
        call hi#config#SyntaxReload()
        call hi#fileConfig#AutoSaveColorHiglighting()
        call hi#config#Reload()
    endif

    call hi#utils#ConcealEscSeq()

    " Update the hihglight config editor window
    call hi#configEditor#Reload()

    if !exists("l:configList")
        let l:configList = []
    endif

    return l:configList
endfunction


" Load last configuration used
" Commands: Hitl
function! hi#configTypes#LastType()
    "if !exists('w:LastConfigTypeName')
        "call hi#log#Warn("No previous config found (1).")
        "return
    "endif

    "if w:LastConfigTypeName == ""
        "call hi#log#Warn("No previous config found (2).")
        "return
    "endif
    let l:configName = ""

    if exists('w:LastConfigTypeName')
        if w:LastConfigTypeName != ""
            let l:configName = w:LastConfigTypeName
        endif
    endif

    if l:configName == ""
        if exists("w:ConfigLast")
            if len("w:ConfigLast") != 0
                let l:configName = "ConfigLast"
            endif
        endif
    endif

    if l:configName == ""
        call hi#log#Warn("No previous config found (1).")
        return
    endif

    call confirm("Reload config: ".l:configName."?", "", 1)

    call hi#fileConfig#Reload()

    exec("let w:ColoredPatternsList = w:".l:configName)
    call hi#config#SyntaxReload()

    " Update the hihglight config editor window
    call hi#configEditor#Reload()
endfunction


" Get wildmenu options for Hit/Hitl commands
" Return: list with all config type names available.
function! hi#configTypes#Wildmenu(ArgLead, CmdLine, CursorPos)
    silent call hi#fileConfig#Reload()

    let typesList = []
    for type in w:HiTypesList
        "if l:type[0:1] == "__"
            "continue
        "endif
        if l:type =~ a:ArgLead
            call add(l:typesList, l:type)
        endif
    endfor
    return l:typesList
endfunction



"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
