" Script Name: hi/log.vim
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


" Ask user key to continue when screen is full of logs
function! s:ScrollMessages()
    if !exists("w:HiLogScroll") | return | endif
    if w:HiLogScroll != 1 | return | endif

    " Ask user key to continue when screen is full of logs
    if !exists("w:HiLogLines")
        let w:HiLogLines = 0
    endif
    if !exists("w:HiLogMaxLines")
        let w:HiLogMaxLines = &lines / 2
    endif
    "let l:lines = &lines / 2
    "let l:lines = &lines
    if w:HiLogLines >= w:HiLogMaxLines
        "call input("Press key to continue")
        let w:HiLogLines = 0
        call input("Press key to continue (".w:HiLogLines.")")
        redraw
    endif
    let w:HiLogLines += 1
endfunction


function! s:LogToFile(mssg)
    if !exists("w:HiLogToFile") | return | endif
    if w:HiLogToFile != 1 | return | endif
    redir! >> _vim_hi.log
        echo a:mssg
    redir END
endfunction


function! hi#log#Error(mssg)
    if !exists("g:HiPluginName")
        let g:HiPluginName = ""
    endif

    " Ask user key to continue when logs reach screen limit
    call s:ScrollMessages()

    echohl ErrorMsg | echom "[".g:HiPlugin."] ".a:mssg | echohl None

    call s:LogToFile("[".g:HiPlugin."] ERROR: ".a:mssg)
endfunction


function! hi#log#Warn(mssg)
    " Ask user key to continue when screen is full of logs
    call s:ScrollMessages()
    echohl WarningMsg | echo a:mssg | echohl None
    call s:LogToFile("[".g:HiPlugin."] WARN: ".a:mssg)
endfunction


" Debug function. Log message
function! hi#log#Verbose(level,func,mssg)
    if !exists("g:HiLogLevel")
        let g:HiLogLevel = 0
    endif

    if exists("s:verboseFunctions")
        if s:verboseFunctions !~ a:func
            return
        endif
    endif

    if !exists("g:HiPluginName")
        let g:HiPluginName = ""
    endif

    if g:HiLogLevel >= a:level
        " Ask user key to continue when screen is full of logs
        call s:ScrollMessages()

        if a:mssg == ""
            echom " "
            call s:LogToFile("")
        else
            echom "[".g:HiPluginName." : ".a:func." ] ".a:mssg
            call s:LogToFile("[".g:HiPlugin."] ".a:mssg)
        endif
    endif
endfunction


function! hi#log#VerboseError(level,func,mssg)
    echohl ErrorMsg | call hi#log#Verbose(a:level,a:func,a:mssg) | echohl None
endfunction


function! hi#log#VerboseWarn(level,func,mssg)
    echohl WarningMsg | call hi#log#Verbose(a:level,a:func,a:mssg) | echohl None
endfunction


" Debug function. Log message and wait user key
function! hi#log#VerboseStop(level,func,mssg)
    if !exists("g:HiLogLevel")
        let g:HiLogLevel = 0
    endif
    if exists("s:verboseFunctions")
        if s:verboseFunctions !~ a:func
            return
        endif
    endif
    if !exists("g:HiPluginName")
        let g:HiPluginName = ""
    endif

    if g:HiLogLevel >= a:level
        call input("[".g:HiPluginName." : ".a:func." ] ".a:mssg." (press key)")
        echom printf("\n")
        let w:HiLogLines = 0
    endif
endfunction


function! s:SetVerbose(level)
    if a:level == ""
        echo "Verbosity level: ".g:HiLogLevel
        return
    endif
    if a:level == 0
        let w:HiLogScroll = 0
        let w:HiLogToFile = 0
    endif
    let w:HiLogLines = 0
    let g:HiLogLevel = a:level
    call hi#log#Verbose(0, expand('<sfile>'), "Set verbose level: ".g:HiLogLevel)
endfunction


" Commands: Hiv
function! hi#log#SetVerbose(level)
    let w:HiLogScroll = 1
    let w:HiLogToFile = 0
    let w:HiLogMaxLines = &lines / 2
    let w:HiLogMaxLines = 70
    call s:SetVerbose(a:level)
endfunction


function! hi#log#SetVerboseFile(level)
    let w:HiLogScroll = 0
    let w:HiLogToFile = 1
    call s:SetVerbose(a:level)
endfunction


"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
