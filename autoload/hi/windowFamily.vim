" Script Name: hi/windowFamily.vim
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
" Add a new son to the selected pattern window number.
" Return 0 on success 1 on failure
function! hi#windowFamily#NewSonToParent(fatherWinNr)
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    let l:parentsDataList = []

    let sonWinNr = win_getid()
    let sonFilePath = expand("%s")

    " Goto parent
    if win_gotoid(a:fatherWinNr) == 0
        call hi#log#Error("Window parent not found ".a:fatherWinNr)
        return 1
    endif

    let fatherFilePath = expand("%s")
    "let w:parentDataList = [ a:fatherWinNr, l:fatherFilePath ]

    " Add parent window data
    if !exists("w:HiSonsDataList")
        let w:HiSonsDataList = []
    endif

    let  w:HiSonsDataList += [ [ l:sonWinNr, l:sonFilePath ] ]

    if exists("w:HiParentsDataList")
        let  l:parentsDataList = w:HiParentsDataList
    endif
    call hi#log#Verbose(1, expand('<sfile>'), "Add son winNr: ".l:sonWinNr." file: ".l:sonFilePath) 

    " Goto son
    call win_gotoid(l:sonWinNr)

    " Add son window data to the list of siblings of current father.
    if !exists("w:HiParentsDataList")
        let w:HiParentsDataList = []
    endif

    let  w:HiParentsDataList += l:parentsDataList
    let  w:HiParentsDataList += [ [ a:fatherWinNr, l:fatherFilePath ] ]
    call hi#log#Verbose(1, expand('<sfile>'), "Add parent winNr: ".a:fatherWinNr." file: ".l:fatherFilePath)

    return 0
endfunction


" Goto first parent (base/main) window.
" Commands: HigoP
function! hi#windowFamily#GotoFirstParentWindow()
    call hi#log#Verbose(1, expand('<sfile>'), " ")
    call hi#configEditor#GotoBaseWin()
    while hi#windowFamily#GotoParent() == 0 | endwhile
endfunction


" Goto last son (filter) window.
" Commands: HigoS
function! hi#windowFamily#GotoLastSonWindow()
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    " Check if we're on base window
    if hi#windowFamily#IsBaseWindow() | return 1 | endif

    " Goto next son.
    while hi#windowFamily#GotoFirstSon() == 0 | endwhile
    return 0
endfunction


" Return 1 if current window is a base window. else return 0
function! hi#windowFamily#IsBaseWindow()
    if !exists("w:HiParentsDataList")
        return 0
    endif
    if hi#windowFamily#GotoFirstSon() == 1 | return 1 | endif
    return 0
endfunction


" Change window position to the father of current window.
" If not found goto the grandfather.
" Return 0 on success 1 on failure
" Commands: Higop
function! hi#windowFamily#GotoParent()
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    if ! exists("w:HiParentsDataList")
        call hi#log#Verbose(1, expand('<sfile>'), "No parents list found")
        return 1
    endif

    let i = len(w:HiParentsDataList)-1

    let winNr = win_getid()
    let winFile = expand("%s")
    call hi#log#Verbose(2, expand('<sfile>'), "Current winnr: ".l:winNr." file: ".l:winFile)

    for fatherList in reverse(w:HiParentsDataList)
        if len(w:HiParentsDataList) == 0
            unlet w:HiParentsDataList
            break
        endif

        let l:fatherWinNr = l:fatherList[0]
        let l:fatherFile  = l:fatherList[1]

        call hi#log#Verbose(2, expand('<sfile>'), "Parent ".l:i.": winnr: ".l:fatherWinNr." file: ".l:fatherFile)

         if (l:winNr == l:fatherWinNr || l:winFile == l:fatherFile)
            " Remove parent from list. Not found
            call hi#log#Verbose(2, expand('<sfile>'), "Remove parent ".l:i.": winnr: ".l:fatherWinNr." file: ".l:fatherFile)
            call remove(w:HiParentsDataList, l:i)
            let i -= 1
            continue
        endif

        " Parent window found
        if win_gotoid(l:fatherWinNr) != 0

            let currentFile = expand("%s")
            call hi#log#Verbose(2, expand('<sfile>'), "Moved to parent ".l:i." file: ".l:currentFile)

            if l:currentFile == l:fatherFile
                " Foster grandson windows to this parent
                if exists("l:sonsList")
                    if exists("w:HiSonsDataList")
                        let w:HiSonsDataList .= [ l:sonsList ]
                    else
                        let w:HiSonsDataList = l:sonsList
                    endif
                    call hi#log#Verbose(2, expand('<sfile>'), "Parent ".l:i.": winnr: ".l:fatherWinNr." file: ".l:fatherFile." OK")
                endif
                return 0
            else
                win_gotoid(l:winNr)
            endif
        else
            call hi#log#Verbose(2, expand('<sfile>'), "Moved to parent ".l:i." failed.")
        endif

        " Save current window sons.
        if exists("w:HiSonsDataList")
            if !exists("l:sonsList")
                let sonsList = []
            endif
            let sonsList .= w:HiSonsDataList
        endif

        " Remove parent from list. Not found
        call hi#log#Verbose(2, expand('<sfile>'), "Remove parent ".l:i.": winnr: ".l:fatherWinNr." file: ".l:fatherFile)
        call remove(w:HiParentsDataList, l:i)
        let i -= 1
    endfor
    call hi#log#Verbose(1, expand('<sfile>'), "Parent NOT found")
    return 1
