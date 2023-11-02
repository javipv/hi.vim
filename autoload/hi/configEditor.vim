" Script Name: hi#configEditor.vim
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


" Goto main window.
" Return: 0 on successş 1 otherwise.
function! hi#configEditor#GotoBaseWin()
    call hi#log#Verbose(1, expand('<sfile>'), " ")
    if !exists("w:hifEditConfigWinNr") || !exists("w:hifEditConfigWinName")
        call hi#log#Verbose(1, expand('<sfile>'), "No config editor window linked.")
        return 1
    endif
    if w:hifEditConfigWinName != expand("%")
        call hi#log#Verbose(1, expand('<sfile>'), "Wrong Editor Window name.")
        unlet w:hifEditConfigWinName
        return 1
    endif
    " Goto to config editor window
    if win_gotoid(w:hifEditMainWinNr) == 0
        call hi#log#Verbose(1, expand('<sfile>'), "Main WinNr not found.")
        unlet w:hifEditMainWinNr
        unlet w:hifEditConfigWinName
        return 1
    endif
    return 0
endfunction


" Goto editor window.
" Return: 0 on successş 1 otherwise.
function! hi#configEditor#GotoEditorWin()
    call hi#log#Verbose(1, expand('<sfile>'), " ")
    if !exists("w:hifEditConfigWinNr")
        call hi#log#Verbose(1, expand('<sfile>'), "No config editor window linked.")
        return 1
    endif
    " Goto to config editor window
    if win_gotoid(w:hifEditConfigWinNr) == 0
        call hi#log#Verbose(1, expand('<sfile>'), "Editor WinNr not found.")
        unlet w:hifEditConfigWinNr
        return 1
    endif
    if !exists("w:hifEditConfigWinName")
        call hi#log#Verbose(1, expand('<sfile>'), "Editor WinName not found.")
        unlet w:hifEditMainWinNr
        unlet w:hifEditConfigWinName
        return 1
    endif
    if w:hifEditConfigWinName != expand("%")
        call hi#log#Verbose(1, expand('<sfile>'), "Wrong Editor Window name.")
        return 1
    endif
    call hi#log#Verbose(1, expand('<sfile>'), "Editor Window name: ".w:hifEditConfigWinName)
    return 0
endfunction


" Close editor window.
" Return: 0 on successş 1 otherwise.
function! hi#configEditor#CloseEditorWin()
    call hi#log#Verbose(1, expand('<sfile>'), " ")
    if exists("w:hifEditConfigWinName")
        if w:hifEditConfigWinName != ""
            call hi#log#Verbose(1, expand('<sfile>'), "Close editor window: ".w:expand("%"))
            silent exec ("bd! ".w:hifEditConfigWinName)
        endif
        unlet w:hifEditMainWinNr
        unlet w:hifEditConfigWinName
        return 0
    endif
    return 1
endfunction


" Reload the config editor window.
function! hi#configEditor#Reload()
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    if !exists("w:hifEditConfigWinNr")
        call hi#log#Verbose(1, expand('<sfile>'), "No config editor window linked.")
        return 1
    endif

    call hi#configEditor#GotoBaseWin()
    call hi#configEditor#CloseEditorWin()
    call hi#configEditor#Open(0,"")
    silent exec "vertical resize ".g:HiCfgEditWindowNormalSize
    return 0
endfunction


" Apply config modification on the config editor window.
" To call after editing the config on the config editor window.
" This will refresh the highlighting.
function! s:ApplyConfigHighlight()
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    if !exists("w:hifEditConfigWinNr")
        return
    endif
    if win_getid() != w:hifEditConfigWinNr"
        return
    endif
    "echo "Show highlight changes on config editor"

    " Save edited highlight config on tmp file.
    let l:tmpFile = tempname()
    silent exec "w ".l:tmpFile

    " Apply new hіghlight on highlight edit window
    " Remove previous config
    call hi#config#SyntaxClear()
    call hi#config#ListClear()
     "Apply new config
    call s:ApplyConfigFile(l:tmpFile, "Mark")
    let l:editWinNr = win_getid()

    silent! delete(l:tmpFile)
endfunction


" Open config editor, load the selected config.
" If no config type provided show menu to select a config type.
" Commands: Hiet
function! hi#configEditor#EditConfigType(type)
    "let l:configList = hi#configTypes#LoadConfigType(a:type, "noApplyConfig", "saveTitle", "noComment")
    let l:configList = hi#configTypes#LoadConfigType(a:type,"",1)
    call hi#configEditor#Open(1,l:configList)
