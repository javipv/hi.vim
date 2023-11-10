" Script Name: hi.vim
" Description: Highlight patterns in different colors.
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
"
" INSPIRED BY:
"   https://github.com/vim-scripts/Mark--Karkat
"   http://github.com/guns/highlightFilter.vim
"
" Version:      2.0.8
" Changes:
"   - New: add help menu, search/launch commands with :Hi [PATTERN].
" 2.0.8 	Tue, 04 Mar 23.     JPuigdevall
"   * Added to GitHub. 
"   - Fix: enhance the config tags parsing when using functions: IsTitle, IsCommand, IsColor.
"     Title line format should match format: ^\[[a-aA-Z].*\]$
"   - New: on help (:Hih) command, add color highlighting.
"   - Fix: bug on Hic when highlighting blocs, tag & not discarded correctly as color modifier.
" 2.0.7 	Mon, 28 Feb 22.     JPuigdevall
"   - New: when usign an auto config line, and fileConfig='%', the highlight configuration is expected to be found 
"       on the same file, on the first or last 150 lines (defined by: g:HiFileConfigCheckLinesMax).
"       e.g.: 
"         [ErrorHighlight]
"         Mark = r | CT | Error:
"         Mark = r | CT | Failure:
"         vim_hi:cfg=ErrorHighlight::cfgFile=%
"   - Fix: add missing hi_off.vim file.
" 2.0.6 	Tue, 12 Dec 21.     JPuigdevall
"   - Fix: Hivba, autoConfig file not included on the vimball file.
"   - New: command :Hicsb to search in backward direction.
"   - Fix: autoConfig not initialized.
"   - Fix: not parsing last file's line when trying to find config line.
" 2.0.5 	Mon, 01 March 21.     JPuigdevall
"   - New: Hiut command, update periodically the main and filter window (like tail -f command).
"   - Fix: cosmetic, pattern color highlight on the filter header, prevent any pattern from highlighting the entire line.
"   - New: new hi#filter#ColorSplitMenu function. Hif commond now will show a menu to choose the split/tab were opening the filter buffer.
"   - New: Hivba command. Development command to create a vimball release of the plugin.
"   - New: on Hishp separate patterns with |, enclose on ''.
"   - Fix: on Hisv fix menu for choosing the file to save the configuration.
"   - Add config.hi to generate the colors/hi.vim file.
" 2.0.4 	Wed, 14 Oct 20.     JPuigdevall
"   - New: named groups with configuration command: Group = NAME1 NAME2 NAMEN.
"      Use '&GROUP_NAME' (for line command) and 'GROUP_NAME' (for config files).
"   - New: filter commands :Filtw/Hifw. Perform filter and show results on the same window.
"      This allows to perform a second, third, etc filter on a filter window.
"      ex: Filt  = pattern1 r1
"          Filtw = pattern2
"      ex: :Hif pattern1 r1 | Hifw pattern2
"   - New: Configuration command Cmd to execute vim commands:
"      ex: Cmd = silent! %s/pattern/replace/g
"      ex: Cmd = w
"   - New: filter option to remove from filter window colorIDs or patters, adding prefix '--' to the pattern or colorId.
"      ex: Filt = --MyRemovePattern --MyRemoveColorID
"      ex: :Hif --MyRemovePattern --MyRemoveColorID
"      ex: :Hif MyKeepPattern --MyRemovePattern --MyRemoveColorID
"   - New: Configuration command for Conf options to enable and disable the highlighting: on, off, won, woff
"      ex: Conf = off
"      ex: Conf = on
"      ex: Conf = woff
"      ex: Conf = won
"   - New: allow pattern search on :Hics or :Hisb commands and 'Find' configuration command.
"      ex: :Hics myPattern colorID
"      ex: Find = myPattern colorID
"   - New: allow to specify the search direction on 'Find' configuration command.
"      ex: Find = myPattern colorID1 colorID2 | fw
"      ex: Find = myPattern colorID1 colorID2 | bw
"   - New: enable/disable highlighting commands: Hioff, Hion, Hiwoff, Hiwoff. 
" 2.0.3 	Fry, 05 Oct 20.     JPuigdevall
"   - New: hidden config types, not displayed on Hit command, when the config name starts with '__', like [__hiddenConfig].
"   - New: colors/hi.vim. Add on term config 256, colors N1...N8 N1!...N8! N1_...N8_ N1@...N8@ N1@!...N8@!
"   - New: colors/hi.vim. Add on gui config, colors: N1...N6 N1!...N6! N1_...N6_ N1@...N6@ N1@!...N6@!
"   - New: colors/hi.vim. Align columns.
"   - New: help.vim. Open help in new split, show plugin version.
"   - New: test.vim. Improve the tests, include the usage example.
"   - Fix: Hif command not rejects to filter when no highlighting set.
"      allow to filer patterns without color highlighting.
"   - New: highlight only option to omitt a pattern from any filter. 
"      Use '-' (for line command) and 'h' (for config files).
"      ex: :Hic r- MyPattern
"      ex: Mark = r | h | MyPattern
"   - New: highlight groups. Used to filter groups. 
"      Use '&g' (for line command) and 'g' (for config files).
"      ex: Mark = r | g1 | MyRedPattern
"      ex: Mark = g | g1 | MyGreenPattern
"      ex: :Hif &g1
"   - New: command Hitf CONFIG_NAME CONFIG_FILE to load a highlight config type from file. 
"   - New: config file's command "Conf", new "add" subcommand to source a new previous defined config. 
"      ex: Conf = add | CONFIG_NAME
"   - Fix: for config types: "Conf = add..." do not show on Hish command neither on the config editor.
"   - Fix: filter patterns that cotain character '/' caused and error on the configReload.
"   - New: enable/disable highlighting commands: Hi0, Hi1, Hiw0, Hiw1. 
" 2.0.2 	Mon, 31 Aug 20.     JPuigdevall
"   - New: color option ??, used to select all similar colors.
"   - Fix: :Hishp, missing function hi#config#ShowPatterns
"   - New: config editor use q to close the editor window.
"   - New: set config editor buftype=nofile. Prevent writting to file.
"   - Fix: configuration file and config editor parsing pattern containing '=' characater.
"   - New option to autolad a config highlight when a header ':vim_hi:cfg=my_config::cfgfile=my?file' found on top/bottom when openening or reloading the file.
" 2.0.1 	Thu, 12 Jan 20.     JPuigdevall
"   - Fix highlight on top.
"   - Fix Hiid all and Hicol all.
" 2.0.0 	Wed, 10 Jun 20.     JPuigdevall
"   - Change file name from highlightFilter.vim to hi.vim
"   - Separate on several files inside autoload/hi folder
" 1.0.8 	Wed, 17 Jun 20.     JPuigdevall
"   - New command goto window (first parent, parent, son, last son): HigoP, Higop, Higos, HigoS.
"   - New command clean all: Hifcl.
" 1.0.7 	Wed, 15 Jun 20.     JPuigdevall
"   - New config editor window.
"   - Hie and Hier commands
" 1.0.5 	Wed, 04 Jun 19.     JPuigdevall
"   - New config variables: g:HighlightFilter_SyncWinKey, g:HighlightFilter_SyncSwitchWinKey, HighlightFilter_SyncDataWinKey
" 1.0.4 	Wed, 17 May 19.     JPuigdevall
"   - HiVimToCfg function to convert obsolet .vim config files to new .cfg format. 
"   - Remove all hi... abbreviations replace with commands Hi... 
" 1.0.3 	Wed, 16 Apr 19.     JPuigdevall
" 1.0.2 	Wed, 20 Feb 19.     JPuigdevall
" 1.0.1 	Tue, 12 Feb 19.     JPuigdevall
" 1.0.0 	Sun, 10 Feb 19.     JPuigdevall
"   - Initial realease.


