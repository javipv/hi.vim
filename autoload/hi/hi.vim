" Script Name: hi/hi.vim
" Description: Highlight text patterns in different colors.
"   Allows to save, reload and modify the highlighting configuration.
"   Allows to filter by color the lines and show then on a new split/tab.
"
" Copyright:   (C) 2017-2020 Javier Puigdevall
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Puigdevall <javierpuigdevall@gmail.com>
" Contributors:


if !exists('g:HiLoaded')
    finish
endif


"- functions -------------------------------------------------------------------


" Get the plugin reload command
function! hi#hi#Reload()
    let l:pluginPath = substitute(g:HiPluginPath, "autoload".g:HiDirSep."hi", "plugin", "")
    let s:initialized = 0
    let l:cmd  = ""
    let l:cmd .= "unlet g:HiLoaded "
    let l:cmd .= " | so ".l:pluginPath.g:HiDirSep."hi.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."autoConfig.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."colors.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."config.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."config2.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."configEditor.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."configTypes.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."configTypes2.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."fileConfig.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."filter.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."filterSynch.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."fold.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."help.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."helpMenu.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."hi.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."log.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."menu.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."tail.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."test.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."utils.vim"
    let l:cmd .= " | so ".g:HiPluginPath.g:HiDirSep."windowFamily.vim"
    return l:cmd
endfunction


" Edit plugin files
function! hi#hi#Edit()
    let l:plugin = substitute(s:plugin_path, "autoload/hi", "plugin", "")
    silent exec("tabnew ".s:plugin)
    silent exec("vnew   ".l:plugin."/".s:plugin_name)
endfunction


" Init
function! hi#hi#Initialize()
    if exists("s:initialized")
        return
    endif

    call hi#log#Verbose(1, expand('<sfile>'), "Hi vim version: ".g:HiVersion)

    let g:HiPlugin = s:plugin
    let g:HiPluginPath = s:plugin_path
    let g:HiPluginName = s:plugin_name

    let g:HiLogLevel = 0
    "let g:HiLogLevel = 4

    let g:HiPredefinedTypesList = []
    let g:HicolorhelpOmittColors   = "bold, underline, background, top, non-filter"
    let g:HiIdHelpColorIdHelpOmitt = "! _ @ ^ -"
    let g:HicolorhelpModifiers   = "!(bold), _(underline), @(background), ^(highlight on top), -(skip filter), *(all line), &(region)"

    if hi#config#Reload() != 0
        call hi#log#Error("Color definition error")
        unlet g:HiLoaded
        return
    endif

    if g:HiAwkFilter != 0
        if !executable('awk')
            "echo "Disabling awk based filter tools."
            "echo "Region filter not allowed."
            "call hi#log#Error("awk not found."e
            let g:HiAwkFilter = 0
        endif
    endif

    if g:HiAgGrepFilter != 0
        if !executable('ag') && !executable('grep')
            "echo "Disabling ag and grep based filter tools."
            call hi#log#Error("ag and grep not found.")
            let g:HiAgGrepFilter = 0
        endif
    endif

    let s:initialized = 1
endfunction


" Highlight match pattern with selected color
" Open color id help to select the color
" Commands: Hiph
"function! hi#hi#PatternColorHelp(...)
    "call hi#hi#ColorIdHelp("")
    "let colorId = input("select color id: ")
    "if l:colorId == "" | return | endif
    "echo " "

    "let args = a:000
    "let args += [ l:colorId ]
    "call call(function('hi#hi#PatternColorize'), l:args)
"endfunction


" Search the given patterns, or patterns related to the given colorIDs.
" Arg1: searchStr: space separted colorIDs and/or patterns to keep or remove on filter window.
" Command: Hics
function! hi#hi#Search(direction, searchStr)
    let l:separator = "____SEP____"

    let l:patterns = hi#config#GetColorPatterns(a:searchStr,"",l:separator,"searchMode")

    let l:tmp = hi#config#GetNonColorPatterns(a:searchStr,l:separator)
    if l:tmp != ""
        if  l:patterns != "" | let patterns .= l:separator | endif
        let l:patterns .= l:tmp
    endif

    if l:patterns == ""
        call hi#log#Warn("Empty search ".a:searchStr.". Not found")
        return
    endif

    let patterns = substitute(l:patterns, l:separator, '\\|', 'g')

    silent set nohlsearch
    "call search(l:patterns, 'w')
    if a:direction == "fordward"
        silent execute "normal! /".l:patterns."\<CR>"
    else
        silent execute "normal! ?".l:patterns."\<CR>"
    endif
    silent set hlsearch
    let @/ = l:patterns
    normal n
    return 0
