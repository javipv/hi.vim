" Script Name: hi/fileConfig.vim
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


"
" Remove duplicated consecutive blank lines
function! s:RmDupLines()
    "g/^$\n^$\n\+/d | 0/^$/d
    g/^$\n^$\n\+/d
endfunction


" Convert a .vim file with the highlight filter configuration
" To a .cfg file type.
" Commands: Hivtc
function! hi#fileConfig#VimToCfg()
    let file = expand('%')
    let fileCfg = substitute(l:file, '.vim', '.cfg', 'g')

    if empty(glob(l:file))
        call hi#log#Error("Source error: ".l:file)
        return 1
    endif

    let w:HiTypesList = [] 
    exec("source ".l:file)

    if s:ConfigDumpAllToFile(l:fileCfg)
        return 1
    endif

    if empty(glob(l:fileCfg))
        call hi#log#Error("Result file error: ".l:fileCfg)
        return 1
    endif

    vertical new
    exec("edit ".l:fileCfg)
    return 0
endfunction


" Load config from .cfg file.
" Save into config list.
"
" Config file format:
" [config_name]
" colorID   highlightOptions  "highlightPattern"
"
" Config file example 1:
" [Highlight_name]
" Conf = clean
" Filt = close
" Mark = b | lC |Highlight all line blue, match case.
" Mark = r | C  |highlight this words red, match case.
" Filt = all
" Return: 1 if file config found, else otherwhise.
function! hi#fileConfig#ConfigLoadFile(configFile)
    "let g:HiLogLevel = 4 " DEBUG
    call hi#log#Verbose(1, expand('<sfile>'), "file: ".a:configFile)


    let l:configTailStartLine = line("$") - g:HiFileConfigCheckLinesMax
    call hi#log#Verbose(2, expand('<sfile>'), "configTailStartLine:".l:configTailStartLine)

    redir! > readfile.out

    " Parse the config file
    let l:file = readfile(a:configFile)
    let l:configName = ""
    let l:n = 0
    let l:isConfigFound = 0

    for l:line in l:file
        let l:n += 1
        if l:isConfigFound == 0 && l:n > g:HiFileConfigCheckLinesMax
            " Config not found on the header of the file.
            if l:configTailStartLine < 0
                return 0
            endif
            " Go check the tail of the file.
            if l:n < l:configTailStartLine
                "echom "Skip line: ".line(".")." n:".l:n
                continue
            endif
            "echom "Check line: ".line(".")." n:".l:n
        endif

        call hi#log#Verbose(3, expand('<sfile>'), "Line: ".l:line)

        " Prevent field column alignment to interfare on the parsing.
        " Remove any consecutive spaces on field separators.
        "let l:line = substitute(l:line, '"  \+/"', '" "', 'g')

        "echom "configName: ".l:configName
        "echom "line: ".l:line

        if hi#config#IsTitle(l:line) == 1
            " Config title
            "echom "Title possibly found: ".l:line

            " Remove [] characters, remove leading and trailing spaces.
            let l:config = hi#utils#TrimString(l:line)
            let l:config = substitute(l:config, "[", "", "g")
            let l:config = substitute(l:config, "]", "", "g")

            if l:config == ""
                call hi#log#VerboseError(2, expand('<sfile>'),  "Empty config name")
                continue
            endif

            " Check name and prevent adding a dupplicated configuration.
            let l:matchConfig = " ".l:config." "
            if matchstr(s:configNames, l:matchConfig) == l:matchConfig
                call hi#log#VerboseError(2, expand('<sfile>'),  "Duplicated config: ".l:config)
                "echom  "Duplicated config: ".l:config
                continue
            endif

            " Line is configuration title.
            if l:configName != "" && exists("w:".l:configName) && len("w:".l:configName) > 0
                " Save config
                call add(w:HiTypesList, l:configName)
                if l:configName[0:1] != "__"
                    call add(w:HiTypesNotHiddenList, l:configName)
                endif
                call hi#log#Verbose(1, expand('<sfile>'),  "Saved type: ".l:configName)
                if g:HiLogLevel >= 2
                    exec("echo w:".l:configName)
                endif
                call hi#log#Verbose(1, expand('<sfile>'), " ")
            endif

            let l:configName = l:line[1:-2]
            "echom "l:configName = ".l:configName
            silent exec("let w:".l:configName." = []")
            call hi#log#Verbose(1, expand('<sfile>'), "Create new cfg: w:".l:configName)

            " Save config name to prevent adding a dupplicated configuration.
            let s:configNames .= " ".l:config." "

        "elseif l:line[0:0] == "#" " Line is commented
        elseif hi#config#IsComment(l:line) == 1
            call hi#log#Verbose(2, expand('<sfile>'), "Commented config")

            if l:configName == ""
                call hi#log#VerboseWarn(2, expand('<sfile>'), "Out of config paragraph (no l:configName)")
                continue
            endif

            if !exists("w:".l:configName)
                call hi#log#VerboseWarn(1, expand('<sfile>'), "Config not found: w:".l:configName)
                continue
            endif

            let tmpList = []
            call add(l:tmpList, l:line)
            call add(l:tmpList, " ")
            call add(l:tmpList, " ")
            call add(l:tmpList, " ")
            exec("let w:".l:configName."+= [ l:tmpList ]")

        elseif l:line == ""
            " Empty line
            call hi#log#Verbose(2, expand('<sfile>'), "Empty line")

        else
            call hi#log#Verbose(2, expand('<sfile>'), "Config line")

            " Line is configuration fields
            if l:configName == ""
                call hi#log#VerboseWarn(2, expand('<sfile>'), "Out of config paragraph (no l:configName)")
                continue
            endif

            let n = 0
            let string = ""
            "let l:fieldsList = split(l:line, '=')
            "
            " Line of type: "command = option1 | option2 | optionN"
            " Two list elements expected: 
            " 1: "command"
            " 2: "option1 | option2 | optionN"
            let l:list = split(l:line, "=")

            let len = len(l:list)
            if l:len < 2
                call hi#log#Verbose(2, expand('<sfile>'), "Reject2 line ".l:line)
                "if l:configFound == 1 | break | endif
                continue
            elseif l:len > 2
                " Fix case we have an = character on any of the option parameters.
                let l:fieldsList = []
                call add(l:fieldsList, l:list[0])
                " Join all elements from second to the end, add it as second list element.
                call add(l:fieldsList, join(remove(l:list, 1, -1), "="))
            else
                let l:fieldsList = l:list
            endif

            let l:command = l:fieldsList[0]
            let l:value = l:fieldsList[1]

            " Remove leading and trailing spaces
            let l:command =  hi#utils#TrimString(l:command)

            if l:command =~ "Mark"
            "if hi#config#IsColorMark(l:command) == 1
                " Color highlight config (Mark)
                let l:paramsList = split(l:value, '|')

                if len(l:paramsList) < 3
                    continue
                endif

                for l:param in l:paramsList
                    " Remove leading and trailing spaces
                    "let l:param = substitute(l:param,'^\s\+','','g')
                    "let l:param = substitute(l:param,'\s\+$','','g')

                    call hi#log#Verbose(3, expand('<sfile>'), l:configName." ".l:n." ".l:param)
                    "echom l:configName." ".l:n." ".l:param

                    if l:n == 0
                        " Color config
                        if l:param == ""
                            continue
                        endif
                        "let l:color = l:param
                        let l:color =  hi#utils#TrimString(l:param)
                    elseif l:n == 1
                        " Options config
                        if l:param !~ "c" && l:param !~ "C"
                            " No case sensitivi defined, use default.
                            let l:options = l:param.g:HiDefaultCase
                        else
                            let l:options = l:param
                        endif
                        let l:options =  hi#utils#TrimString(l:options)
                    elseif l:n == 2
                        " Pattern config
                        let string = l:param
                    elseif l:n >= 2
                        " Pattern config
                        let string .= "|".l:param
                    endif
                    let n+=1
                endfor

                if l:color == "" || l:options == "" || l:string == ""
                    call hi#log#Verbose(3, expand('<sfile>'), "Some parameter empty. color:".l:color." opt:".l:options." pattern:".l:string)
                    continue
                endif

                if !exists("w:".l:configName)
                    call hi#log#Verbose(1, expand('<sfile>'), "Config not found: l:".l:configName)
                    continue
                endif

                call hi#log#Verbose(3, expand('<sfile>'), "Found cfg command: ".l:command)
                call hi#log#Verbose(3, expand('<sfile>'), "Found cfg color: ".l:color)
                call hi#log#Verbose(3, expand('<sfile>'), "Found cfg options: ".l:options)
                call hi#log#Verbose(3, expand('<sfile>'), "Found cfg string: ".l:string)

                let tmpList = []
                call add(l:tmpList, "Mark")
                call add(l:tmpList, l:color)
                call add(l:tmpList, l:string)
                call add(l:tmpList, l:options)

                exec("let w:".l:configName."+= [ l:tmpList ]")

                if g:HiLogLevel >= 2
                    echo l:tmpList
                endif
                let l:isConfigFound = 1
                "echom "config mark found line:".l:n

            "elseif l:command == "Conf"
            "elseif l:command =~ "Filt" || l:command == "Conf" || l:command == "Goto" || l:command == "Find"
            elseif hi#config#IsCommand(l:command) == 1
                " Command config (Filt, Conf, Find, Filt)
                if !exists("w:".l:configName)
                    call hi#log#Verbose(2, expand('<sfile>'), "Out of config paragraph (no l:configName)")
                    continue
                endif

                " Remove leading and trailing spaces
                let l:value = hi#utils#TrimString(l:value)

                "let g:HiLogLevel = 3 | let g:HiLogFile = 1
                "call hi#log#Verbose(3, expand('<sfile>'), "Found cfg command: ".l:command)
                "call hi#log#Verbose(3, expand('<sfile>'), "Found cfg actions: ".l:value)

                "let tmpList = []
                "call add(l:tmpList, l:command)

                "let paramsList = split(l:value, '|')
                "if len(l:paramsList) == 0
                    "if l:value == "" | let l:value = "all" | endif
                    "call add(l:tmpList, l:value)
                    "call add(l:tmpList, " ")
                    "call add(l:tmpList, " ")
                    "call hi#log#Verbose(3, expand('<sfile>'), "Add cfg action: ".l:value)
                "else
                    "let n = 1
                    "for l:params in l:paramsList
                        "if l:n == 1 && l:params == "" | let l:params = "all" | endif
                        "if l:n != 1 && l:params == "" | continue | endif
                        "let l:params = hi#utils#TrimString(l:params)
                        "call add(l:tmpList, l:params)
                        "call hi#log#Verbose(3, expand('<sfile>'), "Add cfg action".l:n.": ".l:params)
                        "let n += 1
                    "endfor
                "endif
                "let g:HiLogLevel = 0 | let g:HiLogFile = 1

                " Scape | character
                let l:value = substitute(l:value, "|", "\|", '')

                let tmpList = []
                call add(l:tmpList, l:command)
                call add(l:tmpList, l:value)
                call add(l:tmpList, " ")
                call add(l:tmpList, " ")

                exec("let w:".l:configName."+= [ l:tmpList ]")
                "echo l:tmpList

                if g:HiLogLevel >= 2
                    echo l:tmpList
                endif
                let l:isConfigFound = 1
                "echom "config command found line:".l:n
            endif
        endif
    endfor

    if l:configName != "" && exists("w:".l:configName) && len("w:".l:configName) > 0
        " Save config
        call add(w:HiTypesList, l:configName)
        if l:configName[0:1] != "__"
            call add(w:HiTypesNotHiddenList, l:configName)
        endif
        call hi#log#Verbose(1, expand('<sfile>'), "Saved type: ".l:configName)
        if g:HiLogLevel >= 2 | exec("echo w:".l:configName) | endif
    endif

    redir END
    call delete('readfile.txt')
    call hi#log#Verbose(1, expand('<sfile>'), "".a:configFile." End")

    let s:verbose = 0 " DEBUG
    retur l:isConfigFound