if exists('g:HiLoaded')
    finish
endif

if (!has("syntax"))
    echo "+syntax option required for highlighting."
    finish
endif

let g:HiLoaded = 1
let s:save_cpo = &cpo
set cpo&vim

let s:leader = exists('g:mapleader') ? g:mapleader : ''

let g:HiVersion = "2.0.8"


"- configuration --------------------------------------------------------------

let g:HiTermColors             = get(g:, 'HiTermColors', 256)

" Color highlight autosave options
let g:HiAutoSave               = get(g:, 'HiAutoSave', 0)
let g:HiAutoSaveConfirm        = get(g:, 'HiAutoSaveConfirm', 1)
let g:HiAutoSaveSourcePrefix   = get(g:, 'HiAutoSaveSourcePrefix', "_")
let g:HiAutoSaveSourceSufix    = get(g:, 'HiAutoSaveSourceSufix', "_vim_hi.cfg")
let g:HiAutoSaveExtensions     = get(g:, 'HiAutoSaveExtensions', "")
let g:HiAutoSaveExcludeExt     = get(g:, 'HiAutoSaveExcludeExt', "")
let g:HiAutoload               = get(g:, 'HiAutoload', 1) " Reload last configuration type used with current file

" Color highlight config files:
let g:HiConfigFileName         = get(g:, 'HiConfigFileName', ".vim_hi.cfg")