endfunction


" Goto the first sond found.
" Return 0 on success 1 on failure
" Commands: Higos
function! hi#windowFamily#GotoFirstSon()
    call hi#log#Verbose(1, expand('<sfile>'), " ")

    if ! exists("w:HiSonsDataList")
        call hi#log#Verbose(1, expand('<sfile>'), "No sons list found")
        return 1
    endif

    let i = 0
    let winNr = win_getid()
    let winFile = expand("%s")
    call hi#log#Verbose(2, expand('<sfile>'), "Current winnr: ".l:winNr." file: ".l:winFile)

    for sonList in w:HiSonsDataList
        if len(w:HiSonsDataList) == 0
            unlet w:HiSonsDataList
            break
        endif

        let l:sonWinNr = l:sonList[0]
        let l:sonFile  = l:sonList[1]

        call hi#log#Verbose(2, expand('<sfile>'), "Son ".l:i.". Check winnr: ".l:sonWinNr." file: ".l:sonFile)

         if (l:winNr == l:sonWinNr || l:winFile == l:sonFile)
             "Remove parent from list. Not found
            call hi#log#Verbose(2, expand('<sfile>'), "Son ".l:i.". Rm winnr: ".l:sonWinNr." file: ".l:sonFile)
            call remove(w:HiSonsDataList, l:i)
            continue
        endif

        " Son window found
        if win_gotoid(l:sonWinNr) == 1
            "let currentFile = expand("%s")

            "if l:currentFile == l:sonFile
                call hi#log#Verbose(2, expand('<sfile>'), "Son ".l:i.". FOUND winnr: ".l:sonWinNr." file: ".l:sonFile)
                return 0
            "else
                "win_gotoid(l:winNr) == 1
            "endif
        endif

        " Remove son from list. Not found
        call hi#log#Verbose(2, expand('<sfile>'), "Son ".l:i.". Rm_ winnr: ".l:sonWinNr." file: ".l:sonFile)
        call remove(w:HiSonsDataList, l:i)
        let i += 1
    endfor

    call hi#log#Verbose(1, expand('<sfile>'), "Sons NOT found")
    return 1
endfunction


" Show all saved parent's windows, current window, and son's windows.
" Return: none
function! s:ShowFamilyInfo()
    if g:HiLogLevel < 2 | return | endif
    call hi#log#Verbose(2, expand('<sfile>'), "-----------------------------------------------------------------")

    if exists("w:HiParentsDataList")
        let n = 0
        for data in w:HiParentsDataList
            let l:n += 1
            call hi#log#Verbose(2, expand('<sfile>'), "Parent ".l:n.". Winnr: ".l:data[0]." file: ".l:data[1])
        endfor
    endif

    call hi#log#Verbose(2, expand('<sfile>'), "> Current Winnr: ".win_getid()." file: ".expand("%s"))

    if exists("w:HiSonsDataList")
        let n = 0
        for data in w:HiSonsDataList
            let l:n += 1
            call hi#log#Verbose(2, expand('<sfile>'), "Son    ".l:n.". Winnr: ".l:data[0]." file: ".l:data[1])
        endfor
    endif

    call hi#log#Verbose(2, expand('<sfile>'), "-----------------------------------------------------------------")
endfunction


" Goto window and check buffer name matches the expected name.
" Arg1: windowDataList, list containing winNr, and buffer name.
" Return: 1 on error. else return 0.
function! s:GotoWindow(windowDataList)
    let l:winNr = a:windowDataList[0]
    let l:file  = a:windowDataList[1]

    if win_gotoid(l:winNr) == 0
        call hi#log#Verbose(2, expand('<sfile>'), "Winnr: ".l:winNr." file: ".l:file.". Not found!")
        return 1
    endif

    if l:file != expand("%")
        call hi#log#Verbose(2, expand('<sfile>'), "Winnr: ".l:winNr." file: ".l:file." thisFile: ".expand("%")." Buffer name doesn't match.")
        "silent! call remove(l:HiSonsDataList, l:n)
        return 1
    endif

    call hi#log#Verbose(2, expand('<sfile>'), "Winnr: ".l:winNr." file: ".l:file.". Found OK!")
    return 0
