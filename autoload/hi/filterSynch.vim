" Script Name: hi/filterSynch.vim
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


" Compare current file extension
function! s:IsFileExt(extensions)
    let l:currentExt = fnameescape(expand("%:e"))
    for ext in split(a:extensions,' ')
        if l:currentExt ==? l:ext
            return 1
        endif
    endfor
    return 0
endfunction


" Syncronize position between original file and filter (son) window
" Note: experimental function it may not work if exist several
" identical lines on both buffers.
" Commands: Hips, Hipsa, Hipsn
function! hi#filterSynch#SyncSwitchWindowPosition(...)
    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
        "call hi#log#Warn("Window synchronization not active.")
        call hi#log#Warn("No parent or son windows available.")
        return
    endif

    " Change position sinchcronization mode
    if a:0 >= 1 && a:1 != ""
        if a:1 == "auto"
            call s:AutoSyncFiltWindowPosCfg("on")
        elseif a:1 == "noauto"
            call s:AutoSyncFiltWindowPosCfg("off")
        else
            call hi#log#Warn("Unknown mode:'".a:1."'. Use modes: auto/noauto")
        endif
        return
    endif

    let initWinNr = win_getid()

    let line = getline('.')
    call hi#log#Verbose(2, expand('<sfile>'), "Line: ".l:line)

    " Synchronize all first son windows
    let l:sonWinNr = ""
    let l:sonPos = 0
    while !hi#windowFamily#GotoFirstSon()
        call hi#log#Verbose(2, expand('<sfile>'), "Search line on son window.")
        if hi#utils#SearchLine(l:line)
            if l:sonWinNr == ""
                let l:sonWinNr = win_getid()
                let l:sonPos = winsaveview()
                call hi#log#Verbose(1, expand('<sfile>'), "Save first son window ".l:sonWinNr)
            endif
        endif
    endwhile

    call win_gotoid(l:initWinNr)

    " Synchronize all parent windows
    let l:parentWinNr = ""
    let l:parentPos = 0

    while !hi#windowFamily#GotoParent()
        call hi#log#Verbose(2, expand('<sfile>'), "Search line on parent window.")
        if hi#utils#SearchLine(l:line)
            if l:parentWinNr == ""
                let l:parentWinNr = win_getid()
                let l:parentPos = winsaveview()
                call hi#log#Verbose(1, expand('<sfile>'), "Save previous parent window ".l:parentWinNr)
            endif
        endif
    endwhile

    call win_gotoid(l:initWinNr)

    if l:parentWinNr != ""
        call hi#log#Verbose(2, expand('<sfile>'), "Switch to first parent window ".l:parentWinNr)
        call win_gotoid(l:parentWinNr)
        call winrestview(l:parentPos)
    else
        call hi#log#Verbose(2, expand('<sfile>'), "Not found on parent window.")
        if l:sonWinNr != ""
            call hi#log#Verbose(2, expand('<sfile>'), "Switch to first son window ".l:sonWinNr)
            call win_gotoid(l:sonWinNr)
            call winrestview(l:sonPos)
        else
            call hi#log#Verbose(2, expand('<sfile>'), "Not found on son window.")
            call hi#log#Warn("Not found.")
        endif
    endif
    return
endfunction


" Syncronize position between original (parent) and filter (son) windows
" Leave cursor on the same window it was.
" Note: experimental function it may not work if exist several
" identical lines on both buffers.
" Commands: Hip
function! hi#filterSynch#SyncWindowPosition(...)
    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
        call hi#log#Warn("Window synchronization not active.")
        return
    endif

    let winNr1 = win_getid()

    if a:0 >= 1
        let tmp=a:1
    else
        let tmp=""
    endif

    call hi#log#Verbose(1, expand('<sfile>'), "Args: ".l:tmp)
    call hi#filterSynch#SyncSwitchWindowPosition(l:tmp)
    call win_gotoid(l:winNr1)
endfunction


" Handle movement events on filter (son) or base (parent) window.
" Perform window position synchronization if configuration enabled
function! hi#filterSynch#AutoSyncFiltWindowPosition()
    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
        return
    endif
    if !exists('w:autoSyncFiltPos')
        let w:autoSyncFiltPos = g:HiAutoSyncFiltPos
    endif
    if w:autoSyncFiltPos == 1
        call hi#filterSynch#SyncWindowPosition()
    endif