if has("win16") || has("win32") || has("win64") 
    let g:HiConfigFileName     = get(g:, 'HiConfigFileName', "_vim_hi.cfg")
    let g:HiDirSep = "\\"
    let g:HiPrevDirSep = "\\..\\"
else
    let g:HiConfigFileName     = get(g:, 'HiConfigFileName', ".vim_hi.cfg")
    let g:HiDirSep = "/"
    let g:HiPrevDirSep = "/../"
    "let g:HiPrevDirSep = "../"
endif

let g:configFiles = ""
let g:configFiles .= expand("%:p:h").g:HiDirSep.g:HiConfigFileName." "
let g:configFiles .= expand("%:p:h").g:HiPrevDirSep.g:HiConfigFileName." "
let g:configFiles .= getcwd().g:HiDirSep.g:HiConfigFileName." "
let g:configFiles .= getcwd().g:HiPrevDirSep.g:HiConfigFileName." "
let g:configFiles .= $HOME.g:HiDirSep.g:HiConfigFileName." "

let g:HiSourceFiles            = get(g:, 'HiSourceFiles', g:configFiles)

unlet g:configFiles

" Filter window configurations
let g:HiAgGrepFilter           = get(g:, 'HiAgGrepFilter', 1) " Number of lines in file to use ag or grep
let g:HiUseGrep                = get(g:, 'HiUseGrep', 0) " 

let g:HiAwkFilter              = get(g:, 'HiAwkFilter', 1) " On 1 use awk to filter the matching patterns
let g:HiFilterSplit            = get(g:, 'HiFilterSplit', "split")

let g:HiFilterAddHeader        = get(g:, 'HiFilterAddHeader', 1)

let g:HiFilterMinimize         = get(g:, 'HiFilterMinimize', 0)

let g:HiFiltSync               = get(g:, 'HiFiltSync', 1)
let g:HiAutoSyncFiltPos        = get(g:, 'HiAutoSyncFiltPos', 0)
let g:HiAutoSyncFiltData       = get(g:, 'HiAutoSyncFiltData', 0)

let g:HiAutoFilt               = get(g:, 'HiAutoFilt', 0)
let g:HiAutoFiltExtensions     = get(g:, 'HiAutoFiltExtensions', "")
let g:HiAutoFiltNotExtensions  = get(g:, 'HiAutoFiltNotExtensions', "")

let g:HiKeyPadMode             = get(g:, 'HiKeyPadMode', 0)

" Map keys to sychronize filter and main windows:
let g:HiSyncWinKey             = get(g:, 'HiSyncWinKey',       "<ENTER>")
let g:HiSyncSwitchWinKey       = get(g:, 'HiSyncSwitchWinKey', "<Esc><ENTER>")
let g:HiSyncDataWinKey         = get(g:, 'HiSyncDataWinKey',   "<HOME>")
let g:HiUpdateDataWinKey       = get(g:, 'HiUpdateDataWinKey', "<END>")

"show config files
let g:HiCfgSplitNumb             = get(g:, 'HiCfgSplitNumb', 3)

" Block separation string
let g:HiBlockSeparator           = get(g:, 'HiBlockSeparator', ">>")
let g:HiBlockRemoveLine          = get(g:, 'HiBlockRemoveLine', "!!")
let g:HiBlockRemoveLineAddNL     = get(g:, 'HiBlockRemoveLineAddNL', "!?")

" Gui menu
let g:HiMode                     = get(g:, 'HiMode', 3)

" Conceal ANSI Esc Sequnce characters
let g:HiConcealAnsiEscSeq        = get(g:, 'HiConcealAnsiEscSeq', 1)

let g:HiCfgEditWinApplyCfgKey    = get(g:, 'HiCfgEditWinApplyCfgKey', "<ENTER>")
let g:HiCfgEditWindowNormalSize  = get(g:, 'HiCfgEditWindowNormalSize', 65)
let g:HiCfgEditorWindowMinSize   = get(g:, 'HiCfgEditorWindowMinSize', 3)

let g:HiCheckPatternAvailable    = get(g:, 'HiCheckPatternAvailable', 1)


" Default match case option for color highlighting.
let g:HiDefaultCase              = get(g:, 'HiDefaultCase', "C")

" Autoload config line options:
" Example1: :vim_hi:cfg=MY_CONFIG
" Example2: :vim_hi:cfg=MY_CONFIG::cfgfile=MY_CONFIG_FILE
" Number of lines on top or bottom of the file where searching the auto config line.
let g:HiAutoConfigLineActive        = get(g:, 'HiAutoConfigLineActive', 1)
" Number of lines on top or bottom of the file where searching the auto config line.
let g:HiAutoConfigLineNumberOfLines = get(g:, 'HiAutoConfigLineNumberOfLines', 5)
" If 1, ask user permission to apply the highlight config
let g:HiAutoConfigLineUserConsent   = get(g:, 'HiAutoConfigLineUserConsent', 1)
" Search for autoload config line only on this files: 
let g:HiAutoConfigSearchOnFileTypes = get(g:, 'HiAutoConfigSearchOnFileTypes', "*.txt *.log")

