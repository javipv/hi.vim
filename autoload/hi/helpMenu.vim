" Script Name: hi/helpMenu.vim
 "Description: 
"
" Copyright:   (C) 2023 Javier Puigdevall
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Puigdevall <javierpuigdevall@gmail.com>
" Contributors:
"
" Dependencies:
"
"

"- functions -------------------------------------------------------------------


" Open a menu and select a hi.vim command to launch.
" Cmd: Hi
function! hi#helpMenu#LaunchCommandMenu(...)
    let l:cmdList = []

    if a:0 >= 1
        let l:filter = a:1
    else
        let l:filter = ""
    endif

    let l:cmdList += [ "!== Highlight types == " ]
    let l:cmdList += [ "!== Load configuration type == " ]
    let l:cmdList += [ "Hit  [TYPE_NAME]      : types, apply selected highlight" ]
    let l:cmdList += [ "Hitf TYPE_NAME FILE   : types, apply selected highlight from file" ]
    let l:cmdList += [ "Hil  [FILE_NAME]      : types, load a configuration file" ]
    let l:cmdList += [ "Hia                   : types, apply auto-config line if found on file header or tail" ]

    let l:cmdList += [ "!== Save configuration type == " ]
    let l:cmdList += [ "Hicfg                 : open all highlight configuration files" ]
    let l:cmdList += [ "Hisv [TYPE_NAME]      : save current highlight configuration" ]
    let l:cmdList += [ "Hifsv [TYPE_NAME]     : force save current highlight configuration" ]

    let l:cmdList += [ "!== Color help: " ]
    let l:cmdList += [ "Hicol [all/COLOR]     : color help, show highlighting color names" ]
    let l:cmdList += [ "Hiid  [all/COLOR_ID]  : color help, show highlighting color IDs" ]

    let l:cmdList += [ "!== Highlight commands: " ]
    let l:cmdList += [ "Hic PATTERN  COLOR_ID : colorize, apply color highlight" ]
    let l:cmdList += [ "Hirm                  : colorize, open selection menu to remove a highlight pattern" ]
    let l:cmdList += [ "Hiu                   : colorize, undo last highlight" ]
    let l:cmdList += [ "Hish                  : colorize, show highlight applied on current file" ]
    let l:cmdList += [ "Hishp                 : colorize, show highlight patterns" ]
    let l:cmdList += [ "Hicrm [COLOR_ID]      : colorize, remove all pattern highlighted with COLOR_ID. Remove all if no argument provided" ]

    let l:cmdList += [ "!== Config Editor commands: " ]
    let l:cmdList += [ "Hie                   : editor, open config editor window" ]
    let l:cmdList += [ "Hier                  : editor, apply config editor changes" ]
    let l:cmdList += [ "Hiet [TYPE_NAME]      : editor, select a config type and open it on the editor window." ]

    let l:cmdList += [ "!== Highlight search: " ]
    let l:cmdList += [ "Hics [COLOR_ID/PATTERN] : search all patterns highlighted with COLOR_ID or pattern. " ]
    let l:cmdList += [ "                              Search all COLOR_IDs if no argument provided" ]

    let l:cmdList += [ "!== Folding: " ]
    let l:cmdList += [ "Hifold [COLOR_ID]     : fold, perform fold, show only lines with highlighting" ]
    let l:cmdList += [ "Hifoldsh              : fold, show folding patterns" ]

    let l:cmdList += [ "!== Filter window: " ]
    let l:cmdList += [ "Hif                   : filter, open all lines containing any highlights on a new split (child)" ]
    let l:cmdList += [ "Hifs                  : filter, open all lines containing any highlights on a new horizontal split (child)" ]
    let l:cmdList += [ "Hifv                  : filter, open all lines containing any highlights on a new vertical split (child)" ]
    let l:cmdList += [ "Hift                  : filter, open all lines containing any highlights on a new tab (child)" ]
    let l:cmdList += [ "Hifn                  : filter, open all lines containing any highlights on a new buffer (child)" ]
    let l:cmdList += [ "Hifw                  : filter, open all lines containing any highlights on the current window" ]
    let l:cmdList += [ "HifC                  : filter, close all filter windows" ]
    let l:cmdList += [ "Hisy                  : filter, synchronize filter window data and position (sync father and child positions)" ]
    let l:cmdList += [ "!== Filter window position: " ]
    let l:cmdList += [ "Hip                   : synchcronize position" ]
    let l:cmdList += [ "Hips                  : synchonize position and switch window" ]
    let l:cmdList += [ "Hipsa                 : enable position auto synchonize" ]
    let l:cmdList += [ "Hipsn                 : disable position auto synchonize" ]
    let l:cmdList += [ "!== Filter window data: " ]
    let l:cmdList += [ "Hid                   : sychcronize data changes (sync child data to parent data)" ]
    let l:cmdList += [ "Hidsa                 : enable data change auto synchonize" ]
    let l:cmdList += [ "Hidsn                 : disable data changes auto synchonize" ]

    let l:cmdList += [ "Hiup                  : reload parent and update child buffer contents" ]

    let l:cmdList += [ "!== Update tail: " ]
    let l:cmdList += [ "Hiupt [SECONDS]       : start/stop (tail -f mode like) the refresh of the main and filter window" ]

    let l:cmdList += [ "!== Others:" ]
    let l:cmdList += [ "Hir                   : refresh all highlightings" ]
    let l:cmdList += [ "Hioff                 : disable all highlightings" ]
    let l:cmdList += [ "Hion                  : disable all highlightings" ]
    let l:cmdList += [ "Hiwoff                : disable current window highlightings" ]
    let l:cmdList += [ "Hiwon                 : disable current window highlightings" ]
    let l:cmdList += [ "Hiy                   : Copy the highlight config into std register" ]
    let l:cmdList += [ "Hiut [SECONDS]        : Start/stop tail mode, periodic reload" ]
    let l:cmdList += [ "Hiv LEVEL             : show debug traces" ]
    let l:cmdList += [ "Hih                   : show command abridged help" ]

    let l:searchStr = ""

    " Filter commands to be displayed:
    if l:filter != ""
        let l:cmdFilterList = []

        for l:cmd in l:cmdList
            for l:filt in split(l:filter)
                if matchstr(l:cmd, l:filt) != ""
                    let l:cmdFilterList += [ l:cmd ]
                endif
            endfor
        endfor

        " Search the filter words on screen.
        for l:filt in split(l:filter)
            if l:searchStr != ""
                let l:searchStr .= "\\\|"
            endif
            let l:searchStr .= l:filt
        endfor
    else
        let l:cmdFilterList = l:cmdList
    endif

    let l:header = [ "[hi.vim] Select command:" ]
    let l:callback = "hi#helpMenu#LaunchCommand"

    call hi#menu#SelectWindowPosition(1)
    call hi#menu#AddCommentLineColor("!", "w4*")
    call hi#menu#ShowLineNumbers("no")
    call hi#menu#OpenMenu(l:header, l:cmdFilterList, l:callback, "")

    " Use Search command to highlight the filter strings.
    if l:searchStr != ""
        let @/ = l:searchStr
        execute "normal /\<cr>"

        let l:n = 0
        " search(pattern, W:do not wrap to the start, 0:end line not set, 200msec timeout).
        while search(l:searchStr, 'W', 0, 200) != 0
            let l:n += 1
        endwhile
        silent! normal ggn
        redraw
        echo "[hi.vim] Hi ".l:filter.". Found ".l:n." matches."
    endif
endfunction


function! hi#helpMenu#LaunchCommand(cmd)
    redraw
    "echom "Cmd: ".a:cmd

    if a:cmd == ""
        call hi#log#Error("[hi.vim] No command selected")
        return
    endif

    let l:list = split(a:cmd)
    let l:cmd = ":".l:list[0]

    if l:cmd == ""
        call hi#log#Error("[hi.vim] Empty command")
        return
    endif

    echo l:cmd
    exec(l:cmd)
endfunction


