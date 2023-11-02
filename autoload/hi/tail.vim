" Script Name: hi/tail.vim
" Description: Highlight text patterns in different colors.
"   Allows to save, reload and modify the highlighting configuration.
"   Allows to filter by color the lines and show then on a new split/tab.
"
" Copyright:   (C) 2017-2021 Javier Puigdevall
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Puigdevall <javierpuigdevall@gmail.com>
" Contributors:
"
" Dependencies:
"   +job
"   +timers
"   jobs.vim
"   rsync
"   diff
"

if !exists('g:HiLoaded')
    finish
endif


"- functions -------------------------------------------------------------------
"

" Debug execution functions:
"
function! hi#tail#LogStatus(status)
    if a:status == 0
        echo "HiTail log not active." 
        let s:HiTailLog = 0
    else
        echo "HiTail log active." 
        let s:HiTailLog = 1
    endif
endfunction


function! s:Log(message)
    if s:HiTailLog == 0
        return
    endif
    if !exists("s:HiTailLogList")
        let  s:HiTailLogList = []
    endif
    let s:HiTailLogList += [ a:message ]
endfunction


function! hi#tail#GetLog()
    if s:HiTailLog == 0
        echo "ERROR. s:HiTailLog not active" 
        return
    endif
    if !exists("s:HiTailLogList")
        echo "ERROR. s:HiTailLogList not found" 
    endif
    tabedit
    for message in s:HiTailLogList
        put = l:message
    endfor
    silent! unlet s:HiTailLogList
endfunction


" Execution time functions:

function! s:LogTime(message)
    if s:HiTailLogTimes == 0
        return
    endif
    if !exists("s:HiTailLogTimeList")
        let  s:HiTailLogTimeList = []
    endif
    let s:HiTailLogTimeList += [ a:message ]
endfunction


function! hi#tail#GetTimeLog()
    if s:HiTailLogTimes == 0
        echo "ERROR. s:HiTailLogTimes not active" 
        return
    endif
    if !exists("s:HiTailLogTimeList")
        echo "ERROR. Time log not found" 
    endif
    if len(s:HiTailLogTimeList) == 0
        echo "ERROR. s:HitTailLogTimeList not found" 
    endif

    vertical new
    for message in s:HiTailLogTimeList
        put = l:message
        "echo l:message
    endfor
    silent normal ggdd
    "silent! unlet s:HiTailLogTimeList
endfunction



" Tail update functions:

"
" Update main and filter windows using a bash script that performs rsync and
" diff.
" Arg1: not used. Needed for timer use.
function! hi#tail#Reload(timer)
    if !exists("s:HiTailNum")
        return
    endif

    let s:HiTailNum += 1
    call s:Log("")
    call s:Log("Tai#Reload ".s:HiTailNum)

    if s:HiTailLogTimes == 1
        let s:HiTime0 = localtime()
    endif

    redraw
    if exists("s:HiTailTimerTimeMsec")
        echo "Hi plugin: tail reload (Move cursor outside last line to stop updating). Iteration: ".s:HiTailNum.""
    else
        echo "Hi plugin: tail reload."
    endif

    call s:Reload()
    silent! call s:Log("Tai#Reload end ".s:HiTailNum)
    "call s:Log("Tai#Reload end ")
endfunction


function! s:Reload()
    call s:Log("  s:Reload ".s:HiTailNum)
    if !exists("s:HiTailNum")
        return
    endif

    let jobName = "hiTail"

    if jobs#IsOnWindow(l:jobName) == 1
        call hi#log#Error("Hi Plugin. Command already running in background on this window")
        call s:Log("    Command already running in background on this window")
        silent call s:stopTailUpdate()
        call s:Log("  s:Reload end")
        return
    endif

    let l:file = expand("%")
    if l:file[0:5] == "scp://"
        let l:file = substitute(l:file, "scp://", "", "")
        let l:file = substitute(l:file, "//", ":/", "")
    endif

    " Save current buffer into tmp file to be updated with rsync.
    let tmpFile = tempname()
    silent exec "silent w! ".l:tmpFile

    " Save filter command into file.
    silent exec("new ".l:tmpFile.".cmd")
    silent normal ggdG
    for line in s:HiTailFiltCmdList
        silent put = l:line | silent normal ggdd
        call s:Log("    Add filter cmd: ".l:line)
    endfor
    silent w! | silent bd!

    " Launch script asyncrhonous
    let l:async = 1
    let l:command  = "time ".s:plugin_path."/tail.sh ".l:file." ".l:tmpFile
    let l:callback = ["hi#tail#ReloadCallback", l:file, l:tmpFile]
    call s:Log("    RunCmd: ".l:command)

    if s:HiTailLogTimes == 1
        let s:HiTime1 = localtime()
    endif

    silent call jobs#RunCmd0(l:command,l:callback,l:async,l:jobName)
    silent! call s:Log("  s:Reload end ".s:HiTailNum)
    call s:Log("  s:Reload end ")
    return 0