endfunction


" Open the config editor window to edit current hightlight settings.
" Arg1: configFlag, 1 if configList argument is send, else 0.
" Arg2: configList, list with all color and commands config. 
" Command: Hie
function! hi#configEditor#Open(configFlag, configList)
    call hi#log#Verbose(1, expand('<sfile>'), "configFlag:".a:configFlag)

    if a:configFlag == 1
        let l:ColoredPatternsList = a:configList
    else
        if exists("w:ColoredPatternsList") && len(w:ColoredPatternsList) > 0
            let l:ColoredPatternsList = w:ColoredPatternsList
        endif
    endif

    if exists("w:hifEditConfigWinNr")
        " Already linked to a config window
        if w:hifEditConfigWinNr == win_getid() && expand("%") =~ "_hi_edit"
            " Already positioned on a config window.
            echo "Already positioned on a config window."
            return 0
        else
            " Close current config window and reopen.
            call hi#configEditor#CloseEditorWin()
        endif
    endif

    if exists("w:AllConfigTypeNames")
        let l:AllConfigTypeNames = w:AllConfigTypeNames
    else
        let l:AllConfigTypeNames = ""
    endif

    if exists("w:ConfigTypeFileName")
        let l:ConfigTypeFileName = w:ConfigTypeFileName
    else
        let l:ConfigTypeFileName = ""
    endif

    let l:buffName = expand('%:t:r')."_hi_edit"
    let l:baseName = expand('%')
    let l:mainWinNr = win_getid()

    vertical new
    setl commentstring=#%s
    setl nowrap
    set buflisted
    set bufhidden=delete
    set buftype=nofile
    setl noswapfile
    setl nocursorline
    silent exec "vertical resize ".g:HiCfgEditWindowNormalSize
    let l:rectangleSize = g:HiCfgEditWindowNormalSize - 6 

    let w:hifEditConfig = ""
    let w:hifEditConfigWinNr = win_getid()
    let w:hifEditMainWinNr = l:mainWinNr
    let w:AllConfigTypeNames = l:AllConfigTypeNames
    let w:ConfigTypeFileName = l:ConfigTypeFileName

    let l:configBuff  = hi#utils#EncloseOnRectangle([" HI PLUGIN", " CONFIG EDITOR WINDOW: "],"bold",l:rectangleSize)
    let l:configBuff .= printf("%s"," Base file: ".l:baseName."\n")
    let l:configBuff .= printf("%s"," Use key: '".g:HiCfgEditWinApplyCfgKey."' to reload the config.\n")
    let l:configBuff .= printf("%s"," Use key: 'q' to close this editor window.\n")
    let l:configBuff .= printf("%s","\n")

    let l:configBuff .= printf("%s","\n")
    let l:configBuff .= hi#utils#EncloseOnRectangle([" HIGHLIGHT CONFIG: "],"normal",l:rectangleSize)

    if w:ConfigTypeFileName != ""
        call hi#log#Verbose(4, expand('<sfile>'), "File ".w:ConfigTypeFileName)
        let l:configBuff .= printf("File = %s\n", w:ConfigTypeFileName)
        let l:configBuff .= printf("%s","\n")
    endif

    if w:AllConfigTypeNames != ""
        let l:configBuff .= printf("[%s]\n", w:AllConfigTypeNames)
    endif

    if !exists("l:ColoredPatternsList")
        let l:configBuff .= printf("%s","#Conf = clean\n")
        let l:configBuff .= printf("%s","#Filt = close\n")
        let l:configBuff .= printf("#Mark = %-5s| %-10s |%s\n", "y", "C", "Patter1")
        let l:configBuff .= printf("#Mark = %-5s| %-10s |%s\n", "b", "lC", "Pattern2")
        let l:configBuff .= printf("#Mark = %-5s| %-10s |%s\n", "g@", "C", "Pattern2")
        let l:configBuff .= printf("%s","#Filt = all\n")
        let l:configBuff .= printf("%s","#Find = r@\n")
        let l:configBuff .= printf("%s","#Filt = synch\n")
    else

        let w:ColoredPatternsList = l:ColoredPatternsList

        " Apply the highlights on the editor window
        for config in l:ColoredPatternsList
            if l:config[0] == "Mark"
            "if hi#config#IsColorMark(l:config[0])
                call hi#log#Verbose(4, expand('<sfile>'), l:config[1]." ".l:config[2]." ".l:config[3])
                call hi#config#ColorReload(l:config[1],l:config[2],l:config[3])
            endif
        endfor

        " Show all commands
        for cfgList in l:ColoredPatternsList
            call hi#log#Verbose(4, expand('<sfile>'), ">> ".l:cfgList[0]." ".l:cfgList[1]." ".l:cfgList[2]." ".l:cfgList[3])
            "
            " Remove leading and trailing spaces
            let l:command = hi#utils#TrimString(l:cfgList[0])

            if l:command[0] =~ "#.*Conf"

            "elseif hi#config#IsTitle(l:line[0])
                "call hi#config#AddTitle(l:line)

            elseif l:command[0:0] == "#"
            "if hi#config#IsComment(l:command[0])
                call hi#log#Verbose(3, expand('<sfile>'), "Comment: ".l:cfgList[1])
                let l:configBuff .= printf("%s\n", l:command)

            elseif l:command =~ "Mark"
            "elseif hi#config#IsColorMark(l:command)
                " Remove leading and trailing spaces
                let l:colorId = hi#utils#TrimString(l:cfgList[1])
                let l:pattern = hi#utils#TrimString(l:cfgList[2])
                let l:flags   = hi#utils#TrimString(l:cfgList[3])

                call hi#log#Verbose(3, expand('<sfile>'), "Mark: ".l:colorId." ".l:flags." ".l:pattern)
                let l:configBuff .= printf("%s = %-5S| %-10S |%s\n", l:command, l:colorId, l:flags, l:pattern)

                " Apply current window highlight to the editor window
                silent call hi#config#ColorReload(l:colorId, l:pattern, l:flags)

            elseif l:command == "Conf"
                let l:value = hi#utils#TrimString(l:cfgList[1])
                " Omitt any config command different than: clean, clear, save, edit
                if l:value != "add"
                "if l:value == "clear" || l:value == "clean" || l:value == "save" || l:value == "edit"
                    call hi#log#Verbose(3, expand('<sfile>'), l:command.": ".l:value)
                    let l:configBuff .= printf("%s = %s\n", l:command, l:value)
                endif

            else
                let l:value = hi#utils#TrimString(l:cfgList[1])
                call hi#log#Verbose(3, expand('<sfile>'), l:command.": ".l:value)
                let l:configBuff .= printf("%s = %s\n", l:command, l:value)
            endif

            echohl None
        endfor
    endif

    let l:configBuff .= printf("%s","\n")
    let l:configBuff .= hi#utils#EncloseOnRectangle([" CONFIG format HELP: "],"normal",l:rectangleSize)
    let l:configBuff .= printf("%s"," Mark = ColorID|Flags|Patterns\n")
    let l:configBuff .= printf("%s"," Conf = clean\n")
    let l:configBuff .= printf("%s"," Conf = configName\n")
    let l:configBuff .= printf("%s"," Conf = configName1 configName2 configNameN\n")
    let l:configBuff .= printf("%s"," Conf = edit\n")
    let l:configBuff .= printf("%s"," Filt = close\n")
    let l:configBuff .= printf("%s"," Filt = colorID\n")
    let l:configBuff .= printf("%s"," Filt = colorID1 colorID2 colorIDN pattern\n")
    let l:configBuff .= printf("%s"," Filt = &groupName pattern\n")
    let l:configBuff .= printf("%s"," Filt = &g1\n")
    let l:configBuff .= printf("%s"," Filt = keepPattern keepColorID --removeColorID --removePattern\n")
    let l:configBuff .= printf("%s"," Filtw = colorID1 colorID2 colorIDN pattern\n")
    let l:configBuff .= printf("%s"," Filtv = keepColorID1 keepColorID2\n")
    let l:configBuff .= printf("%s"," Filtt = keepColorID1 keepColorID2\n")
    let l:configBuff .= printf("%s"," Find = colorID\n")
    let l:configBuff .= printf("%s"," Find = colorID1 colorID2 colorIDN pattern\n")
    let l:configBuff .= printf("%s"," Goto = init\n")
    let l:configBuff .= printf("%s"," Goto = son\n")
    let l:configBuff .= printf("%s"," Goto = parent\n")
    let l:configBuff .= printf("%s"," Goto = last\n")
    let l:configBuff .= printf("%s"," Conf = on\n")
    let l:configBuff .= printf("%s"," Conf = off\n")
    let l:configBuff .= printf("%s"," Conf = won\n")
    let l:configBuff .= printf("%s"," Conf = woff\n")
    let l:configBuff .= printf("%s"," Cmd  = %s/pattern/replace/g\n")
    let l:configBuff .= printf("%s"," Cmd  = w\n")
    let l:configBuff .= printf("%s"," Group = myGroup\n")
    let l:configBuff .= printf("%s"," Tail = 1\n")
    let l:configBuff .= printf("%s","\n")

    let l:configBuff .= hi#utils#EncloseOnRectangle([" FLAGS HELP: "],"normal",l:rectangleSize)
    let l:configBuff .= printf("%s"," C : case sensitive\n")
    let l:configBuff .= printf("%s"," c : case insensitive\n")
    let l:configBuff .= printf("%s"," l : highlight all line\n")
    let l:configBuff .= printf("%s"," b : highlight region\n")
    let l:configBuff .= printf("%s"," T : highlight on top of other highlights\n")
    let l:configBuff .= printf("%s"," h : highlight only, omitt this pattern for any filter\n")
    let l:configBuff .= printf("%s"," gX: assign a group number X\n")
    let l:configBuff .= printf("%s","\n")
    let l:configBuff .= hi#utils#EncloseOnRectangle([" COLOR modifiers HELP: "],"normal",l:rectangleSize)
    let l:configBuff .= printf("%s"," @ : highlight background\n")
    let l:configBuff .= printf("%s"," ! : highlight bold\n")
    let l:configBuff .= printf("%s"," _ : highlight underline\n")
    let l:configBuff .= printf("%s","\n")

    let l:configBuff .= hi#utils#EncloseOnRectangle([" COLOR ID HELP: "],"normal",l:rectangleSize)
    silent let l:configBuff .= hi#help#ColorIdHelp("")

    silent put = l:configBuff
    normal ggdd
    setlocal nohls

    " Close config window if already open
    silent! exec "bd! ".l:buffName

    if l:buffName != ""
        " Rename config window if already open
        let cmd = '0file | file '.l:buffName
        silent exec l:cmd
    endif
    let w:hifEditConfigWinName = expand("%")

    " Save config window number on main window.
    let l:editConfigWinNr = win_getid()
    call win_gotoid(w:hifEditMainWinNr)
    let w:hifEditConfigWinNr = l:editConfigWinNr
    call win_gotoid(w:hifEditConfigWinNr)

    if g:HiCfgEditWinApplyCfgKey != ""
        " Define mapping to apply config on the base window.
        silent exec "silent! autocmd! WinEnter ".l:buffName." call s:MapKeys()"
        silent exec "silent! autocmd! WinLeave ".l:buffName." call s:UnmapKeys()"
        call s:MapKeys()
    endif

    " On exit insert mode, reload the window highlighting.
    silent exec "silent! autocmd! InsertLeave ".l:buffName." call s:ApplyConfigHighlight()"
    silent exec "silent! autocmd! TextChanged ".l:buffName." call s:ApplyConfigHighlight()"

    return 0