" For a configuration file to be valid, a valid configuration must be found on the defined
" first header lines or tail lines of the file.
" When the config is embedded on the same file to highlight, this helps skip
" parsing the whole file.
let g:HiFileConfigCheckLinesMax     = get(g:, 'HiFileConfigCheckLinesMax', 150)

" PopUp menu options:
let g:HiUsePopUps                   = get(g:, 'HiUsePopUps', 1)

" Menu Window:
let g:hi_menu_headerColor          = get(g:, 'hi_menu_headerColor', "b")
let g:hi_menu_defaultLineColor     = get(g:, 'hi_menu_defaultLineColor', "y8")
let g:hi_menu_highlightDefaultLine = get(g:, 'hi_menu_highlightDefaultLine', "")


"- commands -------------------------------------------------------------------

" CURRENT CONFIG:
" Apply a highlighting color to a pattern.
"   Examples: 
"   Hic PATTERN g                                       : highlight green fg
"   Hic PATTERN g@                                      : highlight green bg
"   Hic PATTERN g!                                      : highlight green bold
"   Hic PATTERN g_                                      : highlight green underline
"   Hic PATTERN g*                                      : highlight green fg all line
"   Hic PATTERN g@*                                     : highlight green bg all line
"   Hic START_PATTERN>>CONTAINS_PATTERN>>END_PATTERN r& : highlight block in red
"   Hic START_PATTERN>>END_PATTERN r&                   : highlight block in red
command! -range -nargs=* -complete=customlist,hi#config#ColorsIDWildmenu Hic call hi#config#PatternColorize(<f-args>)
" Refresh the highlighting:
command! -nargs=0 Hir                call hi#hi#Refresh()

" Set highlighting on/off:
command! -nargs=0 Hi0                call hi#config#Off()
command! -nargs=0 Hioff              call hi#config#Off()
command! -nargs=0 Hi1                call hi#config#On()
command! -nargs=0 Hion               call hi#config#On()
command! -nargs=0 Hiw0               call hi#config#WindowOff()
command! -nargs=0 Hiwoff             call hi#config#WindowOff()
command! -nargs=0 Hiw1               call hi#config#WindowOn()
command! -nargs=0 Hiwon              call hi#config#WindowOn()

command! -nargs=0 Hioff              call hi#config#Off()
" Refresh highlighting on all windows of current tab.
command! -nargs=0 Hirw               call hi#hi#RefreshAllWindows()
" Remove a color highlight from current config.
command! -nargs=? Hicrm              call hi#config#RmColor(<q-args>)
" Save current highlight config
command! -nargs=* -complete=file -complete=customlist,hi#fileConfig#Wildmenu Hisv call hi#fileConfig#SaveCurrentHighlightCfg(<f-args>)
" Show current highlight config
command! -nargs=0 Hish               call hi#config#ShowCurrentHighlightCfg()
command! -nargs=0 Hish2              call hi#config2#ShowCurrentHighlightCfg()
" Open menu remove a highlight pattern from current config.
command! -nargs=0 Hirm               call hi#config#RmPattern()
" Undo last color highlighting applied.
command! -nargs=0 Hiu                call hi#config#RmLastPattern()
" Highlight word/whole word/line under cusrsor:
command! -nargs=0 HiWord             call hi#config#HighlightWord()
command! -nargs=0 HiWholeWord        call hi#config#HighlightWholeWord()
command! -nargs=1 HiLine             call hi#config#HighlightLine(<f-args>)
" Show filter patterns:
command! -nargs=0 Hishp              call hi#config#ShowPatterns()
" Get filter color identifiers:
command! -nargs=0 Hishc              call hi#config#GetHihglightColorIDs()
" Copy current config into default register
command! -nargs=? Hiy                call hi#config#ConfigYank("<args>")


" CONFIG EDITOR: 
" Open config editor
command! -nargs=0 Hie                call hi#configEditor#Open(0,"")
" Reload on base and filter windows the config modified on the editor window
command! -nargs=0 Hier               call hi#configEditor#ApplyConfig()
" Open a selected config type on the config editor.
command! -nargs=? -complete=customlist,hi#configTypes#Wildmenu Hiet   call hi#configEditor#EditConfigType(<q-args>)