endfunction


" Save config into .cfg file.
" All loaded configuations will be dumped into file.
" Save configuration list into ini file.
"
" Config file format:
" [config_name]
" colorID   highlightOptions  "highlightPattern"
"
" Config file example:
" [myHighlight]
" b   lC  "Highlight all line blue, match case."
" r   C   "highlight this words red, match case."
function! s:ConfigDumpAllToFile(configFile)
    call hi#log#Verbose(1, expand('<sfile>'), "file: ".a:configFile)

    let configFile = a:configFile
    let configBuff = ""
    let n = 0

    if !exists("w:HiTypesList") || len(w:HiTypesList) <= 0
        call hi#log#Warn("Highlight predifined configuration not found.")
        return -1
    endif

    for type in w:HiTypesList
        call hi#log#Verbose(2, expand('<sfile>'), "[".l:type."]")
        let configBuff .= printf("[%s]\n",l:type)

        exec("let l:configList = w:".l:type)

        if !exists("l:configList") || len(l:configList) <= 0
            call hi#log#Warn("Highlight config".l:type." not found.")
            continue
        endif

        for config in l:configList
            "call hi#log#Verbose(2, expand('<sfile>'), "".l:config[0]." ".l:config[2]." ".l:config[1])
            "let configBuff .= printf("%s\t%s\t%s\n", l:config[0], l:config[2], l:config[1] )
            if l:config[0:0] == "#"
                let configBuff .= printf("%s\n", l:command[0] )

            elseif config[0] == "Mark"
                call hi#log#Verbose(2, expand('<sfile>'), "".l:config[1]." ".l:config[3]." ".l:config[2])

                let color   = substitute(l:config[1],'#','@','g')
                let options = l:config[2]
                let pattern = substitute(l:config[3],'\\','\\\','g')
                let pattern = substitute(l:config[3],'\','\\','g')
                let pattern = substitute(l:config[3],'/','\\/','g')
                let pattern = substitute(l:config[3],'"','\\"','g')

                call hi#log#Verbose(2, expand('<sfile>'), "".l:color." ".l:pattern." ".l:options)

                let configBuff .= printf("Mark = %' '-5S| %' '-4S | %s\n", l:color, l:pattern, l:options )
            else
                let configBuff .= printf("Mark = %s\n", l:config[0], l:config[1] )
            endif
        endfor

        let configBuff .= "\n"
        let n+=1
    endfor

    if l:n != 0
        call hi#log#Verbose(1, expand('<sfile>'), "File: ".a:configFile)

        if g:HiLogLevel >= 1
            echo "  ".l:configBuff
        endif

        new
        silent put = l:configBuff
        normal ggdd
        exec("silent write! ".a:configFile)
        bd!
    endif
    call hi#log#Verbose(1, expand('<sfile>'),  a:configFile." End")
endfunction


" Append config on the selected .cfg file.
" The selected configuation will be appended into file.
" Save configuration list into ini file.
"
" Config file format:
" [config_name]
" colorID   highlightOptions  "highlightPattern"
"
" Config file example:
" [myHighlight]
" b   lC  "Highlight all line blue, match case."
" r   C   "highlight this words red, match case."
function! hi#fileConfig#AppendToFile(configList, configName, configFile)
    call hi#log#Verbose(1, expand('<sfile>'), "file: ".a:configFile." name: ".a:configName)

    "let configName = a:configName[2:-1]
    let configBuff = ""

    call hi#log#Verbose(2, expand('<sfile>'), "[".a:configName."]")

    let configBuff .= printf("\n[%s]\n",a:configName)

    if len(a:configList) <= 0
        call hi#log#Warn("Highlight config empty.")
        return -1
    endif

    for config in a:configList
        "call hi#log#Verbose(3, expand('<sfile>'), "config: ".l:config)

        if l:config[0][0] == "#"
        "if hi#config#IsComment(l:config[0]) == 1
            call hi#log#Verbose(2, expand('<sfile>'), "comment: ".l:config[0])
            let configBuff .= printf("%s\n", l:config[0] )

        elseif l:config[0] == "Mark"
        "elseif hi#config#IsColorMark(l:config[0]) == 1
            call hi#log#Verbose(2, expand('<sfile>'), "mark: ".l:config[1]." ".l:config[3]." ".l:config[2])

            let color   = substitute(l:config[1],'#','@','g')
            let options = l:config[2]
            let pattern = substitute(l:config[3],'\\','\\\','g')
            let pattern = substitute(l:config[3],'\','\\','g')
            let pattern = substitute(l:config[3],'/','\\/','g')
            let pattern = substitute(l:config[3],'"','\\"','g')

            call hi#log#Verbose(2, expand('<sfile>'), "".l:color." ".l:pattern." ".l:options)

            let configBuff .= printf("Mark = %-5S| %-8S | %s\n", l:color, l:pattern, l:options )

        elseif l:config[0] =~ "Filt" || l:config[0] == "Conf" || l:config[0] == "Goto" || l:config[0] == "Find" || l:config[0] == "Tail"
        "elseif hi#config#IsCommand(l:config[0]) == 1
            call hi#log#Verbose(2, expand('<sfile>'), "cmd: ".l:config[0]." ".l:config[1])
            let configBuff .= printf("%s = %s\n", l:config[0], l:config[1] )
        endif
    endfor

    let configBuff .= "\n"

    call hi#log#Verbose(1, expand('<sfile>'), "File: ".a:configFile)

    if g:HiLogLevel >= 1
        echo "  ".l:configBuff
    endif

    let winId = win_getid()
    silent exec("tabedit ".a:configFile)
    call hi#log#Verbose(4, expand('<sfile>'),  "Tab open:".a:configFile.". Prev window: ".l:winId)

    " Goto last line and append config.
    normal G
    silent put = l:configBuff

    " Remove duplicated consecutive blank lines
    silent call s:RmDupLines()

    silent exec("write! ".a:configFile)
    silent bd!
    silent! exec "tabclose ".a:configFile

    " Close filter (son) window and buffer
    silent! exec("bdelete! ".a:configFile)
    call win_gotoid(l:winId)
    call hi#log#Verbose(4, expand('<sfile>'),  "Go to window: ".l:winId)

    call hi#log#Verbose(1, expand('<sfile>'),  a:configFile." End")
endfunction


" Delete config on the selected .cfg file.
function! hi#fileConfig#DeleteFromFile(configName, configFile)
    call hi#log#Verbose(1, expand('<sfile>'), "file: ".a:configFile." config:".a:configName)

    " Check file exist
    if empty(glob(a:configFile))
        call hi#log#Warn("Highlight config ".a:configFile." not found.")
        return
    endif

    let winId = win_getid()
    silent exec("tabedit ".a:configFile)
    call hi#log#Verbose(4, expand('<sfile>'),  "Tab open:".a:configFile.". Prev window: ".l:winId)

    while search("^\[".a:configName."\\]$",'c') != 0
        call hi#log#Verbose(1, expand('<sfile>'), "Delete config ".a:configName." from ".a:configFile)
        " Remove all paragraph
        normal v}d
    endwhile

    " Remove duplicated consecutive blank lines
    silent call s:RmDupLines()

    exec("silent write! ".a:configFile)

    " Close window and buffer
    silent! exec("bdelete! ".a:configFile)

    call hi#log#Verbose(1, expand('<sfile>'), "Config ".a:configName." deleted.")

    call win_gotoid(l:winId)
    call hi#log#Verbose(4, expand('<sfile>'),  "Go to window: ".l:winId)

    call hi#log#Verbose(1, expand('<sfile>'),  a:configFile." End")
endfunction


" Reload highlight predefined types from config files
function! hi#fileConfig#Reload()
    call hi#log#Verbose(1, expand('<sfile>'), "")
    let w:HiTypesList = []
    let w:HiTypesNotHiddenList = []

    " Save configNames accepted. 
    " Used to prevent adding a dupplicated configuration.
    let s:configNames = ""

    " Reload current config files .cfg
    let file  = fnameescape(expand('%:h'))."/"
    let file .= g:HiAutoSaveSourcePrefix
    let file .= fnameescape(expand('%:t'))
    let file .= g:HiAutoSaveSourceSufix

    call hi#log#Verbose(1, expand('<sfile>'), "Check default: ".l:file)

    if !empty(glob(l:file))
        call hi#log#Verbose(1, expand('<sfile>'),  "Parse config file: : ".l:file)
        call hi#fileConfig#ConfigLoadFile(l:file)
    endif

    let g:HiPredefinedTypesList   = []

    let l:configFilesStr = ""
    if exists("g:HiSourceFiles")
        let l:configFilesStr .= g:HiSourceFiles." "
    endif
    if exists("w:HiSourceFiles")
        let l:configFilesStr .= w:HiSourceFiles." "
    endif


    call hi#log#Verbose(1, expand('<sfile>'), "Source files: ".g:HiSourceFiles)
    "let list = split(g:HiSourceFiles,' ')
    let list = split(l:configFilesStr,' ')
    for i in l:list
        call hi#log#Verbose(2, expand('<sfile>'), "Check config file: ".l:i)

        if !empty(glob(l:i))
            if l:i =~ ".cfg"
                " Reload config files .cfg
                call hi#log#Verbose(1, expand('<sfile>'),  "Parse config file: ".l:i)
                call hi#fileConfig#ConfigLoadFile(l:i)
            endif
        else
            call hi#log#Verbose(2, expand('<sfile>'), "Config file: ".l:i." not found")
        endif
    endfor
endfunction


" Show the saved configurations
" Command: Hicfg
function! hi#fileConfig#TabOpen()

    call hi#log#Verbose(1, expand('<sfile>'), " ")
    let tmpList = []

    if g:HiAutoSave == 1
        "let file  = fnameescape(expand('%:h'))."/"
        let file  = fnameescape(expand('%:h')).g:HiDirSep
        let file .= g:HiAutoSaveSourcePrefix
        let file .= fnameescape(expand('%:t'))
        let file .= g:HiAutoSaveSourceSufix
        call add(l:tmpList, l:file)
    endif


    let l:configFilesStr = ""
    if exists("g:HiSourceFiles")
        let l:configFilesStr .= g:HiSourceFiles." "
    endif
    if exists("w:HiSourceFiles")
        let l:configFilesStr .= w:HiSourceFiles." "
    endif

    "if exists("g:HiSourceFiles")
        "let list = split(g:HiSourceFiles,' ')
        let list = split(l:configFilesStr,' ')
        for i in l:list
            call hi#log#Verbose(1, expand('<sfile>'), "Config: ".i)
            let tmp = substitute(l:i, getcwd().g:HiDirSep, '', 'g') 

            call hi#log#Verbose(1, expand('<sfile>'), "Config: ".l:tmp)

            if index(l:tmpList, l:tmp) >= 0 | continue | endif
            if index(l:tmpList, l:i) >= 0   | continue | endif

            call hi#log#Verbose(1, expand('<sfile>'), "Added to config list: ".l:i)
            call add(l:tmpList, l:i)
        endfor
    "endif


    let window = 3
    let done = 0
    redraw

    " Prevent using again same configuration file.
    let usedFiles = ""

    for file in l:tmpList
        " Prevent using again same configuration file.
        let l:matchConfig = " ".l:file." "
        if matchstr(l:usedFiles, l:matchConfig) == l:matchConfig
            continue
        endif
        let l:usedFiles .= " ".l:file." "

        if filereadable(l:file)
            "if l:window >= 3
            if l:window >= g:HiCfgSplitNumb
                silent exec("tabedit ".l:file)
                tabmove -1
                if line('$') == 1
                    tabclose
                else
                    let window = 1
                    let done = 1
                endif
            else
                silent exec("vsplit ".l:file)
                if line('$') == 1
                    exec("bdelete ".l:file)
                else
                    let window += 1
                    let done = 1
                endif
            endif
        else
            call hi#log#Verbose(1, expand('<sfile>'), "File: ".l:file." not found")
        endif
    endfor

    if l:done != 1
        call hi#log#Warn("Config not found")
    endif
    return
endfunction


" Force save current configuration
" Command: Hifsv
function! hi#fileConfig#ForceAutoSaveColorHiglighting()
    let fileCfg  = fnameescape(expand('%:h')).g:HiDirSep
    let fileCfg .= g:HiAutoSaveSourcePrefix
    let fileCfg .= fnameescape(expand('%:t'))
    let fileCfg .= g:HiAutoSaveSourceSufix

    let date = system("date +%y%m%d_%H%M")
    let date = substitute(l:date, '\n\+$', '', '')

    "let name = "Config_".l:date
    let name = "ConfigLast"
    let w:LastConfigType = l:name
    call hi#fileConfig#SaveColorHiglighting(l:fileCfg,l:name)
    echo "Config saved: ".l:fileCfg

    if exists("g:HiAutosaveFiles")
        let n = 1
        let list = split(g:HiAutosaveFiles,' ')
        for file in l:list
            let name = "Config".l:n."_".l:date
            call hi#fileConfig#SaveColorHiglighting(l:file,l:name)
            let n += 1
            echo "Config saved: ".l:file
        endfor
    endif
endfunction


" Save color highliting
function! hi#fileConfig#SaveColorHiglighting(file,name)
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return
    endif

    call hi#log#Verbose(1, expand('<sfile>'), "file: ".a:file." config:".a:name)

    call hi#fileConfig#DeleteFromFile(a:name, a:file)
    call hi#fileConfig#AppendToFile(w:ColoredPatternsList, a:name, a:file)
    return 0
endfunction


" On any configuration change. Save current highlight configuration
function! hi#fileConfig#AutoSaveColorHiglighting()
    if g:HiAutoSave != 1 | return 0 | endif

    if !filereadable(fnameescape(expand('%')))
        return 1
    endif

    if exists("w:AutoSave")
        if w:AutoSave != 1 | return | endif
    endif

    let fileCfg  = fnameescape(expand('%:h'))."/"
    let fileCfg .= g:HiAutoSaveSourcePrefix
    let fileCfg .= fnameescape(expand('%:t'))
    let fileCfg .= g:HiAutoSaveSourceSufix

    let list = split(g:HiAutoSaveExcludeExt,' ')
    for i in l:list
        if fnameescape(expand('%:e')) == l:i | return | endif
    endfor

    let list = split(g:HiAutoSaveExtensions,' ')
    for i in l:list
        if fnameescape(expand('%:e')) == l:i | let w:AutoSaveConfirmed = 1 | endif
    endfor

    "if g:HiAutoSaveConfirm == 1 && !exists("w:AutoSaveConfirmed")
        "let w:AutoSave = confirm("Auto save changes?","&yes\n&no",1)
        "let w:AutoSaveConfirmed = 1
        "let l:AutoSave = w:AutoSave

        "let tabn = tabpagenr()
        "silent exec("tabedit ".l:fileCfg)
        "normal G
        "let @a = "let w:Autosave = ".l:AutoSave | put a
        "let @a = "let w:AutoSaveConfirmed = 1" | put a
        "silent w!
        "silent! tabclose
        "silent! exec("normal ".l:tabn."gt")
    "endif

    let name = "ConfigLast"
    let w:LastConfigType = l:name
    call hi#fileConfig#SaveColorHiglighting(l:fileCfg,l:name)

    if exists("g:HiAutosaveFiles")
        let n = 1
        let list = split(g:HiAutosaveFiles,' ')
        for file in l:list
            "let name = "Config".l:n."_".l:date
            let name = "ConfigLast"
            call hi#fileConfig#SaveColorHiglighting(l:file,l:name)
            let n += 1
        endfor
    endif
endfunction


" Choose config file
function! s:ChooseFileCfgMenu()
    let fileDflt  = g:HiAutoSaveSourcePrefix
    let fileDflt .= fnameescape(expand('%:t'))
    let fileDflt .= g:HiAutoSaveSourceSufix

    " Prevent using again same configuration file.
    let usedFiles = ""

    let file = l:fileDflt

    let l:configFilesStr = ""
    if exists("g:HiSourceFiles")
        let l:configFilesStr .= g:HiSourceFiles." "
    endif
    if exists("w:HiSourceFiles")
        let l:configFilesStr .= w:HiSourceFiles." "
    endif

    let l:fileList = []

    if len(l:configFilesStr) > 0
        echo " "
        echo "Config files:"
        echo "  0) ".l:fileDflt

        let n = 1
        for file in split(l:configFilesStr,' ')
            " Prevent using again same configuration file.
            let l:matchConfig = " ".l:file." "
            if matchstr(l:usedFiles, l:matchConfig) == l:matchConfig
                continue
            endif
            let l:usedFiles .= " ".l:file." "

            if !empty(glob(l:file))
                echo "  ".l:n.") ".l:file
                let l:fileList += [ l:file ]
                let n+=1
            endif
        endfor

        let num = input("Choose file number: ")

        while l:num > len(l:fileList) || l:num < 0 || l:num[0] !~ "[0-9]"
            echo " (Not available, choose between 0 and ".len(l:fileList).")"
            let num = input("Choose file number: ")
        endwhile

        if l:num == 0
            let file = l:fileDflt
        else
            let file = l:fileList[l:num-1]
        endif
    endif
    echo " "
    echo "Config file: ".l:file
    return l:file
endfunction


" Dump current highlight settings into config file
" Add a new type, this is a new function.
" Arg1: OPTIONAL config file name, to write to file: [configName]
" Arg2: OPTIONAL file path where saving the config.
" Commands: Hisv
function! hi#fileConfig#SaveCurrentHighlightCfg(...)
    if !exists("w:ColoredPatternsList") || len(w:ColoredPatternsList) <= 0
        call hi#log#Warn("Color highglight not found, empty.")
        return ""
    endif

    let l:filename = ""
    let l:configname = ""

    if a:0 > 0
        " Parse arguments:
        " - Argument is file available on current directory, use as config file path.
        " - Argument is not file available on current directory, use as config name.
        for l:arg in a:000
            if empty(glob(l:arg))
                let l:configname = l:arg
            else
                let l:filename = l:arg
            endif
        endfor
    endif

    if l:configname == ""
        redraw

        if exists("w:AllConfigTypeNames")
            "if w:AllConfigTypeNames != ""
                "if confirm("","Use default config name: ".w:AllConfigTypeNames." &yes\n&no",1) == 1
                    let l:configname = w:AllConfigTypeNames
                    "redraw
                    "echo "Config name: ".l:configname
                    "echo ""
                "else
                    "redraw
                "endif
            "endif
        endif

        if l:configname == "" 
            let configname = input("Config name: ")
            echo ""
            let w:AllConfigTypeNames = l:configname
        endif

        if l:configname == "" | return | endif
    else
        echo "Use config name: ".l:configname
    endif


    if l:filename == ""
        redraw

        if exists("w:ConfigTypeFileName")
            "if w:ConfigTypeFileName != ""
                "if confirm("","Use default config file: ".w:ConfigTypeFileName." &yes\n&no",1) == 1
                    let l:filename = w:ConfigTypeFileName
                    "redraw
                    "echo "Config file name: ".l:filename
                    "echo ""
                "else
                    "redraw
                "endif
            "endif
        endif

        if l:filename == "" 
            let filename = s:ChooseFileCfgMenu()
            if l:filename == "" | return | endif
            let w:ConfigTypeFileName = l:filename
            echo ""
        endif
    else
        echo "Use config file: ".l:filename
    endif

    " If we're on config editor window, goto base window.
    " Save filename and configname in base window.
    if hi#configEditor#GotoBaseWin() == 0
        let w:ConfigTypeFileName = l:filename
        let w:AllConfigTypeNames = l:configname
        call hi#configEditor#GotoEditorWin()
    endif

    call confirm("Safe config as '".l:configname."' to file: '".l:filename."'")

    let res = hi#fileConfig#SaveColorHiglighting(l:filename,l:configname)
    if l:res == 0
        silent call hi#fileConfig#AutoSaveColorHiglighting()
        "call input("Config '".l:configname."' saved to file: '".l:filename."'")
    endif
endfunction


" Load the configurations saved on a highlight config file (.cfg file). 
" Cmd: Hil
func! hi#fileConfig#LoadConfigFile(configFile)
    if empty(glob(a:configFile))
        call hi#log#Error("Config file not found: ".a:configFile)
        return 1
    endif

    if !exists("s:configNames")
        " Save configNames accepted. 
        " Used to prevent adding a dupplicated configuration.
        let s:configNames = ""
    endif

    if !exists("w:HiTypesList")
        let w:HiTypesList = [] 
    endif
    if !exists("w:HiTypesNotHiddenList")
        let w:HiTypesNotHiddenList = [] 
    endif

    "call hi#fileConfig#ConfigLoadFile(a:configFile)
    if hi#fileConfig#ConfigLoadFile(a:configFile) != 1
        redraw
        echo "Configurations searched on last and first ".g:HiFileConfigCheckLinesMax." lines"
        echo " (Search lines defined by: g:HiFileConfigCheckLinesMax)"
        call hi#log#Error("No configuration found on file: ".a:configFile)
        return 1
    endif

    if !exists("g:HiSourceFiles")
        let g:HiSourceFiles = a:configFile
    else
        let g:HiSourceFiles .= a:configFile." "
    endif

    "if !exists("w:HiSourceFiles")
        "let w:HiSourceFiles = a:configFile
    "else
        "let w:HiSourceFiles .= a:configFile." "
    "endif
    return 0
endfunc


func! hi#fileConfig#SaveModifications()
endfunc


" Get wildmenu options for Hisv command
" Return: list with all config type names and all config filenames available 
function! hi#fileConfig#Wildmenu(ArgLead, CmdLine, CursorPos)
    silent call hi#fileConfig#Reload()

    let typesList = []
    for type in w:HiTypesList
        if l:type =~ a:ArgLead
            call add(l:typesList, l:type)
        endif
    endfor

    " Get all files in current directory with extension .cfg
    let l:ext = "cfg"
    let l:files  = glob("`ls *.".l:ext."`")
    let l:files .= glob("`ls .*.".l:ext."`")
    for file in split(l:files, "\n")
        call add(l:typesList, l:file)
    endfor

    return l:typesList
endfunction


"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