endfunction


" Rsync command end. Process command results.
function! hi#tail#ReloadCallback(file, tmpFile, resultFile)
    if !exists("s:HiTailNum")
        return
    endif

    if s:HiTailLogTimes == 1
        let s:HiTimeScript = localtime() - s:HiTime1
        let s:HiTime2 = localtime()
    endif

    call s:Log("")
    call s:Log("Tail#ReloadCallback ".s:HiTailNum)

    if exists("s:HiTailFile")
        if expand("%") != s:HiTailFile
            " Save current window and position
            " In case we changed to another window/buffer
            let l:lastWinnr = win_getid()
            let l:lastPosition = winsaveview()
        endif
    endif

    if s:HiTailLog == 1
        " Add tail.sh script output to the log list.
        silent exec("tabnew ".a:resultFile)
        silent normal ggVG"ay
        let l:lines = @a
        call s:Log("  Tail.sh file:".a:resultFile)
        for line in split(l:lines,"\n")
            call s:Log("    ".l:line)
        endfor
        silent bd!
    endif

    " DEBUG
    " Open all files created by tail.sh:
    "silent exec("tabnew ".a:resultFile)
    "silent exec("new ".a:tmpFile)
    "silent exec("new ".a:tmpFile.".updated")
    "silent exec("new ".a:tmpFile.".cmd")
    " DEBUG end

    if a:file[0:5] == "scp://"
        let file=a:tmpFile.".updated"
        if !filereadable(l:file)
            if s:HiTailLogTimes == 1
                let s:HiTimeDisplay = localtime() - s:HiTime2
                let s:HiTimeTotal = localtime() - s:HiTime0
                call s:LogTime("Run".s:HiTailNum." times Sync:".s:HiTimeScript." Display:".s:HiTimeDisplay." Total:".s:HiTimeTotal."")
            endif

            call hi#log#Error("Hi plugin. Update tail: rsync failed.")
            call s:Log("  ERROR: Update tail: rsync failed.")
            call s:stopTailUpdate()

            call s:Log("Tai#Reload end ")
            return 1
        endif
    endif

    " Open the file updated with rync, remove old lines.
    let file=a:tmpFile.".main"
    if !filereadable(l:file)
        call hi#log#Error("Hi plugin. Update tail: diff failed.")
        call s:Log("  ERROR: Update tail: diff failed.")
        call s:stopTailUpdate()

        if s:HiTailLogTimes == 1
            let s:HiTimeDisplay = localtime() - s:HiTime2
            let s:HiTimeTotal = localtime() - s:HiTime0
            call s:LogTime("Run".s:HiTailNum." times Sync:".s:HiTimeScript." Display:".s:HiTimeDisplay." Total:".s:HiTimeTotal."")
        endif

        call s:Log("Tai#Reload end ".s:HiTailNum)
        return 1
    else
        silent exec("tabedit ".l:file)
        call s:Log("  Main:".l:file." lines:".line("$"))
        silent normal ggVG"ay
        let l:mainLines = @a
        silent bd!
    endif

    let cmd = "call delete(\"".a:tmpFile."*\")"
    silent exec(l:cmd)
    let l:stopUpdate = 0

    " ------------------------------------------------
    " MAIN WINDOW
    " ------------------------------------------------
    " Goto the main highlighted file
    call win_gotoid(s:HiTailSavedWinnr)
    let l:mainPosition = winsaveview()

    if line('.') == line('$')
        let l:gotoEnd = 1
    else
        call s:Log("  cursor moved, stop tail update.")
        let l:gotoEnd = 0
        let l:stopUpdate = 1
    endif

    " Paste new lines at the end of the orginal file.
    call hi#windowFamily#GotoFirstParentWindow()
    silent normal G
    silent put = l:mainLines
    call s:Log("  Main:".expand("%")." lines:".line("$"))
    if l:gotoEnd == 1
        silent normal G
    else
        call winrestview(l:mainPosition)
    endif

    " ------------------------------------------------
    " FILTER WINDOW
    " ------------------------------------------------
    " Goto each filter window and update the content
    let i = 0
    while hi#windowFamily#GotoFirstSon() == 0
        let i += 1
        call s:Log("  filterWindow".l:i." file:".expand("%"))

        " Search same filter configuration.
        " Make sure the content we update matches the current window filter command
        " Just in case some filter window has been closed.
        if !exists("w:HiFiltCmdExt")
            call s:Log("  w:HiFiltCmdExt not found")
            continue
        endif
        let l:n = 1
        let l:fileNum = 0
        for filterCmd in s:HiTailFiltCmdList
            if w:HiFiltCmdExt == l:filterCmd
                let l:fileNum = l:n
                call s:Log("  filterWindow".l:i." compare filterCmd".l:n." ok")
            else
                call s:Log("  filterWindow".l:i." compare filterCmd".l:n." failed")
            endif
            let l:n += 1
        endfor
        if l:fileNum == 0
            call s:Log("  filter command not found!")
            continue
        endif

        " Open the file updated and filtered.
        let file=a:tmpFile.".filt".l:fileNum
        if !filereadable(l:file)
            call s:Log("  filterWindow".l:i." file:".l:file." not found.")
            continue
        endif

        silent exec("new ".l:file)
        call s:Log("  Filt:".l:file." lines:".line("$"))
        silent normal ggVG"ay
        let l:filtLines = @a
        silent bd!

        let l:filtPosition = winsaveview()
        if line('.') == line('$')
            let l:gotoEnd = 1
        else
            call s:Log("  cursor moved, stop tail update.")
            let l:gotoEnd = 0
            let l:stopUpdate = 1
        endif

        " Paste new lines at the end of the orginal file.
        silent normal G
        silent put = l:filtLines
        " Delete empty extra line between old and new content.
        call winrestview(l:filtPosition)
        silent normal dd
        call s:Log("  Filt:".expand("%")." lines:".line("$"))

        if l:gotoEnd == 1
            silent normal G
        endif
    endwhile

    " Goto the main highlighted window
    call win_gotoid(s:HiTailSavedWinnr)

    if exists("l:lastWinnr")
        " Return postion to the last we were
        " In case we changed to another window/buffer
        call win_gotoid(l:lastWinnr)
        call winrestview(l:lastPosition)
    endif

    if exists("l:endMessage")
        echo l:endMessage
    endif

    if s:HiTailLog == 1
        call s:Log("Tai#ReloadCallback end ".s:HiTailNum)
        call s:Log("")
        call s:Log("--------------------------------------------------------")
    endif

    if s:HiTailLogTimes == 1
        let s:HiTimeDisplay = localtime() - s:HiTime2
        let s:HiTimeTotal = localtime() - s:HiTime0
        call s:LogTime("Run".s:HiTailNum." times Sync:".s:HiTimeScript." Display:".s:HiTimeDisplay." Total:".s:HiTimeTotal."")
    endif

    if l:stopUpdate == 1
        call s:Log("Tai#ReloadCallback stop update!")
        call s:stopTailUpdate()
    endif
