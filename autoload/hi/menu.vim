" Script Name: hi/menu.vim
 "Description: 
"
" Copyright:   (C) 2022-2023 Javier Puigdevall
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Puigdevall <javierpuigdevall@gmail.com>
" Contributors:
"
" Dependencies:
"
"

"- functions -------------------------------------------------------------------


" Open menu to manage a selection list.
" Arg1: menu header to be displayed, not selectable.
" Arg2: list of selectable options.
" Arg3: callback to be called, expected function is: callbackName(selectedOption).
" Arg4: default text to be selected, place cursor on line matching this text.
function! hi#menu#OpenMenu(headerList, optionsList, callbackFunction, selectText)

    let s:hiMenuList = a:optionsList
    let s:hiMenuCallback = a:callbackFunction
    let s:hiHeaderLines = len(a:headerList)
    let s:hiMenuReturnWinNr = win_getid()

    if s:hiMenuforceWindowPos != ""
        let w:winSize = winheight(0)
        let w:split = s:hiMenuforceWindowPos
        "echom "hi#menu#OpenMenu w:split:".w:split
        call hi#utils#WindowSplit()
    else
        if s:hiMenuDefaultWindowPos != ""
            call hi#utils#WindowSplitMenu(s:hiMenuDefaultWindowPos)
            call hi#utils#WindowSplit()
        else
            let w:winSize = winheight(0)
            silent new
        endif
    endif

    "----------------------------------
    " Write down each header lines:
    "----------------------------------
    if a:headerList != []
        for l:line in a:headerList
            silent put = l:line

            if exists('g:HiLoaded')
                let l:colorId = ""

                if g:hi_menu_headerColor != ""
                    let l:colorId = g:hi_menu_headerColor
                endif

                if s:hiMenuHeaderColor != ""
                    let l:colorId = s:hiMenuHeaderColor
                endif

                " Colorize header lines.
                if l:line != "" && l:colorId != ""
                    let l:text = substitute(l:line, '[', '\\[', "g")

                    let g:HiCheckPatternAvailable = 0
                    silent! call hi#config#PatternColorize(l:text, l:colorId)
                    let g:HiCheckPatternAvailable = 1
                endif
            endif
        endfor
        let s:hiMenuHeaderColor = ""
    else
        silent put = "Select option:"
    endif

    let l:pos = s:hiHeaderLines + 1
    "let i = 0
    let i = 1
    let n = s:hiMenuDefaultFirstNumber

    "----------------------------------
    " Write down each menu line:
    "----------------------------------
    let l:defaultLineText = ""

    for l:line in a:optionsList
        let isComment = "no"

        " Check if line is a comment:
        for l:list in s:hiMenuCommentsList
            if matchstr(l:line, "^".l:list[0]) != ""
                " Remove comment word.
                let l:line = substitute(l:line, "^".l:list[0], "", "")

                let isComment = "yes"
                break
            endif
        endfor

        "silent put = l:line
        "let i += 1

        if l:isComment == "yes"
            " Apply comment color:
            if exists('g:HiLoaded')
                let g:HiCheckPatternAvailable = 0
                silent! call hi#config#PatternColorize(l:line, l:list[1])
                let g:HiCheckPatternAvailable = 1
            endif
        else
            if s:hiMenuShowLineNumbers == "yes"
                " Check if curren option is the default one.
                if l:line == a:selectText
                    let l:pos = l:i + s:hiHeaderLines
                    let l:line = "> ".l:n.") ".l:line
                    let l:defaultLineText = l:line
                else
                    let l:line = "  ".l:n.") ".l:line
                endif

                let s:hiMenuShowLineNumbers = "yes"
                let i += 1
                let n += 1
            endif
        endif

        silent put = l:line
    endfor

    "----------------------------------
    " Change window properties and title
    "----------------------------------
    silent normal ggdd
    setl nowrap
    set buflisted
    set bufhidden=delete
    set buftype=nofile
    setl noswapfile
    set cursorline
    setl nomodifiable
    silent! exec '0file | file _hi_menu_'

    " On horizontal split. Move window to bottom
    if s:hiMenuDefaultWindowPos != ""
        if exists("w:split")
            if w:split == "1" || w:split == "horizontal"
                wincmd J
            endif
        endif
    endif

    "----------------------------------
    " Resize window depending on content.
    "----------------------------------
    if s:hiMenuDefaultWindowPos != "" || s:hiMenuforceWindowPos != ""
        call hi#utils#WindowSplitEnd()
    else
        if exists("g:hi_menu_maxLines")
            if l:i < g:hi_menu_maxLines
                let l:n = l:i + 2
                silent exe "resize ".l:n
                "echom "silent exe resize ".l:n
            else
                silent exe "resize ".g:hi_menu_maxLines
                "echom "resize ".g:hi_menu_maxLines
            endif
        endif
    endif

    "----------------------------------
    " Colorize default selected line.
    "----------------------------------
    let l:colors = g:hi_menu_defaultLineColor.s:hiMenuDefaultLineColor

    if exists('g:HiLoaded') && l:colors != "" && l:defaultLineText != ""
        let l:colorId = ""

        if g:hi_menu_defaultLineColor != ""
            let l:colorId = g:hi_menu_defaultLineColor
        endif

        if s:hiMenuDefaultLineColor != ""
            let l:color = s:hiMenuDefaultLineColor
        endif

        if l:defaultLineText != "" && l:colorId != ""
            "let l:line = getline(".")
            let l:text = substitute(l:defaultLineText, '[', '\\[', "g")

            let g:HiCheckPatternAvailable = 0
            silent! call hi#config#PatternColorize(l:text, l:colorId)
            let g:HiCheckPatternAvailable = 1
        endif

        let s:hiMenuDefaultLineColor = ""
    endif

    "----------------------------------
    " Colorize special patterns.
    "----------------------------------
    if exists('g:HiLoaded')
        for l:config in s:hiMenuColorList
            let l:list = split(l:config)
            let l:pattern = l:list[0]
            let l:color = l:list[1]

            if l:pattern != "" && l:color != ""
                let g:HiCheckPatternAvailable = 0
                silent! call hi#config#PatternColorize(l:pattern, l:color)
                let g:HiCheckPatternAvailable = 1
            endif
        endfor
        let s:hiMenuColorList = []
    endif

    if exists('g:HiLoaded')
        silent! call hi#hi#Refresh()
    endif

    "----------------------------------
    " Highlight using search highlight the default selected line.
    "----------------------------------
    if g:hi_menu_highlightDefaultLine == "yes" || s:hiMenuHighlightDefaultLine == "yes"
        let l:line = getline(".")
        "let l:pattern = "^".l:line."$"
        let l:pattern = l:line

        silent! call search(l:pattern, 'W', 0, 500)
        let @/=l:pattern
        silent! hlsearch
        silent! normal n

        let s:hiMenuHighlightDefaultLine = "no"
    endif

    silent call s:MapKeys()

    augroup hiMenuAutoCmd
        silent autocmd!
        silent exec "silent autocmd! winleave _hi_menu_ call hi#menu#UnmapKeysAndQuit()"
    augroup END

    "----------------------------------
    " Position cursor on default line.
    "----------------------------------
    silent exe "normal gg".l:pos."G"