" COLOR HELP:
" Show color help:
command! -nargs=* Hicol              call hi#help#ColorHelp(<q-args>)
" Show color ID help:
command! -nargs=* Hiid               call hi#help#ColorIdHelp(<q-args>)
" Show command help
command! -nargs=0 Hih                call hi#help#CommandHelp()
" Show command help
command! -nargs=0 Hihc               call hi#help#ConfigHelp()
" Show commands menu:
"command! -nargs=* Hi                 call hi#help#CommandMenu(<f-args>)
command! -nargs=?  Hi                call hi#helpMenu#LaunchCommandMenu("<args>")


" SAVED CONFIG TYPES:
" Show all highlighting config.
command! -nargs=? -complete=customlist,hi#configTypes#Wildmenu Hitsh   call hi#configTypes#ShowConfigType(<q-args>)
" Load a highlight config type.
command! -nargs=? -complete=customlist,hi#configTypes#Wildmenu Hit     call hi#configTypes#LoadConfigTypeMenu(<q-args>,1,1) " New function with screen menu.
command! -nargs=? -complete=customlist,hi#configTypes#Wildmenu Hitn    call hi#configTypes#LoadConfigType(<q-args>,1,1) " Old function, no menu available.
" Load last used highlight config.
command! -nargs=0 Hitl               call hi#configTypes#LastType()


" AUTOCONFIG LINE:
command! -nargs=0 Hia                call hi#autoConfig#ConfigLineSearchAndApplyConfig(0)


" HIGHLIGHT SEARCH:
" Search pattern and/or colorId
command! -nargs=* Hics               call hi#hi#Search("fordward", <q-args>)
command! -nargs=* Hicsb              call hi#hi#Search("backward", <q-args>)


" HGHILIGHT FILTER:
" Filter commands: open new window, with the requested highlights:
"   :Hif            open new filter window with all hightlighted lines
"   :Hif r          open new filter window with red hightlighted lines
"   :Hif r g        open new filter window with red and green hightlighted lines
"   :Hif r g@       open new filter window with red and background green hightlighted lines
"   :Hif r! g@      open new filter window with bold red and background green hightlighted lines
"   :Hif r! g_      open new filter window with bold red and underlined green hightlighted lines
"   :Hif !??        open new filter window with bold hightlighted lines
"   :Hif @??        open new filter window with background hightlighted lines
"   :Hif r*@??      open new filter window with all red background hightlighted lines
"   :Hif pattern    open new filter window with all pattern words found
"   :Hif pattern r  open new filter window with all pattern words found and all red highlighted words
command! -nargs=* Hif                call hi#filter#ColorSplitMenu(<q-args>, "", "")
"command! -nargs=* Hif                call hi#filter#Color(g:HiFilterSplit, <q-args>, "", "")
command! -nargs=* Hifs               call hi#filter#Color("new", <q-args>, "", "")
command! -nargs=* Hifv               call hi#filter#Color("vnew", <q-args>, "", "")
command! -nargs=* Hift               call hi#filter#Color("tabnew", <q-args>, "", "")
command! -nargs=* Hifn               call hi#filter#Color("enew", <q-args>, "", "")
command! -nargs=* Hifw               call hi#filter#Color("", <q-args>, "", "")

" Filter omitt pattern
command! -nargs=* Hio                call hi#filter#Color(g:HiFilterSplit, "", <q-args>, "")
command! -nargs=* Hios               call hi#filter#Color("new", "", <q-args>, "")
command! -nargs=* Hiov               call hi#filter#Color("vnew", "", <q-args>, "")
command! -nargs=* Hiot               call hi#filter#Color("tabnew", "", <q-args>, "")
command! -nargs=* Hion               call hi#filter#Color("enew", "", <q-args>, "")
command! -nargs=* Hiow               call hi#filter#Color("", "", <q-args>, "")

" Close all filter windows.
command! -nargs=0 HifC               call hi#windowFamily#CloseAll()

" Update filter window:
command! -nargs=0 Hiup               call hi#filterSynch#SyncFiltWindowData("update")


" CONFIG FILES:
" Open all highlight config files:
command! -nargs=0 Hicfg              call hi#fileConfig#TabOpen()
" Load highlight config file: 
command! -nargs=1 -complete=file Hil call hi#fileConfig#LoadConfigFile(<f-args>)
" Load highlight config file: 
command! -nargs=* -complete=file Hitf call hi#autoConfig#ApplyConfig(<f-args>)
" Force save to file current config on every change
command! -nargs=0 Hifs               call hi#fileConfig#ForceAutoSaveColorHiglighting()