endfunction


function! s:stopTailUpdate()
    call s:Log("")
    call s:Log("stopTailUpdate")

    "if exists("s:HiTailFile")
        "echo "Hi plugin. STOP tail (".s:HiTailNum.") ".s:HiTailFile
    echo "Hi plugin. STOP tail (".s:HiTailNum.") "
    call timer_stopall()
    call s:Log("  stop timer")
    "endif

    silent! unlet s:HiTailFile
    silent! unlet s:HiTailTimerTimeMsec
    silent! unlet s:HiTailFiltCmdList
    silent! unlet s:HiTailSavedWinnr
    silent! unlet s:HiTailSavedPosition
    silent! unlet s:HiTailNum
    call s:Log("stopTailUpdate end")

    "call hi#tail#GetLog()
    "call hi#tail#GetTimeLog()
endfunction


" Get the filter command applied.
" Return: list of ag or grep filter command for each filter window, "" when filter command is not found.
function! s:GetFiltWindowCmd()
    call s:Log(" GetFiltWindowCmd")
    let winNr = win_getid()
    let l:pos = winsaveview()
    let l:filtCmd = []

    " Parent window exists
    if !hi#windowFamily#GotoParent()
        " I'm on a son windoww
        " Go to first parent window.
        while !hi#windowFamily#GotoParent() | endwhile
    endif

    let n = 1
    while hi#windowFamily#GotoFirstSon() == 0
        if exists("w:HiFiltCmdExt")
            let l:filtCmd += [ w:HiFiltCmdExt ]
            call s:Log(" GetFiltWindowCmd".l:n.": ".w:HiFiltCmdExt)
        else
            let l:filtCmd += [ "" ]
            call s:Log(" GetFiltWindowCmd".l:n.": empty")
        endif
        let n += 1
        silent normal G
    endwhile

    call win_gotoid(l:winNr)
    call winrestview(l:pos)

    call s:Log(" GetFiltWindowCmd: end")
    return l:filtCmd