endfunction


" Configure data syncronization between base (parent) and filter (son) window.
function! s:AutoSyncFiltWindowDataCfg(state)
    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
        call hi#log#Warn("Window synchronization not active.")
        return
    endif

    if a:state == "on"
        echo "Highlight window sync data on"
        let autoUpdate = 1
    elseif a:state == "off"
        echo "Highlight window sync data off"
        let autoUpdate = 0
    else
        call hi#log#Error("Arguments: on/off")
        return
    endif

    let initWinNr = win_getid()

    let w:autoSyncFiltData = l:autoUpdate
endfunction


" Get the filter command applied.
" Return: ag or grep filter command, "" if not found.
function! hi#filterSynch#GetFiltWindowCmd()
    let winNr = win_getid()
    let l:pos = winsaveview()
    let l:filtCmd = ""

    " Parent window exists
    if !hi#windowFamily#GotoParent()
        " I'm on a son windoww
        " Go to first parent window.
        while !hi#windowFamily#GotoParent() | endwhile
    endif

    call hi#windowFamily#GotoFirstSon()

    if exists("w:HiFiltCmd1")
        let l:filtCmd = w:HiFiltCmd1
    else
        call hi#log#Warn("Highlight filter command not found.")
    endif

    call win_gotoid(l:winNr)
    call winrestview(l:pos)
    "echo "Sync filter command: ".l:filtCmd
    return l:filtCmd
endfunction



" Synchronize data of filter (son) window with base (parent) window
" Commands: Hid, Hidsa, Hidsn, Hiup
function! hi#filterSynch#SyncFiltWindowData(...)
    if !exists("w:HiFiltColors")
        call hi#log#Warn("Highlight not set.")
        return
    endif

    if w:HiFiltColors != ""
        echo "Sync filter data colors: ".w:HiFiltColors
    endif

    let initWinNr = win_getid()
    let initFile = expand("%s")
    let reloadFileFlag = 0
    let tailFlag = 0

    " Change position sinchcronization mode
    if a:0 >= 1 && a:1 != ""
        if a:1 == "auto"
            call hi#log#Verbose(1, expand('<sfile>'), "auto")
            call s:AutoSyncFiltWindowDataCfg("on")
            "return
        elseif a:1 == "noauto"
            call hi#log#Verbose(1, expand('<sfile>'), "noauto")
            call s:AutoSyncFiltWindowDataCfg("off")
            "return
        elseif a:1 == "update"
            call hi#log#Verbose(1, expand('<sfile>'), "update data")
            let reloadFileFlag = 1
        elseif a:1 == "tail"
            call hi#log#Verbose(1, expand('<sfile>'), "tail data")
            let tailFlag = 1
        else
            call hi#log#Warn("Unknown mode:'".a:1."'. Use modes: auto/noauto")
            return
        endif
    endif
"echo "RELOADFILEFLAG = ".l:reloadFileFlag

    let line = getline('.')

    " Parent window exists
    if !hi#windowFamily#GotoParent()
        " I'm on a son windoww
        " Go to first parent window.
        while !hi#windowFamily#GotoParent() | endwhile

        " Copy all data from first parent window
        let l:pos = winsaveview()

        if l:reloadFileFlag == 1
            call hi#log#Verbose(2, expand('<sfile>'), "update parent window data")
            silent edit!
        endif

        normal ggVGy
        call winrestview(l:pos)

        " Paste original data on the son window
        call win_gotoid(l:initWinNr)
        normal ggVGp

        " Filter data again
        call hi#log#Verbose(1, expand('<sfile>'), "ColorFilter ".w:HiFiltColors)
        call hi#filter#Color("", w:HiFiltColors, "", l:line)
        if l:tailFlag == 1 | normal G
        endif
    else
        " I'm on first parent window
        " Copy all data from first parent window
        let l:pos = winsaveview()

        if l:reloadFileFlag == 1
            call hi#log#Verbose(2, expand('<sfile>'), "update parent window data")
            e!
        endif

        normal ggVGy
        call winrestview(l:pos)

        " Loop until last son reached.
        while !hi#windowFamily#GotoFirstSon()
            " Paste original data on the son window
            normal ggVGp

            " Filter data again
            call hi#log#Verbose(1, expand('<sfile>'), "ColorFilter ".w:HiFiltColors)
            call hi#filter#Color("", w:HiFiltColors, "", l:line)
            if l:tailFlag == 1 | normal G
            endif
        endwhile

        call win_gotoid(l:initWinNr)
    endif

    " Refresh all window highlighting
    windo call hi#hi#Refresh()