" FOLDING:
command! -nargs=* -complete=customlist,hi#config#UsedPatternsWildmenu Hifold      call hi#fold#FoldPatterns(<q-args>)
command! -nargs=0 Hifoldsh           call hi#fold#ShowFoldExpr()


" FILTER AND MAIN WINDOWS POSITION SYNCHRONIZATION:
" Synchcronize position.
command! -nargs=* Hip                call hi#filterSynch#SyncWindowPosition(<q-args>)
" Synchcronize position and switch to son/parent window.
command! -nargs=* Hips               call hi#filterSynch#SyncSwitchWindowPosition("")
command! -nargs=* Hipsa              call hi#filterSynch#SyncSwitchWindowPosition("auto")
command! -nargs=* Hipsn              call hi#filterSynch#SyncSwitchWindowPosition("noauto")

" FILTER AND MAIN WINDOWS DATA SYNCHRONIZATION:
" Synchcronize position.
" Filter window data synch.
command! -nargs=0 Hid                call hi#filterSynch#SyncFiltWindowData("")
command! -nargs=0 Hidsa              call hi#filterSynch#SyncFiltWindowData("auto")
command! -nargs=0 Hidsn              call hi#filterSynch#SyncFiltWindowData("noauto")


" GOTO WINDOW: window family movements commands
" Goto first parent window:
command! -nargs=0 HigoP              call hi#windowFamily#GotoFirstParentWindow()
" Goto parent window:
command! -nargs=0 Higop              call hi#windowFamily#GotoParentWindow()
" Goto son window:
command! -nargs=0 Higos              call hi#windowFamily#GotoSonWindow()
" Goto last son window:
command! -nargs=0 HigoS              call hi#windowFamily#GotoLastSonWindow()

" TAIL FILE:
" Start/Stop tail for current file.
" Reload file periodically.
" Arg1: seconds, timer time to launch the refresh.
command! -nargs=? Hiut                call hi#tail#Run("<args>")

" Debug: show highlight update tail log.
command! -nargs=1  HiutDebug          call hi#tail#LogStatus("<args>")
command! -nargs=0  HiutLog            call hi#tail#GetLog()
command! -nargs=0  HiutTimes          call hi#tail#GetTimeLog()


" TEST AND  DEVELOPMENT:
" Change log verbosity level:
command! -nargs=? Hiv                call hi#log#SetVerbose("<args>")
command! -nargs=? Hivf               call hi#log#SetVerboseFile("<args>")

" Launch test:
command! -nargs=0 HitestEx0           call hi#test#Example0()
command! -nargs=0 Hitest001           call hi#test#TestBasicHighlight("test_basic_highlight")
command! -nargs=0 Hitest111           call hi#test#TestAgFilter("test_ag_filter")
command! -nargs=0 Hitest112           call hi#test#TestAgOmittFilter("test_ag_filter")
command! -nargs=0 Hitest121           call hi#test#TestGrepFilter("test_grep_filter")
command! -nargs=0 Hitest200           call hi#test#TestConfigEditor("test_config_editor")
command! -nargs=0 Hitestall           call hi#test#TestAll()

" RELEASE Tools: create new vimball release file.
command! -nargs=0  Hivba              call hi#hi#NewVimballRelease()

" EDIT Tools: edit plugin.
command! -nargs=0  Hiedit             call hi#hi#Edit()


"- mappings -------------------------------------------------------------------