endfunction



" Start/Stop tail updating for current file.
" Reload file periodically.
" Arg1: seconds, timer time to launch the refresh.
"  If seconds empty, launch only once.
"  If seconds == 0, update instantly without wait time.
"  If seconds > 0, wait time before update again.
" Return: 0 on success, 1 on error.
" Command: Hiut
function! hi#tail#Run(seconds)
    call s:Log("Tail#Run ")

    if (v:version < 800)
         call hi#log#Error("Vim version 8.0 needed for this functionality.")
        return 1
    endif

    if (v:version < 800 || !has("timers"))
        " +timers option needed for timer_start, timer_end functions.
        call hi#log#Error("+timers functionality not found. Compile vim with +timers setting active.")
        return 1
    endif

    if (v:version < 800 || !has("job"))
        " +job option needed for job_start, job_stop, job_status functions.
        call hi#log#Error("+job functionality not found. Compile vim with +job setting active.")
        return 1
    endif

    if !exists("g:VimJobsLoaded")
        call hi#log#Error("Plugin jobs.vim not loaded.")
        return 1
    endif

    if !executable('rsync')
        call hi#log#Error("rsync binary not found.")
        return 1
    endif

    if !executable('diff')
        call hi#log#Error("diff binary not found.")
        return 1
    endif


    if a:seconds == "?"
        if exists("s:HiTailFile") && s:HiTailFile != ""
            echo "Hi plugin. Update tail on: ".s:HiTailFile." ON, executed:".s:HiTailNum
        else
            echo "Hi plugin. Update tail OFF"
        endif
        return
    endif

    if exists("s:HiTailFile")
        echo "Hi plugin. STOP tail update (".s:HiTailNum.") ".s:HiTailFile
        call timer_stopall()
        let l:HiTailFile = s:HiTailFile
        unlet s:HiTailFile
        call s:Log("Tail#Run stop")
        if a:seconds == "" | return | endif
        if l:HiTailFile != expand("%") | return | endif
    endif

    call hi#windowFamily#GotoFirstParentWindow()
    let s:HiTailFile = expand("%")
    let s:HiTailNum = 0

    " Get the filter cmd used on the filter window.
    let s:HiTailFiltCmdList = s:GetFiltWindowCmd()
    let s:HiTailSavedWinnr = win_getid()
    let s:HiTailSavedPosition = winsaveview()

    " Move cursor position to file en parent and every filter windows.
    silent normal G
    if hi#windowFamily#GotoFirstSon() == 0
        silent normal G
    endif
    call hi#windowFamily#GotoFirstParentWindow()

    call s:LogTime("--------------------------------------------")
    call s:LogTime(s:HiTailFile)

    redraw
    if a:seconds == ""
        call s:Log("Tail#Run once")
        echo "Hi plugin. Launch tail update once"
        silent! unlet s:HiTailTimerTimeMsec
        call hi#tail#Reload("")
        unlet s:HiTailFile
    else
        let l:seconds = str2nr(a:seconds)
        if l:seconds == 0
            echo "Hi plugin. LAUNCH tail update continuouly"
        else
            echo "Hi plugin. LAUNCH tail update every ".l:seconds."sec"
        endif

        call s:Log("Tail#Run periodic seconds:".l:seconds)
        let s:HiTailTimerTimeMsec = l:seconds * 1000
        call s:Log("Tail#Run periodic mili seconds:".s:HiTailTimerTimeMsec)
        call timer_start(s:HiTailTimerTimeMsec, 'hi#tail#Reload', {'repeat':-1})
    endif
    call s:Log("Tail#Run end")
    call s:Log("")
    return 0
endfunction


"- initializations ------------------------------------------------------------

" Debug: the execution.
let  s:HiTailLog = 0

" Debug: the execution time.
let  s:HiTailLogTimes = 1

let  s:plugin_path = expand('<sfile>:p:h')