endfunction


function! hi#configEditor#ApplyConfigFile(configFile, options)
    return  s:ApplyConfigFile(a:configFile, a:options)
endfunction


" Get edited config from file and apply the configured highlights
function! s:ApplyConfigFile(configFile, options)
    call hi#log#Verbose(1, expand('<sfile>'), "file:".a:configFile." opt:".a:options)

    redir! > readfile.out

    " Parse the config file
    let l:file = readfile(a:configFile)


    let l:tmpConfigList = []
    let l:configFound = 0

    for l:line in l:file
        call hi#log#Verbose(5, expand('<sfile>'), "Line: ".l:line)

        " Prevent field column alignment to interfare on the parsing.
        " Remove any consecutive spaces on field separators.
        "let l:line = substitute(l:line, '"  \+/"', '" "', 'g')

        if hi#config#IsTitle(l:line)
            call hi#log#Verbose(2, expand('<sfile>'), "Title config ".l:line)
            call hi#config#SetTitle(l:line)

        elseif hi#config#IsComment(l:line[0])
            " Line is commented
            call hi#log#Verbose(2, expand('<sfile>'), "Commented config ".l:line)
            call hi#config#AddComment(l:line)

        elseif l:line == ""
            " Empty line
            call hi#log#Verbose(2, expand('<sfile>'), "Empty line")
            if l:configFound == 1 | break | endif

        else
            call hi#log#Verbose(2, expand('<sfile>'), "Config line ".l:line)

            " Line of type: "command = option1 | option2 | optionN"
            " Two list elements expected: 
            " 1: "command"
            " 2: "option1 | option2 | optionN"
            let l:list = split(l:line, "=")

            let len = len(l:list)
            if l:len < 2
                call hi#log#Verbose(2, expand('<sfile>'), "Reject2 line ".l:line)
                if l:configFound == 1 | break | endif
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


            " Check command value correctness.
            let l:command = hi#utils#TrimString(l:fieldsList[0])

            if l:command != "Mark" && l:command !~ "Filt" && l:command != "Conf" && l:command != "Goto" && l:command != "Find" && l:command != "Group" && l:command != "Cmd"
            "if !hi#config#IsCommandOrColor(l:command)
                call hi#log#Verbose(2, expand('<sfile>'), "Reject2 line ".l:line)
                if l:configFound == 1 | break | endif
                continue
            endif

            let l:configFound = 1

            " Color highlight type
            if l:command =~ "Mark"
            "if hi#config#IsColorMark(l:command)
                "if a:options != "All" && a:options != "Mark"
                    "continue
                "endif

                let l:paramList = split(l:fieldsList[1], '|')
                let n = 0
                let l:pattern = " "
                for l:param in l:paramList
                    if l:param == ""
                        call hi#log#Verbose(2, expand('<sfile>'), "Empty filed l:param")
                        continue
                    endif

                    if l:n == 0
                        "let l:color = l:param
                        let l:color =  hi#utils#TrimString(l:param)
                    elseif l:n == 1
                        let last = len(l:param) - 1

                        let l:flags =  hi#utils#TrimString(l:param)

                        if l:flags !~ "c" | let l:flags .= g:HiDefaultCase | endif
                    elseif l:n == 2
                            let l:pattern = l:param
                    elseif l:n > 2
                            let l:pattern .= "|".l:param
                    endif
                    let n+=1
                endfor
                "call hi#log#Verbose(0, expand('<sfile>'), "some parameter empty∵ color:".l:color." opt:".l:flags." pattern:'".l:pattern."'")

                if l:color == "" || l:flags == "" || l:pattern == ""
                    call hi#log#Verbose(3, expand('<sfile>'), "some parameter empty∵ color:".l:color." opt:".l:flags." pattern:'".l:pattern."'")
                    call hi#log#warn("config parameter empty. color:".l:color." opt:".l:flags." pattern:".l:pattern)
                    continue
                endif

                if a:options != "All" && a:options != "Mark"
                    " Do not highlight only save config
                    call hi#config#AddColorConfig(l:color,l:pattern,l:flags)
                else
                    " Highlight and save config
                    call hi#config#PatternHighlight(l:color, l:pattern, l:flags)
                endif

            elseif l:command == "File"
                let w:ConfigTypeFileName = hi#utils#TrimString(l:fieldsList[1])

            " Command type
            elseif l:command =~ "Filt" || l:command == "Conf" || l:command == "Goto" || l:command == "Find" || l:command == "Group" || l:command == "Cmd" || l:command == "Tail"
            "elseif hi#config#IsCommand(l:command)
                let l:params =  hi#utils#TrimString(l:fieldsList[1])

                call hi#log#Verbose(2, expand('<sfile>'), "Command line: ".l:command." ".l:params)


                if a:options != "All" && a:options != "Commands"
                    " Do not apply the command only save config
                    call hi#config#AddCommand(l:command, l:params)
                else
                    " Apply and save config
                    call hi#config#ApplyCommand(l:command, l:params)
                endif

                "for param in split(l:fieldsList[1], '|')
                "endfor
            endif
        endif
    endfor

    redir END
    call delete('readfile.txt')
    call hi#log#Verbose(1, expand('<sfile>'), "".a:configFile." End")