if !hasmapto('Hic', 'n')
    " Highlight word
    nmap <unique> <leader>hw :Hic \\C<C-R>=escape(expand('<cword>'),' \')<CR>
    nmap <unique> <leader>hW :Hic \\C<C-R>=escape(expand('<cWORD>'),' \')<CR>

    " Highlight line
    nmap <unique> <leader>hl :Hic \\C<C-R>=escape(getline('.'),' \')<CR>
    " Highlight line background in red color
    nmap <unique> <leader>h0 :Hic \\C<C-R>=escape(getline('.'),' \')<CR>  r#<CR>
    " Highlight line background in yellow color
    nmap <unique> <leader>h1 :Hic \\C<C-R>=escape(getline('.'),' \')<CR>  y#<CR>
    " Highlight line background in green color
    nmap <unique> <leader>h2 :Hic \\C<C-R>=escape(getline('.'),' \')<CR>  g#<CR>
    " Highlight line background in blue color
    nmap <unique> <leader>h3 :Hic \\C<C-R>=escape(getline('.'),' \')<CR>  b#<CR>
    " Highlight line background in magenta color
    nmap <unique> <leader>h4 :Hic \\C<C-R>=escape(getline('.'),' \')<CR>  m#<CR>
    " Highlight line background in cyan color
    nmap <unique> <leader>h5 :Hic \\C<C-R>=escape(getline('.'),' \')<CR>  c#<CR>
endif

if !hasmapto('Hif', 'n')
    nmap <unique> <leader>hf :Hif<CR>
endif

if !hasmapto('Hips', 'n')
    nmap <unique> <leader>hp :Hip<CR>
    nmap <unique> <leader>hP :Hips<CR>
endif

if !hasmapto('Hid', 'n')
    nmap <unique> <leader>hd :Hid<CR>
endif

if !hasmapto('Hir', 'n')
    nmap <unique> <leader>hr  :Hir<CR>
endif

if !hasmapto('Hic', 'v')
    " Highlight visual selected text:
    vmap <leader>h  :<BS><BS><BS><BS><BS>Hic \\C<C-R>=hi#hi#getVisualSel()<CR>
endif

if !hasmapto('Hie', 'n')
    nmap <leader>he  :Hie<CR>
endif

"- abbreviations -------------------------------------------------------------------
"
" DEBUG: reload plugin
cnoreabbrev _hirl    <C-R>=hi#hi#Reload()<CR>

" DEBUG: show highlight update tail log.
"cnoreabbrev _hitl    :call hi#tail#GetLog()<CR>

" RELEASE Tools: regenerate color/hi.vim file with new colors added on
" autoload/hi/colors.vim
cnoreabbrev _hicol   <C-R>=hi#colors#CreateColorsFile()<CR>


"- menus -------------------------------------------------------------------

if has("gui_running")
    call hi#hi#CreateMenus('n'   , ''               , ":HitWord<CR>"             , 'highlight word under cursor'                   , s:leader.'hw')
    call hi#hi#CreateMenus('n'   , ''               , ':HiWholeWord<CR>'         , 'highlight whole word under cursor'             , s:leader.'hW')
    call hi#hi#CreateMenus('n'   , ''               , ':'                        , '-Sep-'                                         , '')
    call hi#hi#CreateMenus('n'   , ''               , ':HiLine r#<CR>'           , 'highlight line red'                            , s:leader.'h0')
    call hi#hi#CreateMenus('n'   , ''               , ':HiLine y#<CR>'           , 'highlight line yellow'                         , s:leader.'h1')
    call hi#hi#CreateMenus('n'   , ''               , ':HiLine g#<CR>'           , 'highlight line green'                          , s:leader.'h2')
    call hi#hi#CreateMenus('n'   , ''               , ':HiLine b#<CR>'           , 'highlight line blue'                           , s:leader.'h3')
    call hi#hi#CreateMenus('n'   , ''               , ':HiLine m#<CR>'           , 'highlight line magenta'                        , s:leader.'h4')
    call hi#hi#CreateMenus('n'   , ''               , ':HiLine c#<CR>'           , 'highlight line cyan'                           , s:leader.'h5')
    call hi#hi#CreateMenus('n'   , ''               , ':'                        , '-Sep2-'                                        , '')
    call hi#hi#CreateMenus('n'   , ''               , 'Hif<CR>'                  , 'open filter window'                            , s:leader.'hf')
    call hi#hi#CreateMenus('n'   , ''               , 'Hip<CR>'                  , 'synchonize filter position'                    , s:leader.'hp')
    call hi#hi#CreateMenus('n'   , ''               , 'Hips<CR>'                 , 'synchonize filter position switch window'      , s:leader.'hP')
    call hi#hi#CreateMenus('n'   , ''               , 'Hid<CR>'                  , 'synchonize filter data changes'                , s:leader.'hd')
    call hi#hi#CreateMenus('n'   , ''               , ':'                        , '-Sep3-'                                        , '')
    call hi#hi#CreateMenus('cn'  , ''               , 'Hir<CR>'                  , 'refresh highlighting'                          , 'Hir')
    call hi#hi#CreateMenus('cn'  , ''               , 'Hioff<CR>'                , 'disable highlighting'                          , 'Hioff')
    call hi#hi#CreateMenus('cn'  , ''               , 'Hion<CR>'                 , 'enable current window highlighting'            , 'Hion')
    call hi#hi#CreateMenus('cn'  , ''               , 'Hiwoff<CR>'               , 'disable current window highlighting'           , 'Hiwoff')
    call hi#hi#CreateMenus('cn'  , ''               , 'Hiwon<CR>'                , 'refresh highlighting'                          , 'Hiwon')
    call hi#hi#CreateMenus('cn'  , ''               , ':'                        , '-Sep4-'                                        , '')
    call hi#hi#CreateMenus('cn'  , '.&Config\ type' , ':Hit'                     , 'Load highlight type'                           , ":Hit")
    call hi#hi#CreateMenus('cn'  , '.&Config\ type' , ':Hitf'                    , 'Load highlight type and filter'                , ":Hitf")
    call hi#hi#CreateMenus('cn'  , '.&Config\ type' , ':Hish<CR>'                , 'Show highlight types'                          , ":Hicfg")
    call hi#hi#CreateMenus('cn'  , '.&Config\ type' , ':Hisv'                    , 'Save highlight type'                           , ":Hisv")
    call hi#hi#CreateMenus('cn'  , '.&Config\ type' , ':Hifsv'                   , 'Force save highlight type'                     , ":Hifsv")
    call hi#hi#CreateMenus('cn'  , '.&Color\ help'  , ':Hicol'                   , 'Highlight color help'                          , ":Hicol")
    call hi#hi#CreateMenus('cn'  , '.&Color\ help'  , ':Hiid'                    , 'Highlight color ID help'                       , ":Hiid")
    call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hic'                     , 'Apply color highlight'                         , ":Hic")
    call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hirm'                    , 'Remove all highlights'                         , ":Hirm")
    call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hiu'                     , 'Undo last highlight'                           , ":Hiu")
    call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hish'                    , 'Show current file highlight config'            , ":Hish")
    call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hishp'                   , 'Show current file highlight patterns'          , ":Hishp")
    call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hicrm'                   , 'Highlight color remove'                        , ":Hicrm")
    "call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hics'                    , 'Highlight color search'                        , ":Hics")
    call hi#hi#CreateMenus('cn'  , '.&Edit'         , ':Hics'                    , 'Highlight color search'                        , ":Hics")
    call hi#hi#CreateMenus('cn'  , '.&ConfigEditor' , ':Hie'                     , 'Open current config on hteeditor window'       , ":Hie")
    call hi#hi#CreateMenus('cn'  , '.&ConfigEditor' , ':Hier'                    , 'Apply the config on the editor window'         , ":Hier")
    call hi#hi#CreateMenus('cn'  , '.&ConfigEditor' , ':Hiet'                    , 'Select a config and open on the editor window' , ":Hier")
    call hi#hi#CreateMenus('cn'  , '.&Folding'      , ':Hif'                     , 'Perform fold'                                  , ":Hifold")
    call hi#hi#CreateMenus('cn'  , '.&Folding'      , ':Hifsh<CR>'               , 'Show folding patterns'                         , ":Hifoldsh")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hif'                     , 'Open highlights on a new split'                , ":Hif")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hifs'                    , 'Open highlights on a new hsplit'               , ":Hifs")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hifv'                    , 'Open highlights on a new vsplit'               , ":Hifv")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hift'                    , 'Open highlights on a new tab'                  , ":Hift")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hifn'                    , 'Open highlights on a new buffer'               , ":Hifn")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hifw'                    , 'open highlights on the current window'         , ":Hifw")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':HifC'                    , 'close all highlight window'                    , ":HifC")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':'                        , '-Sep5-'                                        , '')
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hip<CR>'                 , 'Synchcronize position'                         , ":Hip")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hips<CR>'                , 'Synchonize position and switch window'         , ":Hips")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hipsa<CR>'               , 'Enable position auto synchonize'               , ":Hipsa")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hipsn<CR>'               , 'Disable position auto synchonize'              , ":Hipsn")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':'                        , '-Sep6-'                                        , '')
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hid<CR>'                 , 'Sychcronize data changes'                      , ":Hids")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hid<CR>'                 , 'Enable data change auto synchonize'            , ":Hidsa")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hidn<CR>'                , 'Disable data changes auto synchonize'          , ":Hidsn")
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':'                        , '-Sep7-'                                        , '')
    call hi#hi#CreateMenus('cn'  , '.&Filter'       , ':Hiup<CR>'                , 'Update main and filtered buffer contents'      , ":Hiup")
    call hi#hi#CreateMenus('cn'  , '.&Reload'       , ':Hir<CR>'                 , 'Reload the highlighting'                       , ":Hir")
    call hi#hi#CreateMenus('cn'  , '.&Reload'       , ':Hiut [SECONDS]'          , 'Tail mode, start/stop the periodical buffer reload' , ":Hiut")
    "call hi#hi#CreateMenus('cn' , '.&Refresh'      , ':Hir<CR>:Hif'             , 'Highlight refresh and open filter'             , ":Hirf")
    "call hi#hi#CreateMenus('cn' , '.&Refresh'      , ':Hir<CR>:HifFiltSync<CR>' , 'Highlight refresh and sync filter'             , ":Hirs")
endif

call hi#autoConfig#Init()

let &cpo = s:save_cpo
unlet s:save_cpo
