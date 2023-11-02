" Script Name: hi#autoConfig.vim
" Description: Highlight patterns in different colors.
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



" Search for the highlight config to apply on the first and last lines of the buffer.
" Example1: :vim_hi:cfg=MY_CONFIG
" Example2: :vim_hi:cfg=MY_CONFIG::cfgfile=MY_CONFIG_FILE
" Example3: :vim_hi:cfg=MY_CONFIG::cfgfile=%
" Commands: none
function! hi#autoConfig#ConfigLineSearchAndApplyConfig(requireUserConsent)
    call hi#log#Verbose(1, expand('<sfile>'), "")

    if g:HiAutoConfigLineNumberOfLines == 0
        return
    endif

    "call hi#log#Verbose(1, expand('<sfile>'), "INIT")
    "echo "Checking highlight auto config line"

    let l:configName = ""
    let l:configFile = ""

    " Save window position
    let l:winview = winsaveview()
    " Save window ID
    let l:winNr = win_getid()

    " Add lines to be checked for the configuration line
    " Line numbers on top of the file
    let lineNumberList = []
    let l:n = 1
    while l:n <= g:HiAutoConfigLineNumberOfLines
        let lineNumberList += [l:n]
        let l:n += 1
    endwhile
    " Line numbers on bottom of the file
    let l:n = line("$") - g:HiAutoConfigLineNumberOfLines
    while l:n <= line("$")
        let lineNumberList += [l:n]
        let l:n += 1
    endwhile

    " Parse first file lines:
    let l:n = 1
    for l:lineNumber in l:lineNumberList
        silent exec 'normal '. l:lineNumber . 'GV"zy'
        let l:line = @z
        "call hi#log#Verbose(1, expand('<sfile>'), "Check line".l:lineNumber.": ".l:line)

        if l:line =~ "vim_hi:"
            " Get content after vim_hi:
            let l:lineList = split(l:line, 'vim_hi:')

            if len(l:lineList) == 0
                continue
            elseif len(l:lineList) == 1
                " NO Parameter found before vim_hi:
                let l:configsList = split(l:lineList[0], '::')
            else
                " Parameter found before vim_hi:
                let l:configsList = split(l:lineList[1], '::')
            endif

            if len(l:configsList) > 1
                " Parse each parameter.
                for l:config in l:configsList
                    let l:configList = split(l:config, '=')
                    let l:name = l:configList[0]
                    let l:value = l:configList[1]
                    "call hi#log#Verbose(1, expand('<sfile>'), "config: ".l:name." = ".l:value)
                    if l:name == "cfg"
                        let l:configName = hi#utils#TrimString(l:value)
                    endif
                    if l:name == "cfgfile"
                        let l:configFile = hi#utils#TrimString(l:value)
                    endif
                endfor
            else
                let l:configList = split(l:configsList[0], '=')
                let l:name = l:configList[0]
                let l:value = l:configList[1]
                "call hi#log#Verbose(1, expand('<sfile>'), "config: ".l:name." = ".l:value)
                if l:name == "cfg"
                    let l:configName = hi#utils#TrimString(l:value)
                endif
                if l:name == "cfgfile"
                    let l:configFile = hi#utils#TrimString(l:value)
                endif
            endif

            if l:configName != ""
                break
            endif
        endif
        let l:lineNumber += 1
    endfor

    if l:configFile == "%"
        " Get the configuration from current file.
        let l:configFile = expand("%")
    endif

    if l:configName != ""
        call s:ApplyConfig(l:configName, l:configFile, a:requireUserConsent)
    endif

    " Restore window 
    call win_gotoid(l:winNr)
    " Restore window position
    call winrestview(l:winview)

    "call hi#log#Verbose(1, expand('<sfile>'), "END")
endfunction


" Apply highlight configName from selected configFile.
" Example: apply hilight config with auto command when opening a file with .log extension:
"  add to .vimrc: au BufRead *.log call hi#autoConfig#ApplyConfig("MY_CONFIG","/MY_PATH/MY_CONFIG_FILE.cfg")
" Commands: Hitf
function! hi#autoConfig#ApplyConfig(configName, configFile)
    call hi#log#Verbose(1, expand('<sfile>'), "name:".a:configName." file:".a:configFile)

    " Save window position
    let l:winview = winsaveview()
    " Save window ID
    let l:winNr = win_getid()

    call s:ApplyConfig(a:configName, a:configFile, g:HiAutoConfigLineUserConsent)

    " Restore window 
    call win_gotoid(l:winNr)
    " Restore window position
    call winrestview(l:winview)

    "call hi#log#Verbose(1, expand('<sfile>'), "END")
endfunction


" Apply highlight configName from selected configFile.
function! s:ApplyConfig(configName, configFile, requireUserConsent)
    call hi#log#Verbose(1, expand('<sfile>'), "".a:configName." file:".a:configFile)
    "
    if a:configFile != ""
        echo "hi.vim: loading config file: ". a:configFile
        if hi#fileConfig#LoadConfigFile(a:configFile) != 0
            return 1
        endif
        let w:ConfigTypeFileName = a:configFile
    endif

    if a:configName != ""
        let l:configName = a:configName

        if a:requireUserConsent == 1
            if confirm("Apply highlight config: '".l:configName."'", "&yes\n&no", 1) != 1
                let l:configName = ""
            endif
        else
            echo "hi.vim: load highlight config: ". l:configName
        endif

        if l:configName != ""
            "call hi#configTypes#LoadConfigType(l:configName, "applyConfig", "saveTitle", "noComment")
            call hi#configTypes#LoadConfigType(l:configName, 1, 1)
        endif
    endif

    return 0
endfunction


function! hi#autoConfig#Init()
    if g:HiAutoConfigLineActive != 1
        return
    endif

    augroup HiAutoConfig
        silent autocmd!

        let l:userConsent = g:HiAutoConfigLineUserConsent
        let filetTypeList = []

        if g:HiAutoConfigSearchOnFileTypes == ""
            call hi#log#Error("Auto load config filter: '".g:HiAutoConfigSearchOnFileTypes."' not allowed.")
            return
        else
            let list = split(g:HiAutoConfigSearchOnFileTypes, "")
            if len(l:list) > 0
                let l:filetTypeList = l:list
            else
                let filetTypeList .= [g:HiAutoConfigSearchOnFileTypes]
            endif
        endif

        for fileType in l:filetTypeList
            silent! exec "noauau BufReadPost ".l:fileType
            silent exec "au BufReadPost ".l:fileType." call hi#autoConfig#ConfigLineSearchAndApplyConfig(".l:userConsent.")"
        endfor
    augroup END
endfunction