endfunction



" Synchronize data on filter (son) and base (parent) window
function! hi#filterSynch#AutoSyncFiltWindowData()
    "if !exists('w:FiltWinSyncList')
    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
        if g:HiAutoFilt == 1
            if s:IsFileExt(g:HiAutoFiltExtensions) == 1
                call hi#filter#Color(g:HiFilterSplit, "", "", "")
                return
            endif
            if s:IsFileExt(g:HiAutoFiltNotExtensions) == 0
                redraw
                if confirm("","Open filter window: &yes\n&no",1) == 2
                    return
                endif
                call hi#filter#Color(g:HiFilterSplit, "", "", "")
                return
            endif
        endif
    endif

    if !exists('w:autoSyncFiltData')
        let w:autoSyncFiltData = g:HiAutoSyncFiltData
    endif

    if w:autoSyncFiltData == 1
        call hi#filterSynch#SyncFiltWindowData("")
    endif
endfunction


" Synchronize filter (son) and base (parent) window
" On any change synchronize both: position and data.
function! hi#filterSynch#AutoSyncFiltWindowCfg()
    "if !exists('w:FiltWinSyncList')
    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
        call hi#log#Warn("Window synchronization not active.")
        return
    endif
    call s:AutoSyncFiltWindowPosCfg("on")
    call s:AutoSyncFiltWindowDataCfg("on")
endfunction


function! hi#filterSynch#SyncFiltWindowCfg(...)
    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
    "if !exists('w:FiltWinSyncList')
        call hi#log#Warn("Window synchronization not active.")
        return
    endif

    if a:0 >= 1
        let tmp=a:1
    else
        let tmp=""
    endif
    call s:AutoSyncFiltWindowPosCfg(l:tmp)
endfunction


" Configure data syncronization between base(parent) and filter(son) windows.
function! s:AutoSyncFiltWindowPosCfg(state)
    "if !exists('w:FiltWinSyncList')
    if !exists('w:HiParentsDataList')
        call hi#log#Warn("Window synchronization not active.")
        return
    endif

    if a:state == "on"
        echo "Highlight window sync movement on"
        let autoUpdate = 1
    elseif a:state == "off"
        echo "Highlight window sync movement off"
        let autoUpdate = 0
    else
        call hi#log#Error("Arguments: on/off")
        return
    endif

    let w:autoSyncFiltPos = l:autoUpdate

    let initWinNr = win_getid()

    while !hi#windowFamily#GotoParent()
        let w:autoSyncFiltPos = l:autoUpdate
    endwhile

    call win_gotoid(l:initWinNr)

    while !hi#windowFamily#GotoFirstSon()
        let w:autoSyncFiltPos = l:autoUpdate
    endwhile

    call win_gotoid(l:initWinNr)
endfunction