endfunction


" Reload the color highlight on config editor window and main window.
" Command: Hier
function! hi#configEditor#ApplyConfig()
    call hi#log#Verbose(1, expand('<sfile>'), "_")

    "if !exists("w:hifEditMainWinNr") || !exists("w:hifEditConfigWinNr")
    if !exists("w:hifEditMainWinNr") || !exists("w:hifEditConfigWinNr") || !exists("w:hifEditConfigWinName")
        call hi#log#Verbose(2, expand('<sfile>'), "Not defined variables")
        return
    endif
    if w:hifEditConfigWinName != expand("%")
        call hi#log#Verbose(2, expand('<sfile>'), "Wrong window name")
        return
    endif

    "echon "Apply hihglight config..."

    " Save edited highlight config on tmp file.
    let l:tmpFile = tempname()
    silent exec "w ".l:tmpFile

    " Apply new hіghlight on highlight edit window
    " Remove previous config
    call hi#config#SyntaxClear()
    call hi#config#ListClear()
     "Apply new config
    call s:ApplyConfigFile(l:tmpFile, "Mark")
    "call hi#fileConfig#ConfigLoadFile(l:configFile)
    let l:editWinNr = win_getid()

    " Refresh
    call hi#config#Reload()
    call hi#config#SyntaxReload()

    " Apply new hіghlight on the base window
    if win_gotoid(w:hifEditMainWinNr) == 0
        call hi#log#Error("Base window not found ".w:hifEditMainWinNr)
        return 1
    endif

    " Remove previous config
    call hi#config#SyntaxClear()
    call hi#config#ListClear()

    " Apply new config
    silent call s:ApplyConfigFile(l:tmpFile, "All")
    silent! delete(l:tmpFile)

    " Refresh
    call hi#config#Reload()
    call hi#config#SyntaxReload()
