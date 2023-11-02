" Script Name: hi/help.vim
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


" Show all colors defined.
" Command: Hicol
function! hi#help#ColorHelp(filter)
    if !exists("g:HiColorDefinitionList")
        call hi#log#Error("Color definition config not found")
        return
    endif
    redraw

    let omittList = split(g:HicolorhelpOmittColors,' ')
    let filters = a:filter

    " Remove from omitt list any config requested on filter
    let n = 0
    for omitt in l:omittList
        if l:filters =~ l:omitt
            call remove(l:omittList, l:n)
        endif
        let n += 1
    endfor

    let l:colors = g:HiBaseColors
    if l:filters =~ "all"
        "let l:colors = g:HiBaseColors
        let omittList = []
        let filters = substitute(l:filters,'all','','g')
        let filters = substitute(l:filters,'  ','','g')
        let str = "configurations"
    else
        echo "Use argument 'all' to show all available color configurations"
        echo "Color options: ".join(l:omittList)
        echo ""
        let str = "colors"
    endif

    let filters = toupper(l:filters)

    let colorLen = 0
    let colorHelpList = []
    for colorList in g:HiColorDefinitionList
        if l:filters != ""
            let found = 0
            for tmp in split(l:filters,' ')
                if matchstr(l:colorList[4], l:tmp) != ""
                    let found = 1
                    break
                endif
            endfor
            if l:found != 1 | continue | endif
        endif

        let skip = 0
        for omitt in l:omittList
            if l:colorList[4] =~ l:omitt
                let skip = 1
            endif
        endfor
        if l:skip == 1 | continue | endif

        " Add to the list of colors to display
        let colorHelpList += [ l:colorList ]

        " Work out the maximum color name lenght
        let nameLen = len(l:colorList[4])
        if l:nameLen > l:colorLen
            let l:colorLen = l:nameLen
        endif
    endfor

    "let max = winheight(0) - 1
    "let max = &lines *2 / 3
    let max = &lines - 2
    let n = 0
    let j = 0
    for colorList in l:colorHelpList
        if l:n == 0
            let prevColor = substitute(l:colorList[0],"[0-9]",'','g')
        endif

        let baseColor = substitute(l:colorList[0],"[0-9]",'','g')
        if l:baseColor != l:prevColor
            let prevColor = l:baseColor
            if l:j >= l:max
                " scroll screen
                call input("(Press ENTER to continue)")
                redraw
                let j = 0
            else
                echo ""
            endif
            let j += 1
        endif

        " Highlight command don't allow using characters: !"·$%&/()=?¿^*{}[]`+-_.,;:¡
        " Transform characters
        "    Bold modifier      : ! change to B
        "    Background color   : # change to H
        "    Background color   : @ change to H
        "    Underline modifier : _ change to U
        let l:colorName = l:colorList[4]
        let l:color = l:colorList[0]
        let l:color = substitute(l:color,'!','B','')
        let l:color = substitute(l:color,'#','H','')
        let l:color = substitute(l:color,'@','H','')
        let l:color = substitute(l:color,'_','U','')
        let l:color = substitute(l:color,'\^','T','')
        let l:color = substitute(l:color,'\.','B','')

        " Show color name, highlight text
        exec("echohl HiColor".toupper(l:color))
        let format = "%' '-".l:colorLen."s "
        echon  printf(l:format, l:colorName)
        echohl None

        let n += 1
    endfor
    echo l:n." ".l:str." found"
    call hi#config#Reload()
endfunction


" Show all colors defined.
" Command: Hiid
function! hi#help#ColorIdHelp(filter)
    if !exists("g:HiColorDefinitionList")
        call hi#log#Error("Color definition config not found")
        return
    endif
    call hi#help#ColorIdHelp(a:filter)
endfunction


function! hi#help#ColorIdHelp(filter)
    let l:omittList = split(g:HiIdHelpColorIdHelpOmitt,' ')
    let l:filters = a:filter
    let l:text = ""

    " Remove from omitt list any config requested on filter
    let n = 0
    for omitt in l:omittList
        if l:filters =~ l:omitt
            call remove(l:omittList, l:n)
        endif
        let n += 1
    endfor

    let l:colors = g:HiBaseColorIds
    if l:filters =~ "all"
        "let l:colors = g:HiBaseColorIds
        let omittList = []
        let filters = substitute(l:filters,'all','','g')
        let filters = substitute(l:filters,'  ','','g')
        let str = "configurations"
    else
        echo "Use argument 'all' to show all available color configurations"
        "echo "*Config options: ".g:HiIdHelpColorIdHelpOmitt." * & (".g:HicolorhelpOmittColors.", all_line, region)"
        echo "*Color modifiers: ".g:HicolorhelpModifiers
        echo ""
        let str = "colors"
    endif

    let filters = toupper(l:filters)

    let colorLen = 0
    let colorHelpList = []
    let n = 0
    for colorList in g:HiColorDefinitionList
        if l:filters != ""
            let found = 0
            for tmp in split(l:filters,' ')
                if matchstr(l:colorList[0], l:tmp) != ""
                    let found = 1
                    break
                endif
            endfor
            if l:found != 1 | continue | endif
        endif

        let skip = 0
        for omitt in l:omittList
            if l:colorList[0] =~ l:omitt | let skip = 1 | endif
        endfor
        if l:skip == 1 | continue | endif

        " Add to the list of colors to display
        let colorHelpList += [ l:colorList ]

        " Work out the maximum color name lenght
        let nameLen = len(l:colorList[0])
        if l:nameLen > l:colorLen
            let l:colorLen = l:nameLen
        endif
    endfor

    let l:text .= printf("%s"," ")

    "let max = winheight(0) - 1
    let max = &lines - 2
    let n = 0
    let j = 0
    for colorList in l:colorHelpList
        if l:n == 0
            let prevColor = substitute(l:colorList[0],"[0-9]",'','g')
        endif

        let baseColor = substitute(l:colorList[0],"[0-9]",'','g')
        if l:baseColor != l:prevColor
            echo ""
            let l:text .= printf("%s","\n ")
            let prevColor = l:baseColor
            if l:j >= l:max
                " scroll screen
                call input("(Press ENTER to continue)")
                redraw
                let j = 0
            else
                echo ""
            endif
            let j += 1
        endif

        let l:color = l:colorList[0]

        let l:colorId = toupper(l:color)
        let l:colorId = substitute(l:colorId,'!','B','')
        let l:colorId = substitute(l:colorId,'#','H','')
        let l:colorId = substitute(l:colorId,'@','H','')
        let l:colorId = substitute(l:colorId,'_','U','')
        let l:colorId = substitute(l:colorId,'\^','T','')
        let l:colorId = substitute(l:colorId,'\.','B','')

        " Show color name, highlight text
        exec("echohl HiColor".l:colorId)
        let format = "%' '-".l:colorLen."s "
        echon  printf(l:format, l:color)
        let l:text .= printf(l:format, l:color)
        echohl None

        let n += 1
    endfor
    echo l:n." ".l:str." found"
    call hi#config#Reload()

    return l:text
endfunction


function! hi#help#CommandHelp()
    let text =  "[hi.vim] help (v".g:HiVersion.")\n"
    let text .= "  \n"
    let text .= "Abridged command help:\n"
    let text .= "  \n"
    let text .= "- Hihglight types: \n"
    let text .= " * Load: \n"
    let text .= "    :Hit  [TYPE_NAME]      : apply selected highlight\n"
    let text .= "    :Hitf TYPE_NAME FILE   : apply selected highlight from file\n"
    let text .= "    :Hil  [FILE_NAME]      : load a configuration file\n"
    let text .= "    :Hia                   : apply auto-config line if found on file header or tail\n"
    let text .= " * Save                   : \n"
    let text .= "    :Hicfg                 : open all highlight configuration files\n"
    let text .= "    :Hisv [TYPE_NAME]      : save current highlight configuration\n"
    let text .= "    :Hifsv [TYPE_NAME]     : force save current highlight configuration\n"
    let text .= "  \n"
    let text .= "- Color help: \n"
    let text .= "    :Hicol [all/COLOR]     : show highlighting color names\n"
    let text .= "    :Hiid  [all/COLOR_ID]  : show highlighting color IDs\n"
    let text .= "  \n"
    let text .= "- Highlight commands: \n"
    let text .= "    :Hic PATTERN  COLOR_ID : apply color highlight\n"
    let text .= "    :Hirm                  : open selection menu to remove a highlight pattern\n"
    let text .= "    :Hiu                   : undo last highlight\n"
    let text .= "    :Hish                  : show highlight applied on current file\n"
    let text .= "    :Hishp                 : show highlight patterns\n"
    let text .= "    :Hicrm [COLOR_ID]      : remove all pattern highlighted with COLOR_ID. Remove all if no argument provided\n"
    let text .= "  \n"
    let text .= "- Config Editor commands: \n"
    let text .= "    :Hie                   : open config editor window\n"
    let text .= "    :Hier                  : apply config editor changes\n"
    let text .= "    :Hiet [TYPE_NAME]      : select a config type and open it on the editor window.\n"
    let text .= "  \n"
    let text .= "- Highlight search: \n"
    let text .= "    :Hics [COLOR_ID/PATTERN] : search all patterns highlighted with COLOR_ID or pattern. \n"
    let text .= "                              Search all COLOR_IDs if no argument provided\n"
    let text .= "  \n"
    let text .= "- Folding: \n"
    let text .= "    :Hifold [COLOR_ID]     : perform fold, show only lines with highlighting\n"
    let text .= "    :Hifoldsh              : show folding patterns\n"
    let text .= "  \n"
    let text .= "- Filter window: \n"
    let text .= "    :Hif                   : open all lines containing any highlights on a new split (child)\n"
    let text .= "    :Hifs                  : open all lines containing any highlights on a new horizontal split (child)\n"
    let text .= "    :Hifv                  : open all lines containing any highlights on a new vertical split (child)\n"
    let text .= "    :Hift                  : open all lines containing any highlights on a new tab (child)\n"
    let text .= "    :Hifn                  : open all lines containing any highlights on a new buffer (child)\n"
    let text .= "    :Hifw                  : open all lines containing any highlights on the current window\n"
    let text .= "    :HifC                  : close all filter windows\n"
    let text .= "    :Hisy                  : synchronize filter window data and position (sync father and child positions)\n"
    let text .= " * Filter window position  : \n"
    let text .= "    :Hip                   : synchcronize position\n"
    let text .= "    :Hips                  : synchonize position and switch window\n"
    let text .= "    :Hipsa                 : enable position auto synchonize\n"
    let text .= "    :Hipsn                 : disable position auto synchonize\n"
    let text .= " * Filter window data      : \n"
    let text .= "    :Hid                   : sychcronize data changes (sync child data to parent data)\n"
    let text .= "    :Hidsa                 : enable data change auto synchonize\n"
    let text .= "    :Hidsn                 : disable data changes auto synchonize\n"
    let text .= "  \n"
    let text .= "    :Hiup                  : reload parent and update child buffer contents\n"
    let text .= "  \n"
    let text .= "- Update tail: \n"
    let text .= "    :Hiupt [SECONDS]       : start/stop (tail -f mode like) the refresh of the main and filter window\n"
    let text .= "  \n"
    let text .= "- Others:\n"
    let text .= "    :Hir                   : refresh all highlightings\n"
    let text .= "    :Hioff                 : disable all highlightings\n"
    let text .= "    :Hion                  : disable all highlightings\n"
    let text .= "    :Hiwoff                : disable current window highlightings\n"
    let text .= "    :Hiwon                 : disable current window highlightings\n"
    let text .= "    :Hiy                   : Copy the highlight config into std register\n"
    let text .= "    :Hiut [SECONDS]        : Start/stop tail mode, periodic reload\n"
    let text .= "    :Hiv LEVEL             : show debug traces\n"
    let text .= "    :Hivtc                 : convert obsolet .vim config to .cfg file\n"
    let text .= "  \n"
    let text .= "Base colors help:\n"
    let text .= "  ".g:HiBaseColors."\n"
    let text .= " \n"
    let text .= "Color IDs help:\n"
    let text .= "  ".g:HiColorIds."\n"
    let text .= " \n"
    let text .= "EXAMPLES: \n"
    let text .= "Color highlight: \n"
    let text .= "   :Hic PATTERN g    highlight green fg\n"
    let text .= "   :Hic PATTERN g@   highlight green bg\n"
    let text .= "   :Hic PATTERN g!   highlight green bold\n"
    let text .= "   :Hic PATTERN g_   highlight green underline\n"
    let text .= "   :Hic PATTERN g*   highlight green fg all line\n"
    let text .= "   :Hic PATTERN g@*  highlight green bg all line\n"
    let text .= "   :Hic PATTERN1>>CONTAINS>>PATTERN2 r&     highlight block in red\n"
    let text .= "   :Hic PATTERN1>>PATTERN2 r&     highlight block in red\n"
    let text .= "   :Hic PATTERN1>>PATTERN2!? r&   highlight block in red\n"
    let text .= "Filter: \n"
    let text .= "   :Hif            open new filter window with all hightlighted lines \n"
    let text .= "   :Hif r          open new filter window with red hightlighted lines \n"
    let text .= "   :Hif r g        open new filter window with red and green hightlighted lines \n"
    let text .= "   :Hif r g@       open new filter window with red and background green hightlighted lines \n"
    let text .= "   :Hif r! g@      open new filter window with bold red and background green hightlighted lines \n"
    let text .= "   :Hif r! g_      open new filter window with bold red and underlined green hightlighted lines \n"
    let text .= "   :Hif !??        open new filter window with bold hightlighted lines \n"
    let text .= "   :Hif @??        open new filter window with background hightlighted lines \n"
    let text .= "   :Hif r*@??      open new filter window with all red background hightlighted lines \n"
    let text .= "   :Hif pattern    open new filter window with all pattern words found \n"
    let text .= "   :Hif pattern r  open new filter window with all pattern words found and all red highlighted words \n"
    let text .= ""

    redraw
    call hi#utils#WindowSplitMenu(4)
    call hi#utils#WindowSplit()
    setl nowrap
    set buflisted
    set bufhidden=delete
    set buftype=nofile
    setl noswapfile
    silent put = l:text
    silent! exec '0file | file hi_plugin_help'
    normal ggdd
    call hi#utils#WindowSplitEnd()
    call s:HelpHighlightColors()
endfunction


function! s:HelpHighlightColors()
    if exists('g:HiLoaded')
        let g:HiCheckPatternAvailable = 0

        silent! call hi#config#PatternColorize("hi.vim", "m2*")

        silent! call hi#config#PatternColorize("Abridged", "w3*")
        silent! call hi#config#PatternColorize("- ",       "w3*")
        silent! call hi#config#PatternColorize("Base colors","w3*")
        silent! call hi#config#PatternColorize("Color IDs","w3*")
        silent! call hi#config#PatternColorize("EXAMPLES", "w3*")

        silent! call hi#config#PatternColorize(":Hi[a-zA-Z]", "b")
        silent! call hi#config#PatternColorize(":Hi[a-zA-Z][a-zA-Z]", "b")
        silent! call hi#config#PatternColorize(":Hi[a-zA-Z][a-zA-Z][a-zA-Z]", "b")
        silent! call hi#config#PatternColorize(":Hi[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]", "b")

        let g:HiCheckPatternAvailable = 1
    endif
endfunction


function! hi#help#ConfigHelp()
    let text =  "[hi.vim] help (v".g:HiVersion.")\n"
    let text .= "\n"
    let text .= "Configuration help:  \n"
    let text .= "\n"
    let text .= "Highlight commads:\n"
    let text .= "   Mark = ColorID|Flags|Patterns\n"
    let text .= "\n"
    let text .= "Configuration commads:\n"
    let text .= "  Conf = clean\n"
    let text .= "  Conf = configName\n"
    let text .= "  Conf = configName1 configName2 configNameN\n"
    let text .= "  Conf = edit\n"
    let text .= "\n"
    let text .= "Filter commads:\n"
    let text .= "  Filt = close\n"
    let text .= "  Filt = colorID\n"
    let text .= "  Filt = colorID1 colorID2 colorIDN pattern\n"
    let text .= "  Filt = &groupName pattern\n"
    let text .= "  Filt = &g1\n"
    let text .= "  Filt = keepPattern keepColorID --removeColorID --removePattern\n"
    let text .= "  Filtw = colorID1 colorID2 colorIDN pattern\n"
    let text .= "  Filtv = keepColorID1 keepColorID2\n"
    let text .= "  Filtt = keepColorID1 keepColorID2\n"
    let text .= "\n"
    let text .= "Search commads:\n"
    let text .= "  Find = colorID\n"
    let text .= "  Find = colorID1 colorID2 colorIDN pattern\n"
    let text .= "\n"
    let text .= "Window commads:\n"
    let text .= "  Goto = init\n"
    let text .= "  Goto = son\n"
    let text .= "  Goto = parent\n"
    let text .= "  Goto = last\n"
    let text .= "  Conf = on\n"
    let text .= "  Conf = off\n"
    let text .= "  Conf = won\n"
    let text .= "  Conf = woff\n"
    let text .= "\n"
    let text .= "Vim commads:\n"
    let text .= "  Cmd  = %s/pattern/replace/g\n"
    let text .= "  Cmd  = w\n"
    let text .= "\n"
    let text .= "Group commads:\n"
    let text .= "  Group = myGroup\n"
    let text .= " \n"
    let text .= "Update tail commads:\n"
    let text .= " Update once:"
    let text .= "  Tail = \n"
    let text .= " Update continuosly without wait time:"
    let text .= "  Tail = 0\n"
    let text .= " Update every 2 seconds:"
    let text .= "  Tail = 2\n"
    let text .= " \n"
    let text .= " \n"

    tabedit
    setl nowrap
    set buflisted
    set bufhidden=delete
    set buftype=nofile
    setl noswapfile
    silent put = l:text
    silent! exec '0file | file hi_plugin_config_help_example'
    normal ggdd
    "call hi#utils#WindowSplitEnd()

    vertical new
    let text  = "Config example:\n"
    let text .= "  Filt = close\n"
    let text .= "  Conf = clean\n"
    let text .= "  Mark = o4   | C        |Warning_orange4_normal\n"
    let text .= "  Mark = o4   | C        |Warning_orange4_normal\n"
    let text .= "  Mark = o4!  | C        |Warning_orange4_bold\n"
    let text .= "  Mark = o4_  | C        |Warning_orange4_underlined\n"
    let text .= "  Group = Group1"
    let text .= "  Mark = r    | C        |Error_red\n"
    let text .= "  Mark = r1   | C        |Error_red1\n"
    let text .= "  Mark = r2   | C        |Error_red2\n"
    let text .= "  Mark = r3   | C        |Error_red3\n"
    let text .= "  Mark = r@   | C        |Severe_red_bg\n"
    let text .= "  Mark = r@   | Cl       |SEVERE_red_bg_all_line\n"
    let text .= "  Group = \n"
    let text .= "  Mark = w    | C        |Ex.*\n"
    let text .= "  Filt = all\n"
    let text .= "  Goto = parent\n"
    let text .= "  Filt = Warning\n"
    let text .= "  Goto = parent\n"
    let text .= "  Filt = &Group1\n"
    let text .= "  Goto = parent\n"
    let text .= "  Conf = woff\n"
    let text .= " \n"

    vnew
    setl nowrap
    set buflisted
    set bufhidden=delete
    set buftype=nofile
    setl noswapfile
    silent put = l:text
    silent! exec '0file | file hi_plugin_config_help_example'
    normal ggdd
    "call hi#utils#WindowSplitEnd()

    new 
    let text  = "[Example]\n"
    let text .= "Filt = close\n"
    let text .= "Conf = clean\n"
    let text .= "Mark = o4   | C        |Warning_orange4_normal\n"
    let text .= "Mark = o4   | C        |Warning_orange4_normal\n"
    let text .= "Mark = o4!  | C        |Warning_orange4_bold\n"
    let text .= "Mark = o4_  | C        |Warning_orange4_underlined\n"
    let text .= "Group = Group1"
    let text .= "Mark = r    | C        |Error_red\n"
    let text .= "Mark = r1   | C        |Error_red1\n"
    let text .= "Mark = r2   | C        |Error_red2\n"
    let text .= "Mark = r3   | C        |Error_red3\n"
    let text .= "Mark = r@   | C        |Severe_red_bg\n"
    let text .= "Mark = r@   | Cl       |SEVERE_red_bg_all_line\n"
    let text .= "Group = \n"
    let text .= "Mark = w    | C        |Ex.*\n"
    let text .= "Filt = all\n"
    let text .= "Goto = parent\n"
    let text .= "Filt = Warning\n"
    let text .= "Goto = parent\n"
    let text .= "Filt = &Group1\n"
    let text .= "Goto = parent\n"
    "let text .= "Conf = woff\n"
    let text .= "Goto = init\n"
    silent put = l:text
    normal ggdd
    let l:tmpConfigFile = tempname()
    "let l:tmpConfigFile = "tmp"
    silent exec "sav! ".l:tmpConfigFile
    quit

    call hi#autoConfig#ApplyConfig("Example",l:tmpConfigFile)

    silent remove(l:tmpConfigFile)
    wincmd =
    windo normal gg
endfunction


" Show menu on screen, choose command to lauch.
" Cmd: Hi
function! hi#help#CommandMenu(...)
    " Check jpLib.vim plugin installed
    if empty(glob(g:HiPluginPath."/../jpLib/utils.vim"))
        call hi#log#Error("missing plugin jpLib (".g:HiPluginPath."/../jpLib/utils.vim".")")
        call input("")
    endif

    let l:selection = ""
    if a:0 >= 1
        let l:selection = a:1
    endif

    let l:options  = []
    let l:options += [ [ "#highlightFiler.vim                                                               ", ""        , ""     ] ]
    let l:options += [ [ "# Highlight types:                                                                ", ""        , ""     ] ]
    let l:options += [ [ "#  Load:"                                                                          , ""        , ""     ] ]
    let l:options += [ [ "Apply selected highlight                                  (Hit  [TYPE_NAME])      ", "Hit"     , "t"    ] ]
    let l:options += [ [ "Apply selected highlight from file.                       (Hitf TYPE_NAME CONFIG_FILE)      ", "Hitf"    , "tf"   ] ]
    let l:options += [ [ "Load a configuration file                                 (Hil FILE_NAME)         ", "Hil"     , "l"  ] ]
    let l:options += [ [ "#  Save:"                                                                          , ""        , ""     ] ]
    let l:options += [ [ "Open all highlight configuration files                    (Hicfg)                 ", "Hicfg" , "cfg"  ] ]
    let l:options += [ [ "Save current highlight configuration                      (Hisv [TYPE_NAME])      ", "Hisv"    , "sv"   ] ]
    let l:options += [ [ "Force save current highlight configuration                (Hifsv [TYPE_NAME])     ", "Hifsv"   , "fsv"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Color help:                                                                     ", ""        , ""     ] ]
    let l:options += [ [ "Show highlighting color names                             (Hicol [all/COLOR])     ", "Hicol"   , "col"  ] ]
    let l:options += [ [ "Show highlighting color IDs                               (Hiid  [all/COLOR_ID])  ", "Hiid"    , "id"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Highlight commands:"                                                             , ""        , ""     ] ]
    let l:options += [ [ "Apply color highlight                                     (Hic PATTERN  COLOR_ID) ", "Hic"     , "c"    ] ]
    let l:options += [ [ "Open selection menu to remove a highlight pattern         (Hirm)                  ", "Hirm"  , "rm"   ] ]
    let l:options += [ [ "Undo last highlight                                       (Hiu)                   ", "Hiu"   , "u"    ] ]
    let l:options += [ [ "Show highlight applied on current file                    (Hish)                  ", "Hish"  , "sh"   ] ]
    let l:options += [ [ "Show highlight patterns                                   (Hishp)                 ", "Hishp" , "shp"  ] ]
    let l:options += [ [ "Remove all pattern highlighted with COLOR_ID              (Hicrm [COLOR_ID])      ", "Hicrm"   , "crm"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Highlight config editor:"                                                        , ""        , ""     ] ]
    let l:options += [ [ "Open config editor window                                 (Hie)                   ", "Hie"   , "e"    ] ]
    let l:options += [ [ "Apply config editor changes                               (Hier)                  ", "Hier"  , "er"   ] ]
    let l:options += [ [ "select a config type and open it on the editor window     (Hiet [TYPE_NAME])      ", "Hiet"    , "et"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Highlight search:"                                                               , ""        , ""     ] ]
    let l:options += [ [ "Search fordward all patterns highlighted with COLOR_ID    (Hics [COLOR_ID])       ", "Hics"    , "cs"   ] ]
    let l:options += [ [ "Search backward all patterns highlighted with COLOR_ID    (Hics [COLOR_ID])       ", "HicS"    , "cS"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Folding:                                                                        ", ""        , ""     ] ]
    let l:options += [ [ "Fold all. Show only lines with highlighting               (Hifold [COLOR_ID])     ", "Hifold"  , "fd"   ] ]
    let l:options += [ [ "Show folding patterns                                     (Hifoldsh)              ", "Hifoldsh", "fdsh" ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Filter window:"                                                                  , ""        , ""     ] ]
    let l:options += [ [ "Filter lines containing highlight on new split            (Hif)                   ", "Hif"   , "f"    ] ]
    let l:options += [ [ "Filter lines containing highlight on new horizontal split (Hifs)                  ", "Hifs"  , "fs"   ] ]
    let l:options += [ [ "Filter lines containing highlight on new vertical split   (Hifv)                  ", "Hifv"  , "fv"   ] ]
    let l:options += [ [ "Filter lines containing highlight on new tab child        (Hift)                  ", "Hift"  , "ft"   ] ]
    let l:options += [ [ "Filter lines containing highlight on new buffer child     (Hifn)                  ", "Hifn"  , "fn"   ] ]
    let l:options += [ [ "Synchronize filter window data and position               (Hisy)                  ", "Hisy"  , "sy"   ] ]
    let l:options += [ [ "#  Filter window position:"                                                        , ""        , ""     ] ]
    let l:options += [ [ "Synchcronize position                                     (Hip)                   ", "Hip"   , "p"    ] ]
    let l:options += [ [ "Synchonize position and switch window                     (Hips)                  ", "Hips"  , "ps"   ] ]
    let l:options += [ [ "Enable position auto synchonize                           (Hipsa)                 ", "Hipsa" , "psa"  ] ]
    let l:options += [ [ "Disable position auto synchonize                          (Hipsn)                 ", "Hipsn" , "psn"  ] ]
    let l:options += [ [ "#  Filter window data:                                                            ", ""        , ""     ] ]
    let l:options += [ [ "Sychcronize data changes                                  (Hid)                   ", "Hid"   , "d"    ] ]
    let l:options += [ [ "Enable data change auto synchonize                        (Hidsa)                 ", "Hidsa" , "dsa"  ] ]
    let l:options += [ [ "Disable data changes auto synchonize                      (Hidsn)                 ", "Hidsn" , "dsn"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "Reload parent and update child buffer contents            (Hiup)                  ", "Hiup"  , "up"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Others:"                                                                         , ""        , ""     ] ]
    let l:options += [ [ "Refresh all highlightings                                 (Hir)                   ", "Hir"   , "r"    ] ]
    let l:options += [ [ "Enable all highlightings                                  (Hi1)                   ", "Hi1"   , "1"    ] ]
    let l:options += [ [ "Disable window highlightings                              (Hiw0)                  ", "Hiw0"  , "w0"   ] ]
    let l:options += [ [ "Enable window highlightings                               (Hiw1)                  ", "Hiw1"  , "w1"   ] ]
    let l:options += [ [ "Disable all highlightings                                 (Hi0)                   ", "Hi0"   , "0"    ] ]
    let l:options += [ [ "Copy the highlight config into std register               (Hiy)                   ", "Hiy"     , "y"    ] ]
    let l:options += [ [ "Start/stop tail mode, periodic reload                     (Hiut [SECONDS])        ", "Hiut"    , "ut"   ] ]
    let l:options += [ [ "Show debug traces                                         (Hiv LEVEL)             ", "Hiv"     , "v"    ] ]
    let l:options += [ [ "Convert obsolet .vim config to .cfg file                  (Hivtc)                 ", "Hivtc" , "vtc"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "#Base colors help:"                                                                , ""        , ""     ] ]
    let l:options += [ [ "#  ".g:HiBaseColors                                                  , ""        , ""     ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "#Color IDs help:"                                                                  , ""        , ""     ] ]
    let l:options += [ [ "#  ".g:HiColorIds                                                    , ""        , ""     ] ]

    call jpLib#utils#OptionsMenu(l:options, l:selection)
endfunction



" Show menu on screen, choose command to lauch.
" Cmd: Hi
function! hi#help#CommandMenu(...)
    " Check jpLib.vim plugin installed
    if empty(glob(g:HiPluginPath."/../jpLib/utils.vim"))
        call hi#log#Error("missing plugin jpLib (".g:HiPluginPath."/../jpLib/utils.vim".")")
        call input("")
    endif

    let l:selection = ""
    if a:0 >= 1
        let l:selection = a:1
    endif

    let l:options  = []
    let l:options += [ [ "#highlightFiler.vim                                                               ", ""        , ""     ] ]
    let l:options += [ [ "# Highlight types:                                                                ", ""        , ""     ] ]
    let l:options += [ [ "#  Load:"                                                                          , ""        , ""     ] ]
    let l:options += [ [ "Apply selected highlight                                  (Hit  [TYPE_NAME])      ", "Hit"     , "t"    ] ]
    let l:options += [ [ "Apply selected highlight from file.                       (Hitf TYPE_NAME CONFIG_FILE)      ", "Hitf"    , "tf"   ] ]
    let l:options += [ [ "Load a configuration file                                 (Hil FILE_NAME)         ", "Hil"     , "l"  ] ]
    let l:options += [ [ "#  Save:"                                                                          , ""        , ""     ] ]
    let l:options += [ [ "Open all highlight configuration files                    (Hicfg)                 ", "Hicfg" , "cfg"  ] ]
    let l:options += [ [ "Save current highlight configuration                      (Hisv [TYPE_NAME])      ", "Hisv"    , "sv"   ] ]
    let l:options += [ [ "Force save current highlight configuration                (Hifsv [TYPE_NAME])     ", "Hifsv"   , "fsv"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Color help:                                                                     ", ""        , ""     ] ]
    let l:options += [ [ "Show highlighting color names                             (Hicol [all/COLOR])     ", "Hicol"   , "col"  ] ]
    let l:options += [ [ "Show highlighting color IDs                               (Hiid  [all/COLOR_ID])  ", "Hiid"    , "id"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Highlight commands:"                                                             , ""        , ""     ] ]
    let l:options += [ [ "Apply color highlight                                     (Hic PATTERN  COLOR_ID) ", "Hic"     , "c"    ] ]
    let l:options += [ [ "Open selection menu to remove a highlight pattern         (Hirm)                  ", "Hirm"  , "rm"   ] ]
    let l:options += [ [ "Undo last highlight                                       (Hiu)                   ", "Hiu"   , "u"    ] ]
    let l:options += [ [ "Show highlight applied on current file                    (Hish)                  ", "Hish"  , "sh"   ] ]
    let l:options += [ [ "Show highlight patterns                                   (Hishp)                 ", "Hishp" , "shp"  ] ]
    let l:options += [ [ "Remove all pattern highlighted with COLOR_ID              (Hicrm [COLOR_ID])      ", "Hicrm"   , "crm"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Highlight config editor:"                                                        , ""        , ""     ] ]
    let l:options += [ [ "Open config editor window                                 (Hie)                   ", "Hie"   , "e"    ] ]
    let l:options += [ [ "Apply config editor changes                               (Hier)                  ", "Hier"  , "er"   ] ]
    let l:options += [ [ "select a config type and open it on the editor window     (Hiet [TYPE_NAME])      ", "Hiet"    , "et"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Highlight search:"                                                               , ""        , ""     ] ]
    let l:options += [ [ "Search fordward all patterns highlighted with COLOR_ID    (Hics [COLOR_ID])       ", "Hics"    , "cs"   ] ]
    let l:options += [ [ "Search backward all patterns highlighted with COLOR_ID    (Hics [COLOR_ID])       ", "HicS"    , "cS"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Folding:                                                                        ", ""        , ""     ] ]
    let l:options += [ [ "Fold all. Show only lines with highlighting               (Hifold [COLOR_ID])     ", "Hifold"  , "fd"   ] ]
    let l:options += [ [ "Show folding patterns                                     (Hifoldsh)              ", "Hifoldsh", "fdsh" ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Filter window:"                                                                  , ""        , ""     ] ]
    let l:options += [ [ "Filter lines containing highlight on new split            (Hif)                   ", "Hif"   , "f"    ] ]
    let l:options += [ [ "Filter lines containing highlight on new horizontal split (Hifs)                  ", "Hifs"  , "fs"   ] ]
    let l:options += [ [ "Filter lines containing highlight on new vertical split   (Hifv)                  ", "Hifv"  , "fv"   ] ]
    let l:options += [ [ "Filter lines containing highlight on new tab child        (Hift)                  ", "Hift"  , "ft"   ] ]
    let l:options += [ [ "Filter lines containing highlight on new buffer child     (Hifn)                  ", "Hifn"  , "fn"   ] ]
    let l:options += [ [ "Synchronize filter window data and position               (Hisy)                  ", "Hisy"  , "sy"   ] ]
    let l:options += [ [ "#  Filter window position:"                                                        , ""        , ""     ] ]
    let l:options += [ [ "Synchcronize position                                     (Hip)                   ", "Hip"   , "p"    ] ]
    let l:options += [ [ "Synchonize position and switch window                     (Hips)                  ", "Hips"  , "ps"   ] ]
    let l:options += [ [ "Enable position auto synchonize                           (Hipsa)                 ", "Hipsa" , "psa"  ] ]
    let l:options += [ [ "Disable position auto synchonize                          (Hipsn)                 ", "Hipsn" , "psn"  ] ]
    let l:options += [ [ "#  Filter window data:                                                            ", ""        , ""     ] ]
    let l:options += [ [ "Sychcronize data changes                                  (Hid)                   ", "Hid"   , "d"    ] ]
    let l:options += [ [ "Enable data change auto synchonize                        (Hidsa)                 ", "Hidsa" , "dsa"  ] ]
    let l:options += [ [ "Disable data changes auto synchonize                      (Hidsn)                 ", "Hidsn" , "dsn"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "Reload parent and update child buffer contents            (Hiup)                  ", "Hiup"  , "up"   ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "# Others:"                                                                         , ""        , ""     ] ]
    let l:options += [ [ "Refresh all highlightings                                 (Hir)                   ", "Hir"   , "r"    ] ]
    let l:options += [ [ "Enable all highlightings                                  (Hi1)                   ", "Hi1"   , "1"    ] ]
    let l:options += [ [ "Disable window highlightings                              (Hiw0)                  ", "Hiw0"  , "w0"   ] ]
    let l:options += [ [ "Enable window highlightings                               (Hiw1)                  ", "Hiw1"  , "w1"   ] ]
    let l:options += [ [ "Disable all highlightings                                 (Hi0)                   ", "Hi0"   , "0"    ] ]
    let l:options += [ [ "Copy the highlight config into std register               (Hiy)                   ", "Hiy"     , "y"    ] ]
    let l:options += [ [ "Start/stop tail mode, periodic reload                     (Hiut [SECONDS])        ", "Hiut"    , "ut"   ] ]
    let l:options += [ [ "Show debug traces                                         (Hiv LEVEL)             ", "Hiv"     , "v"    ] ]
    let l:options += [ [ "Convert obsolet .vim config to .cfg file                  (Hivtc)                 ", "Hivtc" , "vtc"  ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "#Base colors help:"                                                                , ""        , ""     ] ]
    let l:options += [ [ "#  ".g:HiBaseColors                                                  , ""        , ""     ] ]
    let l:options += [ [ "#"                                                                                 , ""        , ""     ] ]
    let l:options += [ [ "#Color IDs help:"                                                                  , ""        , ""     ] ]
    let l:options += [ [ "#  ".g:HiColorIds                                                    , ""        , ""     ] ]

    call jpLib#utils#OptionsMenu(l:options, l:selection)
endfunction


"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