endfunction


" Close all filter windows.
" Cmd: Hifc
function! hi#windowFamily#CloseAll()
    "let g:HiLogLevel = 2
    call hi#log#Verbose(2, expand('<sfile>'), "Current winnr: ".win_getid()." file: ".expand("%s"))

    call hi#windowFamily#GotoFirstParentWindow()
    call hi#log#Verbose(2, expand('<sfile>'), "Base winnr: ".win_getid()." file: ".expand("%s"))
    let l:baseWinNr = win_getid()


    if !exists("w:HiSonsDataList")
        call hi#log#Verbose(1, expand('<sfile>'), "No sons list found")
        return 0
    endif

    if len(w:HiSonsDataList) == 0
        call hi#log#Verbose(1, expand('<sfile>'), "No sons list found")
        return 0
    endif


    let l:baseWinNr = win_getid()
    let l:sonsDataList = w:HiSonsDataList

    while 1
        call s:ShowFamilyInfo()

        if !exists("w:HiSonsDataList") || len(w:HiSonsDataList) == 0
            " No sons found, close current window and goto parent window.

            if win_getid() == l:baseWinNr
                call hi#log#Verbose(2, expand('<sfile>'), "Reached base winnr (1): ".l:baseWinNr)
                if exists("w:HiSonsDataList") | unlet w:HiSonsDataList | endif
                return
            endif

            " Close current window and goto parent window.
            call hi#log#Verbose(1, expand('<sfile>'), "Son ".l:n." ".win_getid()." file: ".expand("%").". Close window (0) OK!")
            silent bd!

            if !exists("w:HiParentsDataList") || len(w:HiParentsDataList) == 0
                call hi#log#Verbose(2, expand('<sfile>'), "No parents list found.")
                return
            endif

            " Goto parent window.
            call hi#log#Verbose(2, expand('<sfile>'), "Go up to parent.")
            let n = -1
            for parentList in reverse(w:HiParentsDataList)
                let l:n += 1

                let l:parentWinNr = l:parentList[0]
                let l:parentFile  = l:parentList[1]

                if s:GotoWindow(l:parentList)
                    call remove(w:HiParentsDataList, l:n)
                    continue
                endif

                call hi#log#Verbose(2, expand('<sfile>'), "Parent ".l:n.". Winnr: ".l:parentWinNr." file: ".l:parentFile.". Found OK.")
                call s:ShowFamilyInfo()
                if win_getid() == l:baseWinNr
                    call hi#log#Verbose(2, expand('<sfile>'), "Parent ".l:n.". Winnr: ".l:parentWinNr." file: ".l:parentFile.". Is base window.")
                    continue
                endif
                break
            endfor
        endif

        " Goto next son
        call hi#log#VerboseStop(2, expand('<sfile>'), "Close every filter son window:")
        let n = -1

        for sonList in w:HiSonsDataList
            let l:n += 1
            let l:sonWinNr = l:sonList[0]
            let l:sonFile  = l:sonList[1]

            if s:GotoWindow(l:sonList)
                silent! call remove(l:HiSonsDataList, l:n)
                continue
            endif

            call s:ShowFamilyInfo()

            if !exists("w:HiSonsDataList") || len(w:HiSonsDataList) == 0
                call hi#log#Verbose(1, expand('<sfile>'), "Son ".l:n.". Winnr: ".l:sonWinNr." file: ".l:sonFile." Close window (1) OK.")
                silent bd!
            else
                " Iterate new sons tree
                call hi#log#Verbose(2, expand('<sfile>'), "Go down to new son tree")
                call s:GotoWindow(w:HiSonsDataList[0])
                call s:ShowFamilyInfo()
                break
            endif
        endfor

        if win_getid() == l:baseWinNr
            call hi#log#Verbose(2, expand('<sfile>'), "Reached base winnr (3): ".l:baseWinNr)
            if exists("w:HiSonsDataList") | unlet w:HiSonsDataList | endif
            return
        endif

        if exists("w:HiSonsDataList")
            call hi#log#Verbose(2, expand('<sfile>'), "Remove all saved sons on Winr:  ".win_getid()." file: ".expand("%"))
            unlet w:HiSonsDataList
        endif
    endwhile
endfunction





"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