endfunction


" Map keys when entering the highlight config editor window.
function! s:MapKeys()
    call hi#log#Verbose(3, expand('<sfile>'), " ")

    if !exists("w:hifEditConfigWinNr")
        call hi#log#Verbose(3, expand('<sfile>'), "hifEditConfigWinNr not defined")
        return
    endif
    if w:hifEditConfigWinNr != win_getid() 
        call hi#log#Verbose(3, expand('<sfile>'), "WinID doesn't match")
        unlet w:hifEditConfigWinNr
        return
    endif

    if !exists("w:hifEditConfigWinName")
        call hi#log#Verbose(3, expand('<sfile>'), "hifEditConfigWinName not defined")
        return
    endif
    if w:hifEditConfigWinName != expand("%")
        call hi#log#Verbose(3, expand('<sfile>'), "Win name doesn't match")
        unlet w:hifEditConfigWinName
        return
    endif

     if g:HiCfgEditorWindowMinSize != 0
        " Restore window size
        silent exec "vertical resize ".g:HiCfgEditWindowNormalSize
    endif
    
    " Set the config editor reload mapping.
    exec("silent! nmap ".g:HiCfgEditWinApplyCfgKey." :Hier<CR>")
    call hi#log#Verbose(3, expand('<sfile>'), "Remap key: ".g:HiCfgEditWinApplyCfgKey." to: :Hier<CR>")

    " Set the config editor quit mapping.
    silent! nmap q :bd!<CR>
    call hi#log#Verbose(3, expand('<sfile>'), "Remap key: q to: :bd!<CR>")