endfunction


" Choose the color for the first lines before menu fields (header)
" Arg1: color. Plugin hi.vim colors: r, g, b, m, r@...
function! hi#menu#SetHeaderColor(color)
    let s:hiMenuHeaderColor = a:color
endfunction


" Choose the color for the selected menu.
" Arg1: color. Plugin hi.vim colors: r, g, b, m, r@...
function! hi#menu#SetDefaultLineColor(color)
    let s:hiMenuDefaultLineColor = a:color
endfunction

" Choose whether to highlight the current line selected.
" Arg1: state. yes/no.
function! hi#menu#SetHighlightDefaultLine(state)
    let s:hiMenuHighlightDefaultLine = a:state
endfunction

" Colorize a pattern on the menu window comments.
" Arg1: word. Pattern to be highlighted.
" Arg2: color. Plugin hi.vim colors: r, g, b, m, r@...
function! hi#menu#AddCommentLineColor(word, color)
    let s:hiMenuCommentsList += [[ a:word, a:color ]]
endfunction


" Colorize a pattern on the menu window selectable fields.
" Arg1: word. Pattern to be highlighted.
" Arg2: color. Plugin hi.vim colors: r, g, b, m, r@...
function! hi#menu#AddPatternColor(pattern, color)
    let s:hiMenuColorList += [ a:pattern." ".a:color ]