" Map keys when exiting a buffer with highlights and parents
" or son windows avalilble
function! s:MapKeys()
    call hi#log#Verbose(4, expand('<sfile>'), " ")

    let keyConfig = ""
    let keyConfig .= g:HiSyncWinKey
    let keyConfig .= g:HiSyncSwitchWinKey
    let keyConfig .= g:HiSyncDataWinKey
    let keyConfig .= g:HiUpdateDataWinKey
    if l:keyConfig == "" | return | endif

    if !exists("w:HiParentsDataList") && !exists("w:HiSonsDataList")
        return
    endif

    if exists("w:HiParentsDataList") 
        if len(w:HiParentsDataList) == 0
            unlet w:HiParentsDataList
            return
        endif
    endif

    if exists("w:HiSonsDataList")
        if len(w:HiSonsDataList) == 0
            unlet w:HiSonsDataList
            return
        endif
    endif

    call hi#log#Verbose(4, expand('<sfile>'), "Son synchronization keys")

    if g:HiSyncWinKey != ""
        " Save previous mapping
        "exec("let w:SyncPosMap = nmap ".g:HiSyncWinKey)
        " Configure new mapping
        call hi#log#Verbose(5, expand('<sfile>'), g:HiSyncWinKey."  to Hip")
        exec("silent! nmap ".g:HiSyncWinKey." :Hip<CR>")
    endif

    if g:HiSyncSwitchWinKey != ""
        " Configure new mapping
        call hi#log#Verbose(5, expand('<sfile>'), g:HiSyncSwitchWinKey."  to Hips")
        exec("silent! nmap ".g:HiSyncSwitchWinKey." :Hips<CR>")
    endif

    if g:HiSyncDataWinKey != ""
        " Configure new mapping
        call hi#log#Verbose(5, expand('<sfile>'), g:HiSyncDataWinKey."  to Hid")
        exec("silent! nmap ".g:HiSyncDataWinKey." :Hid<CR>")
    endif

    if g:HiUpdateDataWinKey != ""
        " Configure new mapping
        call hi#log#Verbose(5, expand('<sfile>'), g:HiUpdateDataWinKey."  to Hiup")
        exec("silent! nmap ".g:HiUpdateDataWinKey." :Hiup<CR>")
    endif

    if !exists("w:HiParentsDataList") && g:HiFilterMinimize == 1
        winc _
    endif
endfunction


" Unmap keys when exiting a buffer with highlights and parents
" or son windows avalilble
function! s:UnmapKeys()
    call hi#log#Verbose(4, expand('<sfile>'), " ")

    let keyConfig = ""
    let keyConfig .= g:HiSyncWinKey
    let keyConfig .= g:HiSyncSwitchWinKey
    let keyConfig .= g:HiSyncDataWinKey
    let keyConfig .= g:HiUpdateDataWinKey
    if l:keyConfig == "" | return | endif

    if !exists("w:HiParentsDataList") && !exists("w:HiSonsDataList")
        return
    endif

    if exists("w:HiParentsDataList") 
        if len(w:HiParentsDataList) == 0
            unlet w:HiParentsDataList
            return
        endif
    endif

    if exists("w:HiSonsDataList")
        if len(w:HiSonsDataList) == 0
            unlet w:HiSonsDataList
            return
        endif
    endif

    call hi#log#Verbose(4, expand('<sfile>'), "Son synchronization keys")

    if g:HiSyncWinKey != ""
        call hi#log#Verbose(5, expand('<sfile>'), g:HiSyncWinKey)
        exec("silent! nunmap ".g:HiSyncWinKey)
    endif

    if g:HiSyncSwitchWinKey != ""
        call hi#log#Verbose(5, expand('<sfile>'), g:HiSyncSwitchWinKey)
        exec("silent! nunmap ".g:HiSyncSwitchWinKey)
    endif

    if g:HiSyncDataWinKey != ""
        call hi#log#Verbose(5, expand('<sfile>'), g:HiSyncDataWinKey)
        exec("silent! nunmap ".g:HiSyncDataWinKey)
    endif

    if g:HiUpdateDataWinKey != ""
        call hi#log#Verbose(5, expand('<sfile>'), g:HiUpdateDataWinKey)
        exec("silent! nunmap ".g:HiUpdateDataWinKey)
    endif

    if exists("w:HiParentsDataList") && g:HiFilterMinimize == 1
        winc =
    endif
endfunction


function! hi#filterSynch#UnmapKeys()
    call s:MapKeys()
endfunction


 "On new file opened, load last color highlighting
function! s:AutoLoadColorHiglighting()
    "return
    call hi#log#Verbose(4, expand('<sfile>'), " ")

    if g:HiAutoload != 1 | return | endif

    if exists("w:HiTypesList")
        return
    endif
    let w:HiTypesList = []

    " Load file config
    let w:HiTypesList = []
    let file  = fnameescape(expand('%:h')).g:HiDirSep
    let file .= g:HiAutoSaveSourcePrefix
    let file .= fnameescape(expand('%:t'))
    let file .= g:HiAutoSaveSourceSufix

    if !filereadable(l:file)
        return
    endif
endfunction

"- initializations ------------------------------------------------------------

augroup Hi_
	autocmd!
    autocmd BufWinEnter * :call s:AutoLoadColorHiglighting()
    autocmd WinEnter * :call s:MapKeys()
    autocmd WinLeave * :call s:UnmapKeys()
augroup END



"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
