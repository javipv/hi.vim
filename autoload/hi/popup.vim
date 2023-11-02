" Script Name: hi/popup.vim
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
"   +timers
"

if !exists('g:HiLoaded')
    finish
endif


"- functions -------------------------------------------------------------------

function! hi#popup#PopupCallback(id, result)
    echo "Popup callback ".a:result
    let id = popup_menu(["item1", "item2", "item3"], #{ callback: 'hi#popup#PopupCallback1', pos: 'topleft' })
    call popup_move(id, #{ line: -1, col: -1 })
endfunction


function! hi#popup#PopupCallback1(id, result)
    echo "Popup callback1 ".a:result
endfunction


" 
function! hi#popup#WaitResult(type, list)
    "echo "Popup and wait result"
    if (v:version < 800)
         call hi#log#Error("Vim version 8.0 needed for this functionality.")
        return 1
    endif

    if (v:version < 800 || !has("timers"))
        " +timers option needed for timer_start, timer_end functions.
        call hi#log#Error("+timers functionality not found. Compile vim with +timers setting active.")
        return 1
    endif

    let id = popup_menu(a:list, #{ callback: 'hi#popup#PopupCallback', pos: 'topleft' })
    "let id = popup_menu(a:list, #{ pos: 'topleft' })
    echo "id:".l:id
    call popup_move(id, #{ line: -1, col: -1 })

endfunction


"- initializations ------------------------------------------------------------

let  s:plugin_path = expand('<sfile>:p:h')
"call hi#popup#WaitResult("", ['menu1', 'menu2', 'menu3'])

