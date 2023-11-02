" Script Name: colors.vim
" Description: create colors/hi.vim file with all color configurations needed.
"
" Copyright:   (C) 2017-2021 Javier Puigdevall Garcia
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Puigdevall Garcia <javierpuigdevall@gmail.com>
"


"- functions -------------------------------------------------------------------

function! s:Error(mssg)
    echohl ErrorMsg | echom s:plugin.": ".a:mssg | echohl None
endfunction


function! s:Warn(mssg)
    echohl WarningMsg | echo a:mssg | echohl None
endfunction


" Debug function. Log message
function! s:Verbose(level,func,mssg)
    if s:verbose >= a:level
        echom s:plugin_name." : ".a:func." : ".a:mssg
    endif
endfunction


" Debug function. Log message and wait user key
function! s:VerboseStop(level,func,mssg)
    if s:verbose >= a:level
        call input(s:plugin_name." : ".a:func." : ".a:mssg." (press key)")
    endif
endfunction


func! hi#colors#Verbose(level)
    let s:verbose = a:level
endfun


" Define a color highlighting for every color on the list 
function! s:SaveColorConfig(type,list,tabs)
    echo "Save color config ".a:type 

    let l:configList = [ ]
    for i in a:list
        if l:i[0] == "" || l:i[1] == "" || l:i[2] == "" || l:i[3] == ""
            continue
        endif

        " Highlight command don't allow using characters: !"·$%&/()=?¿^*{}[]`+-_.,;:¡
        " Transform characters
        "    Bold modifier      : ! change to B
        "    Background color   : # change to H
        "    Underline modifier : _ change to U
        let l:color = l:i[0]
        let l:color = substitute(l:color,'!','B','')
        let l:color = substitute(l:color,'#','H','')
        let l:color = substitute(l:color,'_','U','')

        let cmd = "highlight! HiMatchColor".l:color." ".a:type."=".l:i[1]." ".a:type."bg=".l:i[2]." ".a:type."fg=".l:i[3]
        call append(line('$'), a:tabs.l:cmd)
    endfor
    call append(line('$'),"")

    " Dump to config file
    call append(line('$'), a:tabs."let g:HighlightFilter_ColorDefinitionList = []")
    for i in a:list
        if l:i[0] == "" || l:i[1] == "" || l:i[2] == "" || l:i[3] == ""
            continue
        endif
        call append(line('$'), a:tabs."let g:HighlightFilter_ColorDefinitionList += [ [ \"".l:i[0]."\", \"".l:i[1]."\", \"".l:i[2]."\", \"".l:i[3]."\", \"".l:i[4]."\" ] ]")
    endfor
    call append(line('$'),"")

    call append(line('$'), a:tabs."let g:HighlightFilter_BaseColors = \"".s:baseColors."\"")
    call append(line('$'),"")
    call append(line('$'), a:tabs."let g:HighlightFilter_ColorIds = \"".s:baseColorIds."\"")
endfunction


" Create the syntax highlight configuration 
" Create a configuration for every color and mode
function! s:InitializeColorConfig(modeList, colorList, colorDict)
    "let s:verbose = 1
    let verbose = s:verbose
    let s:baseColors   = ""
    let s:baseColorIds = ""
    call s:VerboseStop("")
    let  l:colorConfigList = []

    " Iterate on every mode
    " (foreground plain, foreground bold, foreground underline, backgraund, backgraund bold...)
    let i = 0
    for config in a:modeList
        let mode   = l:config[0]
        let invert = l:config[1]
        let modeId = l:config[2]
        let prefix = l:config[3]
        let sufix  = l:config[4]
        call s:Verbose("Mode:".l:mode." BG:".l:invert)

        " Iterate on every color
        " (yellow, green, blue, magenta, cyan...)
        for name in a:colorList
            call s:Verbose("Name:".l:name)
            if l:name == "" || l:name == ":"
                continue
            endif

            let color = l:name
            let id    = toupper(l:name[0:0])
            let depth = g:highlightMatchColorDepth

            silent let list = split(l:name,':')

            if len(l:list) >= 1 && l:list[0] != ""
                let name  = l:list[0]
                let color = l:list[0]
            endif
            if len(l:list) >= 2 && l:list[1] != ""
                let id = toupper(l:list[1])
            endif
            if len(l:list) >= 3 &&  l:list[2] != ""
                let depth = l:list[2]
            endif

            if l:mode == "none" && l:invert == ""
                let s:baseColors   .= l:name." "
                let s:baseColorIds .= l:id." "
            endif

            " Iterate on every sub-color
            " (yellow, yellow1, yellow2... yellowN)
            let n = 0
            while n <= l:depth
                if l:n == 0
                    let Number = ""
                else
                    let Number = l:n
                endif

                let idn    = l:id.l:Number
                let namen  = l:name.l:Number
                let colorn = l:color.l:Number

                let tmp = get(a:colorDict, l:colorn, "")
                if  l:tmp != ""
                    let l:colorn = l:tmp
                endif

                let idn .= l:modeId
                let namen = l:prefix.l:namen.l:sufix

                if l:invert != ""
                    let l:colorConfigList += [ [ l:idn, l:mode, l:colorn, "bg", l:namen ] ]
                    let tmp = l:n.") ID:".l:idn." MODE:".l:mode." FG:".l:colorn." BG:bg "." NAME:".l:namen
                else
                    let l:colorConfigList += [ [ l:idn, l:mode, "bg", l:colorn, l:namen ] ]
                    let tmp = l:n.") ID:".l:idn." MODE:".l:mode." FG:bg BG:".l:colorn." NAME:".l:namen
                endif
                "call s:Verbose(l:tmp)
                call s:VerboseStop(l:tmp)
                let n += 1
                let i += 1
            endwhile
        endfor
    endfor
    let s:verbose = l:verbose
    return l:colorConfigList
endfunction


" 
function! s:GetModeList()
    echo "Get mode list"
    "---------------------------------------------------------------------------------------
    " Note: config order will determine the config preference
    "   List items: mode, invert colors, mode id, name prefix, name suffix
    "---------------------------------------------------------------------------------------
    let l:modeList  = [ ]
    let l:modeList += [ [ "none",      "",   "",   "",           "-foreground" ] ] " Plain foreground colors
    let l:modeList += [ [ "bold",      "",   "!",  "bold-",      "-foreground" ] ] " Bold foreground colors
    let l:modeList += [ [ "underline", "",   "_",  "underline-", "-foreground" ] ] " Underlined foreground colors
    let l:modeList += [ [ "none",      "1",  "#",  "",           "-background" ] ] " Plain background colors
    let l:modeList += [ [ "bold",      "1",  "#!", "bold-",      "-background" ] ] " Bold background colors
    "let s:defaultModeList += [ [ "underline", "1",  "#_", "underline-", "-background" ] ] " Underlined background colors
    return l:modeList
endfunction


" 
function! s:GetColorList(type)
    echo "Get color list ".a:type

    if &background == "light"
        let s:fgColorName = "black"
        let s:fgColorId = "k"
    else
        let s:fgColorName = "white"
        let s:fgColorId = "w"
    endif

    let  l:colorList = []

    if a:type == "gui"
        let  l:colorDict  = { "none"   : "fg" }

        "---------------------------------------------------------------------------------------
        " NOTE: color order will determine the color preference
        "   Color definition: ColorName:ColorId:ColorDepth
        "   ColorName: base name of the colors: yellow, gold, green, blue...
        "   ColorId: base color name id: y, go, g, b... if non exist, the first
        "   character will be used as id.
        "   ColorDepth: for each base color, a sub-color could be defined. for depth
        "   2, colors: yellow1, yellow2 will be used too.
        "---------------------------------------------------------------------------------------
        " Colors found at:
        " https://codeyarns.com/2011/07/29/vim-chart-of-color-names/
        "---------------------------------------------------------------------------------------
        "let  l:colorList  += [ "none:" ]
        "let  l:colorList  += [ "RosyBrown:k1"    , "SaddleBrown:k2"   , "sienna:k3"         , ":k4"                , "black:k"           , ":k5"               , ":k6" ]
        let  l:colorList  += [ "none:n1"          , "none1:n2"         , "none2:n3"          , "none4:n4"           , "none5:n5"          , "none6:n6"          , "none:n" ]
        let  l:colorList  += [ "snow:w1"          , "WhiteSmoke:w2"    , "FloralWhite:w3"    , "OldLace:w4"         , "linen:w5"          , "AntiqueWhite:w7"   , "white:w" ]
        let  l:colorList  += [ "khaki:y1"         , "PaleGoldenrod:y2" , "yellow:y"          , "gold:y3"            , "LightGoldenrod:y4" , "goldenrod:y5"      , "DarkGoldenrod:y6" ]
        let  l:colorList  += [ "DarkGreen:g1"     , "SeaGreen:g2"      , "MediumSeaGreen:g3" , "PaleGreen:g4"       , "SpringGreen:g5"    , "LawnGreen:g6"      , "green:g" ]
        let  l:colorList  += [ "NavyBlue:b1"      , "RoyalBlue:b2"     , "blue:b"            , "DodgerBlue:b3"      , "DeepSkyBlue:b4"    , "skyBlue:b5"        , "SteelBlue:b6" ]
        let  l:colorList  += [ "magenta:m"        , "orchid:m1"        , "MediumOrchid:m2"   , "DarkOrchid:m3"      , "purple:m5"         , "MediumPurple:m6" ]
        let  l:colorList  += [ "PaleTurquoise:c1" , "DarkTurquoise:c2" , "DarkTurquoise:c3"  , "MediumTurquoise:c4" , "turquoise:c5"      , "cyan:c"            , "aquamarine:c6" ]
        let  l:colorList  += [ "PaleVioletRed:v1" , "VioletRed:v2"     , "HotPink:v3"        , "DeepPink:v4"        , "violet:v"          , "DarkViolet:v5"     , "BlueViolet:v6" ]
        let  l:colorList  += [ "DarkSalmon:o1"    , "salmon:o2"        , "LightSalmon:o3"    , "orange:o"           , "DarkOrange:o4"     , "coral:o5"          , "LightCoral:o6" ]
        let  l:colorList  += [ "IndianRed:r1"     , "firebrick:r2"     , "tomato:r3"         , "OrangeRed:r4"       , "red:r"             , "DarkRed:r5"        , "maroon:r6" ]
        let  l:colorList  += [ "RosyBrown:br1"    , "SaddleBrown:br2"  , "sienna:br3"        , "peru:br4"           , "burlywood:br"      , "SandyBrown:br5"    , "chocolate:br6" ]
    else
        "---------------------------------------------------------------------------------------
        " NOTE: color order will determine the color preference
        "   Color definition: ColorName:ColorId:ColorDepth
        "   ColorName: base name of the colors: yellow, gold, green, blue...
        "   ColorId: base color name id: y, go, g, b... if non exist, the first
        "   character will be used as id.
        "   ColorDepth: for each base color, a sub-color could be defined. for depth
        "   2, colors: yellow1, yellow2 will be used too.
        "---------------------------------------------------------------------------------------
        let l:colorList = [ "none::0", "yellow", "green", "blue", "magenta", "cyan", "violet", s:fgColorName.":".s:fgColorId, "orange", "red" ]
    endif
    return l:colorList
endfunction


" 
function! s:GetColorDict(type)
    echom "Get color dict ".a:type

    " Use default color dictionary
    if a:type == "gui"
        " *On GUI mode:
        "  193 colors available.
        "  965 color configurations.
        let g:highlightMatchColorDepth  = 0
        let l:colorDict  = { }
        call extend(l:colorDict, { "none"   : "fg" })

    elseif a:type == "term256"
        " * TERM 256 colors mode:
        "  82 colors available.
        "  410 color configurations.
        let g:highlightMatchColorDepth  = 8

        "---------------------------------------------------------------------------------------
        " NOTE: colors found with plugin xterm-color-table plugin
        "   https://www.vim.org/scripts/script.php?script_id=3412
        "   :XtermColorTable
        "---------------------------------------------------------------------------------------
        let  l:colorDict  = { }
        "call extend(l:colorDict , { "none"   : "fg" })
        call extend(l:colorDict , { "none"   : "fg", "none1"   : "fg", "none2"   : "fg", "none3"   : "fg", "none4"   :"fg" , "none5"   : "fg", "none6"   : "fg", "none7"   : "fg", "none8"   : "fg"})
        call extend(l:colorDict , { "yellow" : 3   , "yellow1" : 186 , "yellow2" : 229 , "yellow3" : 228 , "yellow4" : 192 , "yellow5" : 227 , "yellow6" : 191 , "yellow7" : 190 , "yellow8" : 220 })
        call extend(l:colorDict , { "green"  : 64  , "green1"  : 64  , "green2"  : 48  , "green3"  : 47  , "green4"  : 41  , "green5"  : 40  , "green6"  : 34  , "green7"  : 28  , "green8"  : 22  })
        call extend(l:colorDict , { "blue"   : 4   , "blue1"   : 45  , "blue2"   : 39  , "blue3"   : 33  , "blue4"   : 27  , "blue5"   : 20  , "blue6"   : 19  , "blue7"   : 18  , "blue8"   : 17  })
        call extend(l:colorDict , { "cyan"   : 6   , "cyan1"   : 159 , "cyan2"   : 123 , "cyan3"   : 87  , "cyan4"   : 50  , "cyan5"   : 44  , "cyan6"   : 37  , "cyan7"   : 30  , "cyan8"   : 23  })
        call extend(l:colorDict , { "magenta": 125 , "magenta1": 177 , "magenta2": 171 , "magenta3": 165 , "magenta4": 164 , "magenta5": 128 , "magenta6": 127 , "magenta7": 126 , "magenta8": 90  })
        call extend(l:colorDict , { "violet" : 13  , "violet1" : 67  , "violet2" : 68  , "violet3" : 69  , "violet4" : 63  , "violet5" : 57  , "violet6" : 56  , "violet7" : 55  , "violet8" : 54  })
        call extend(l:colorDict , { "black"  : 235 , "black1"  : 232 , "black2"  : 233 , "black3"  : 234 , "black4"  : 235 , "black5"  : 236 , "black6"  : 237 , "black7"  : 238 , "black8"  : 241 })
        call extend(l:colorDict , { "white"  : 255 , "white1"  : 254 , "white2"  : 253 , "white3"  : 252 , "white4"  : 251 , "white5"  : 250 , "white6"  : 249 , "white7"  : 246 , "white8"  : 243 })
        call extend(l:colorDict , { "orange" : 9   , "orange1" : 174 , "orange2" : 216 , "orange3" : 215 , "orange4" : 214 , "orange5" : 208 , "orange6" : 202 , "orange7" : 166 , "orange8" : 130 })
        call extend(l:colorDict , { "red"    : 1   , "red1"    : 197 , "red2"    : 161 , "red3"    : 125 , "red4"    : 196 , "red5"    : 160 , "red6"    : 124 , "red7"    : 88  , "red8"    : 52  })

    else
        let g:highlightMatchColorDepth = 0
        "---------------------------------------------------------------------------------------
        " NOTE: Solarized color scheme color definition
        " Colors found at:
        " http://ethanschoonover.com/solarized
        " https://github.com/altercation/solarized/blob/master/vim-colors-solarized/colors/solarized.vim
        "---------------------------------------------------------------------------------------
        let l:colorDict  = { "none":"fg", "yellow":3,"yellow1":11,"green":2,"green1":10,"blue":4,"blue1":12,"cyan":6,"cyan1":14, 
                    \"magenta":5,"violet":61,"black":0,"black1":8,"white":7,"white1":15,"orange":9 ,"red":1 }
    endif
    return l:colorDict
endfunction


" Init
fun! hi#colors#CreateColorsFile()
    let s:verbose = 0

    let l:modeList   = s:GetModeList()

    tabedit
    call append(line('$'), "if has(\"gui_running\")")

    let l:colorList  = s:GetColorList("gui")
    let l:colorDict  = s:GetColorDict("gui")
    let l:configList = s:InitializeColorConfig(l:modeList, l:colorList, l:colorDict)
    call s:SaveColorConfig("gui",l:configList,"    ")

    call append(line('$'), "else")
    call append(line('$'), "    if g:HiMatchTermColors == 256")

    let l:colorList  = s:GetColorList("term")
    let l:colorDict  = s:GetColorDict("term256")
    let l:configList = s:InitializeColorConfig(l:modeList, l:colorList, l:colorDict)
    call s:SaveColorConfig("cterm",l:configList,"        ")

    call append(line('$'), "    else")

    let l:colorList  = s:GetColorList("term")
    let l:colorDict  = s:GetColorDict("term16")
    let l:configList = s:InitializeColorConfig(l:modeList, l:colorList, l:colorDict)
    call s:SaveColorConfig("cterm",l:configList,"        ")

    call append(line('$'), "    endif")
    call append(line('$'), "endif")
endfun



"- initializations ------------------------------------------------------------

let s:plugin = expand('<sfile>')
let s:plugin_path = expand('<sfile>:p:h')
let  s:plugin_name = expand('<sfile>:t')