endfunction



" Refresh highlighting
" Commands: Hir
function! hi#hi#Refresh()
    " Refresh current window highlight
    call hi#config#Reload()
    call hi#config#SyntaxReload()

    if !exists('w:HiParentsDataList') && !exists('w:HiSonsDataList')
        let initWinNr = win_getid()
        while !hi#windowFamily#GotoParent()
            call hi#config#SyntaxReload()
        endwhile
        call win_gotoid(l:initWinNr)
    endif
    return
endfunction


" Refresh highlighting on all windows of current tab.
" Commands: Hirw
function! hi#hi#RefreshAllWindows()
    " Save window position
    let l:winview = winsaveview()
    " Refresh highlighting
    windo call hi#hi#Refresh()
    " Restore window position
    call winrestview(l:winview)
endfunction


function! hi#hi#getVisualSel()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return escape(join(lines, "\n"),' \')
endfunction


" Create menu items for the specified modes.
function! hi#hi#CreateMenus(modes, submenu, target, desc, cmd)
    " Build up a map command like
    let plug = a:target
    let plug_start = 'noremap <silent> ' . ' :call Hi("'
    let plug_end = '", "' . a:target . '")<cr>'

    " Build up a menu command like
    let menuRoot = get(['', 'Hi', '&Highlight', "&Plugin.&Highlight".a:submenu], 3, '')
    let menu_command = 'menu ' . l:menuRoot . '.' . escape(a:desc, ' ')

    if strlen(a:cmd)
        let menu_command .= '<Tab>' . a:cmd
    endif

    let menu_command .= ' ' . (strlen(a:cmd) ? plug : a:target)
    "let menu_command .= ' ' . (strlen(a:cmd) ? a:target)

    call hi#log#Verbose(1, expand('<sfile>'), l:menu_command)

    " Execute the commands built above for each requested mode.
    for mode in (a:modes == '') ? [''] : split(a:modes, '\zs')
        if strlen(a:cmd)
            execute mode . plug_start . mode . plug_end
            call hi#log#Verbose(1, expand('<sfile>'), "execute ". mode . plug_start . mode . plug_end)
        endif
        " Check if the user wants the menu to be displayed.
        if g:HiMode != 0
            execute mode . menu_command
        endif
    endfor
endfunction


"- Release tools ------------------------------------------------------------
"

" Create a vimball release with the plugin files.
" Commands: Hivba
function! hi#hi#NewVimballRelease()
    let text  = ""
    let text .= "plugin/hi.vim\n"
    let text .= "autoload/hi/autoConfig.vim\n"
    let text .= "autoload/hi/config.vim\n"
    let text .= "autoload/hi/colors.vim\n"
    let text .= "autoload/hi/configEditor.vim\n"
    let text .= "autoload/hi/configTypes.vim\n"
    let text .= "autoload/hi/fileConfig.vim\n"
    let text .= "autoload/hi/filter.vim\n"
    let text .= "autoload/hi/filterSynch.vim\n"
    let text .= "autoload/hi/fold.vim\n"
    let text .= "autoload/hi/help.vim\n"
    let text .= "autoload/hi/helpMenu.vim\n"
    let text .= "autoload/hi/hi.vim\n"
    let text .= "autoload/hi/log.vim\n"
    let text .= "autoload/hi/menu.vim\n"
    let text .= "autoload/hi/tail.vim\n"
    let text .= "autoload/hi/tail.sh\n"
    let text .= "autoload/hi/test.vim\n"
    let text .= "autoload/hi/utils.vim\n"
    let text .= "autoload/hi/windowFamily.vim\n"
    let text .= "colors/hi.vim\n"
    let text .= "colors/hi_off.vim\n"

    silent tabedit
    silent put = l:text
    silent! exec '0file | file vimball_files'
    silent normal ggdd

    let l:plugin_name = substitute(s:plugin_name, ".vim", "", "g")
    let l:releaseName = l:plugin_name."_".g:HiVersion.".vmb"
    "echom "l:releaseName:".l:releaseName

    let l:workingDir = getcwd()
    silent cd ~/.vim
    exec "1,$MkVimball! ".l:releaseName." ./"
    exec "vertical new ".l:releaseName
    silent exec "cd ".l:workingDir
    echo ""
    echom l:releaseName." done"
endfunction




"- initializations ------------------------------------------------------------
"
let  s:plugin = expand('<sfile>')
let  s:plugin_path = expand('<sfile>:p:h')
let  s:plugin_name = expand('<sfile>:t')

call hi#hi#Initialize()