endfunction


" Map keys when exiting the highlight config editor window.
function! s:UnmapKeys()
    call hi#log#Verbose(3, expand('<sfile>'), " ")

    if !exists("w:hifEditConfigWinNr")
        call hi#log#Verbose(3, expand('<sfile>'), "hifEditConfigWinNr not defined")
        return
    endif
    if w:hifEditConfigWinNr != win_getid() 
        call hi#log#Verbose(3, expand('<sfile>'), "WinID doesn't match")
        unlet w:hifEditConfigWinNr
        return
    endif

    if !exists("w:hifEditConfigWinName")
        call hi#log#Verbose(3, expand('<sfile>'), "hifEditConfigWinName not defined")
        return
    endif
    if w:hifEditConfigWinName != expand("%")
        call hi#log#Verbose(3, expand('<sfile>'), "Win name doesn't match")
        unlet w:hifEditConfigWinName
        return
    endif

     if g:HiCfgEditorWindowMinSize != 0
        " Minimize window
        silent exec "vertical resize ".g:HiCfgEditorWindowMinSize
    endif
    
    " Remove config editor reload mapping.
    exec("silent! nunmap ".g:HiCfgEditWinApplyCfgKey)
    call hi#log#Verbose(3, expand('<sfile>'), "Unmap key: ".g:HiCfgEditWinApplyCfgKey)

    " Remove config editor quit mapping.
    silent! nunmap q
    call hi#log#Verbose(3, expand('<sfile>'), "Unmap key: q")
endfunction


"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