endfunction


" Choose whether to display numbers before each menu field.
" Arg1: status, yes/no.
function! hi#menu#ShowLineNumbers(status)
    let s:hiMenuShowLineNumbers = a:status
endfunction


" Select window default position when asking user to split new, vertical...
" Arg1: defaultWindowPos, 1 for new split, 2, for vertical split, 3 for tab, " 4. Also:
" "horizontal" for new split, "vertical" for vertical split, "tab" for new tab and  "this"
" for current window.
function! hi#menu#SelectWindowPosition(defaultWindowPos)
    let s:hiMenuDefaultWindowPos = a:defaultWindowPos
endfunction


" Force window position, do not ask user wheter to open on new split, vertical split, tab...
" Arg1: defaultWindowPos, 1 for new split, 2, for vertical split, 3 for tab, " 4. Also:
" "horizontal" for new split, "vertical" for vertical split, "tab" for new tab and  "this"
" for current window.
function! hi#menu#ForceWindowPosition(forceWindowPos)
    let s:hiMenuforceWindowPos = a:forceWindowPos
endfunction


" When adding numbers on each menu field, select the first number to be used.
" Arg1: number, usually 0 or 1.
function! hi#menu#FirstNumber(number)
    let s:hiMenuDefaultFirstNumber = a:number
endfunction


" Select option.
function! hi#menu#Select()
    "echom "hi#menu#Select()"
    redraw

    if line(".") <= s:hiHeaderLines
        call hi#log#Warn("Line not selectable")
        return
    endif

    let l:pos = line(".") - s:hiHeaderLines - 1

    let l:text = s:hiMenuList[l:pos]
    "let l:text = l:text[]

    for l:list in s:hiMenuCommentsList
        if l:text =~ l:list[0]
            call hi#log#Warn("Line not selectable")
            return
        endif
    endfor

    if l:text == ""
        call hi#log#Warn("Empty line")
        return
    endif

    let l:callback = s:hiMenuCallback

    silent call hi#menu#UnmapKeysAndQuit()

    "echom "hi#menu#Select() call ".l:callback."(\"".l:text."\")"
    exec("call ".l:callback."(\"".l:text."\")")
endfunction


function! s:MapKeys()
    "echom "s:MapKeys()"
    silent! nmap <ENTER> :call hi#menu#Select()<CR>
    silent! nmap q       :call hi#menu#UnmapKeysAndQuit()<CR>
endfunction


function! s:UnmapKeys()
    "echom "s:UnmapKeys()"
    silent! nunmap <ENTER>
    silent! nunmap q
endfunction


function! hi#menu#UnmapKeysAndQuit()
    "echom "hi#menu#UnmapKeysAndQuit()"

    if expand("%") == "_hi_menu_"
        "echom "hi#menu#UnmapKeysAndQuit() quit"
        call s:UnmapKeys()
        silent! quit!
    endif

    let s:hiMenuCommentsList = []
    let s:hiMenuDefaultWindowPos = ""
    let s:hiMenuDefaultFirstNumber = 1
    let s:hiMenuforceWindowPos = ""
    redraw

    " Return to the original window.
    call win_gotoid(s:hiMenuReturnWinNr)
endfunction

"call hi#menu#Open("Select branch", ["branch 1", "branch 2"], "hi#menu#Test")
"call hi#menu#Test("branch 2")
"function! hi#menu#Test(text)
    "echom "hi#menu#Test(".a:text.")"
    "call confirm("callback: ".a:text)
"endfunction


"- variables -------------------------------------------------------------------

let s:hiMenuCommentsList = []
"let s:hiMenuHeaderColor = "b*"
"let s:hiMenuDefaultLineColor = "y*"
let s:hiMenuHeaderColor = ""
let s:hiMenuDefaultLineColor = ""
let s:hiMenuHighlightDefaultLine = "no" " yes/no
let s:hiMenuColorList = []
let s:hiMenuShowLineNumbers = "yes"
let s:hiMenuDefaultWindowPos = ""
let s:hiMenuDefaultFirstNumber = 1
let s:hiMenuforceWindowPos = ""

