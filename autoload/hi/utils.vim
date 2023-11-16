" Script Name: hi/utils.vim
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


" Conceal any ANSI Escape sequence characters
function! hi#utils#ConcealEscSeq()
    if g:HiConcealAnsiEscSeq == 1
        exec("syn match AnsiEscSeqCol /\\\\[[0-9;]*m/ conceal cchar=>")
        exec("syn match AnsiEscSeqK   /\\\\[K/ conceal cchar=<")
        exec("syn match AnsiEscSeqEnd /\\\\[0m/ conceal cchar=<")
        set conceallevel=3
        set concealcursor=vnc
        set nocursorline
    endif
endfunction


" Return: 0 not found, 1 found.
func! s:Search(line)
    let l:res = 1
    " Get current position
    let ypos = getpos(".")
    let xpos = col('.')

    call hi#log#Verbose(1, expand('<sfile>'), "Search: '".a:line."'")

    if search(a:line)
        call hi#log#Verbose(2, expand('<sfile>'), "Found")
    else
        "" Restore previous position
        silent call setpos('.', l:ypos)
        silent exec("normal 0".l:xpos."l")
        call hi#log#Verbose(2, expand('<sfile>'), "Not found")
        let l:res = 0
    endif

    return l:res
endfunction


" Search for first match of a:line string on current buffer
" Return: 0 not found, 1 found.
func! hi#utils#SearchLine(line)
    let l:line = escape(a:line, '.[*/')
    call hi#log#Verbose(1, expand('<sfile>'), "Search: '".l:line."'")

    " Save current search command
    silent let searchCmd = @/

    " Search from previous line downwards
    call hi#log#Verbose(2, expand('<sfile>'), "Position prev line")
    silent normal k
    let l:res = s:Search(l:line)
    let l:res = 0

    if l:res == 0
        " Previous search failed.
        " Search from first line downwards.
        call hi#log#Verbose(2, expand('<sfile>'), "Position first line")
        silent normal gg
        let l:res = s:Search(l:line)
    endif

    "" Restore last search command
    silent let @/ = l:searchCmd
    return l:res
endfunc


" Remove leading and trailing spaces.
" Remove end of line characters.
" Return: string without leading trailing white spaces.
func! hi#utils#TrimString(string)
    let l:tmp = a:string
    let l:tmp = substitute(l:tmp,'^\s\+','','g')
    let l:tmp = substitute(l:tmp,'\s\+$','','g')
    let l:tmp = substitute(l:tmp,'','','g')
    let l:tmp = substitute(l:tmp,'\n','','g')
    return l:tmp
endfunc


" Enclose the given lines on list on a rectangle.
" Arg1: linesList, list with every line to be enclosed inside the rectangle.
" Arg2: rectangleType, bold, hashtag, equals, normal.
"       Bold:    ┏━━━━━━━┓
"                ┃       ┃
"                ┗━━━━━━━┛
"       Hashtag: #########
"                #       #
"                #########
"       Equals:  =========
"                ||     ||
"                =========
"       Normal:  ┌───────┐
"                │       │
"                └───────┘
" Arg3: [OPTIONAL] len, force minimum rectangle length to this value.
" Return: string with the text enclosed on rectangle.
function! hi#utils#EncloseOnRectangle(linesList,rectangleType,len)
    if a:rectangleType == "bold"
        let l:cornerTL='┏' | let l:cornerTR='┓' | let l:vertical='┃' | let l:horizontal='━' | let l:cornerBL='┗' | let l:cornerBR='┛'
    elseif a:rectangleType == "hashtag"
        let l:cornerTL='#' | let l:cornerTR='#' | let l:vertical='#' | let l:horizontal='#' | let l:cornerBL='#' | let l:cornerBR='#'
    elseif a:rectangleType == "equals"
        let l:cornerTL='=' | let l:cornerTR='=' | let l:vertical='||' | let l:horizontal='=' | let l:cornerBL='=' | let l:cornerBR='='
    else
        let l:cornerTL="┌" | let l:cornerTR="┐" | let l:vertical="│" | let l:horizontal='─' | let l:cornerBL='└' | let l:cornerBR='┘'
    endif

    if a:len != ""
        let maxlen = a:len
    else
        let maxlen = 0
        for line in a:linesList
            let len = strlen(l:line)
            if l:len > l:maxlen | let l:maxlen = l:len | endif
        endfor
    endif

    let config  = l:cornerTL
    let config .= repeat(l:horizontal,l:maxlen)
    let config .= l:cornerTR."\n"

    for line in a:linesList
        let config .= l:vertical.l:line
        let len = l:maxlen - strlen(l:line)
        let config .= repeat(' ', l:len)
        let config .= l:vertical."\n"
    endfor

    let config .= l:cornerBL
    let config .= repeat(l:horizontal,l:maxlen)
    let config .= l:cornerBR."\n"

    return l:config
endfunction


function! hi#utils#WindowSplitMenu(default)
    let w:winSize = winheight(0)
    let text =  "split hor&izontal\n&split vertical\nnew &tab\ncurrent &window"
    let w:split = confirm("", l:text, a:default)
    redraw
endfunction


function! hi#utils#WindowSplit()
    if !exists('w:split')
        return
    endif

    let l:split = w:split
    let l:winSize = w:winSize

    if w:split == 1 || w:split == "horizontal"
        let l:cmd = "sp! | enew"
    elseif w:split == 2 || w:split == "vertical"
        let l:cmd = "vnew"
    elseif w:split == 3 || w:split == "tab"
        let l:cmd = "tabnew"
    elseif w:split == 4 || w:split == "this"
        let l:cmd = "enew"
    endif

    silent exec(l:cmd)

    let w:split = l:split
    let w:winSize = l:winSize - 2
endfunction


function! hi#utils#WindowSplitEnd()
    if exists('w:split')
        if w:split == 1
            if exists('w:winSize')
                let lines = line('$')
                if l:lines <= w:winSize
                    echo "resize ".l:lines
                    exe "resize ".l:lines
                else
                    exe "resize ".w:winSize
                endif
            endif
            exe "normal! gg"
        endif
    endif
    silent! unlet w:winSize
    silent! unlet w:split
endfunction




"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
