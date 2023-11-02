" Script Name: hi/test.vim
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


func! s:NewExampleTestTab(buffname)
    tabnew
    let text = "Example pattern1\n"
    let text .= "Some more text with no highlights\n"
    let text .= "Example pattern2\n"
    let text .= "EXAMPLE PATTERN3\n"
    let text .= "Example pattern4\n"
    let text .= "Some more text with no highlights\n"
    let text .= "Example pattern5\n"
    let text .= "Example pattern6\n"
    let text .= "Some more text with no highlights\n"
    let text .= "Example pattern7\n"
    let text .= "Example pattern8\n"
    let text .= "Some more text with no highlights\n"
    let text .= "Some more text with no highlights\n"
    let text .= "Example pattern9\n"
    let text .= "This is my pattern_10 example number 10\n"
    let text .= "Example pattern_11 add to filter without highlighting\n"
    let text .= "Some more text with no highlights\n"
    let text .= "Some more text with no highlights\n"
    let text .= "Example pattern_12\n"
    let text .= "Example pattern_13\n"
    let text .= "Example pattern_14\n"

    silent put = l:text
    if a:buffname != ""
        silent! exec 'bd! '.a:buffName
        silent! exec '0file | file '.a:buffname
    endif
endfunc


func! hi#test#Example0()
    call s:NewExampleTestTab("hi#test#Example0")

    let config  = ""
    let config .= "\n"
    let config .= "#------------------------------------------\n"
    let config .= "# Clean previous highlights and filters\n"
    let config .= "Conf = clear\n"
    let config .= "Filt = close\n"
    let config .= "#------------------------------------------\n"
    let config .= "# Highlight commands:\n"
    let config .= "Mark = r    | C    |pattern1\n"
    let config .= "Mark = g    | C    |pattern2\n"
    let config .= "Mark = g2   | C    |PATTERN3\n"
    let config .= "Mark = g5   | c    |Pattern4\n"
    let config .= "Mark = y!   | C    |pattern5\n"
    let config .= "Mark = m_   | C    |pattern6\n"
    let config .= "Mark = v@   | C    |pattern7\n"
    let config .= "Mark = v    | Cl   |pattern8\n"
    let config .= "Mark = r@   | Cl   |pattern9\n"
    let config .= "Mark = g4   | C    |my.*pattern_10\n"
    let config .= "Mark = n    | C    |pattern_11\n"
    let config .= "Mark = b3!  | C    |pattern_12\n"
    let config .= "Mark = c3_  | C    |pattern_13\n"
    let config .= "Mark = c3_  | Cl   |pattern_14\n"
    let config .= "Mark = c    | CT   |6\n"
    let config .= "Mark = c@   | CT   |8\n"
    let config .= "#------------------------------------------\n"
    let config .= "# Open filter window:\n"
    let config .= "Filt = all\n"
    let config .= "# New filter window from data inside previous filter window:\n"
    let config .= "Filt = !?? _??\n"

    echom "Open config editor"
    exec 'Hie'
    " Remove previous comented config example 
    silent g/#.*=/d
    call search("HIGHLIGHT")
    normal j
    " Add new config
    echom "Change editor config"
    silent put = l:config
    normal o
    " Apply changes on config editor window
    exec 'Hier'
endfunc


func! s:NewBasicTestTab(buffname)
    tabnew
    let randomText="Him rendered may attended concerns jennings reserved now. Sympathize did now preference unpleasing mrs few. Mrs\nfor hour game room want are fond dare. For detract charmed add talking age. Shy resolution instrument unreserved\nman few. She did open find pain some out. If we landlord stanhill mr whatever pleasure supplied concerns so.\nExquisite by it admitting cordially september newspaper an. Acceptance middletons am it favourable. It it oh\nhappen lovers afraid. \n\nOh acceptance apartments up sympathize astonished delightful. Waiting him new lasting\ntowards. Continuing melancholy especially so to. Me unpleasing impossible in attachment announcing so astonished.\nWhat ask leaf may nor upon door. Tended remain my do stairs. Oh smiling amiable am so visited cordial in offices\nhearted.  \n\nUnpacked now declared put you confined daughter improved. Celebrated imprudence few interested\nespecially reasonable off one. Wonder bed elinor family secure met. It want gave west into high no in. Depend\nrepair met before man admire see and. An he observe be it covered delight hastily message. Margaret no ladyship\nendeavor ye to settling.  \n\nSo insisted received is occasion advanced honoured. Among ready to which up.\nAttacks smiling and may out assured moments man nothing outward. Thrown any behind afford either the set depend\none temper. Instrument melancholy in acceptance collecting frequently be if. Zealously now pronounce existence\nadd you instantly say offending. Merry their far had widen was. Concerns no in expenses raillery formerly.  \n\nAn sincerity so extremity he additions. Her yet there truth merit. Mrs all projecting favourable now unpleasing.\nSon law garden chatty temper. Oh children provided to mr elegance marriage strongly. Off can admiration prosperous\nnow devonshire diminution law.  \n\nBed sincerity yet therefore forfeited his certainty neglected questions.\nPursuit chamber as elderly amongst on. Distant however warrant farther to of. My justice wishing prudent waiting\nin be. Comparison age not pianoforte increasing delightful now. Insipidity sufficient dispatched any reasonably\nled ask. Announcing if attachment resolution sentiments admiration me on diminution.  \n\nHis exquisite sincerity\neducation shameless ten earnestly breakfast add. So we me unknown as improve hastily sitting forming. Especially\nfavourable compliment but thoroughly unreserved saw she themselves. Sufficient impossible him may ten insensible\nput continuing. Oppose exeter income simple few joy cousin but twenty. Scale began quiet up short wrong in in.\nSportsmen shy forfeited engrossed may can.  \n\nEndeavor bachelor but add eat pleasure doubtful sociable. Age\nforming covered you entered the examine. Blessing scarcely confined her contempt wondered shy. Dashwoods contented\nsportsmen at up no convinced cordially affection. Am so continued resembled frankness disposing engrossed dashwoods.\nEarnest greater on no observe fortune norland. Hunted mrs ham wishes stairs. Continued he as so breakfast shameless.\nAll men drew its post knew. Of talking of calling however civilly wishing resolve.  \n\nAssure polite his really\nand others figure though. Day age advantages end sufficient eat expression travelling. Of on am father by agreed\nsupply rather either. Own handsome delicate its property mistress her end appetite. Mean are sons too sold nor\nsaid. Son share three men power boy you. Now merits wonder effect garret own.  \n\nFull he none no side.\nUncommonly surrounded considered for him are its. It we is read good soon. My to considered delightful invitation\nannouncing of no decisively boisterous. Did add dashwoods deficient man concluded additions resources. Or landlord\npackages overcame distance smallest in recurred. Wrong maids or be asked no on enjoy. Household few sometimes out\nattending described. Lain just fact four of am meet high."
    silent put = l:randomText
    if a:buffname != ""
        silent! exec 'bd! '.a:buffName
        silent! exec '0file | file '.a:buffname
    endif
endfunc


func! hi#test#TestBasicHighlight(buffName)
    call s:NewBasicTestTab(a:buffName)

    echom "Highlight patterns:"
    exec 'Hic \CHim g'
    exec 'Hic \Crendered\ may b'
    exec 'Hic \Cattended. y'
    exec 'Hic \Sympathize. m'
    exec 'Hic \Cpreference r!'
    exec 'Hic \Cunpleasing b_'
    exec 'Hic \CMrs g@'
    exec 'Hic \COh\ accept g*'
    exec 'Hic \Ctowards. y@*'
endfunc


func! hi#test#TestAgFilter(buffName)
    let l:HiAgGrepFilter = g:HiAgGrepFilter
    let l:HiAgGrepFilter = 1
    let l:HiUseGrep = g:HiUseGrep
    let g:HiUseGrep = 1

    call hi#test#TestBasicHighlight("")
    silent! exec 'bd! '.a:buffName
    exec '0file | file '.a:buffName

    echom "Open config editor"
    exec 'Hie'
    echom "Goto first parent window"
    exec 'HigoP'
    echom "Peform highlight filter"
    exec 'Hif'

    let g:HiUseGrep = l:HiUseGrep
    let g:HiAgGrepFilter = l:HiAgGrepFilter
endfunc


func! hi#test#TestAgOmittFilter(buffName)
    let l:HiAgGrepFilter = g:HiAgGrepFilter
    let l:HiAgGrepFilter = 1
    let l:HiUseGrep = g:HiUseGrep
    let g:HiUseGrep = 1

    call hi#test#TestBasicHighlight("")
    silent! exec 'bd! '.a:buffName
    exec '0file | file '.a:buffName

    echom "Peform highlight filter"
    exec 'Hifo g b y m'

    let g:HiUseGrep = l:HiUseGrep
    let g:HiAgGrepFilter = l:HiAgGrepFilter
endfunc


func! hi#test#TestGrepFilter(buffName)
    echom "Config filter to use grep"
    let l:HiAgGrepFilter = g:HiAgGrepFilter
    let l:HiAgGrepFilter = 1
    let l:HiUseGrep = g:HiUseGrep
    let g:HiUseGrep = 0

    call hi#test#TestBasicHighlight("")
    silent! exec 'bd! '.a:buffName
    exec '0file | file '.a:buffName

    let g:HiUseGrep = l:HiUseGrep
    let g:HiAgGrepFilter = l:HiAgGrepFilter
endfunc


func! hi#test#TestConfigEditor(buffName)
    call s:NewBasicTestTab("")
    silent! exec 'bd! '.a:buffName
    exec '0file | file '.a:buffName

    let config  = ""
    let config .= "#--------------------------\n"
    let config .= "# Init commands\n"
    let config .= "#--------------------------\n"
    let config .= "Conf = clear\n"
    let config .= "Filt = close\n"
    let config .= "#--------------------------\n"
    let config .= "# Color highlight config\n"
    let config .= "#--------------------------\n"
    let config .= "Mark = g   | C   |Him\n"
    let config .= "Mark = b   | C   |rendered may\n"
    let config .= "Mark = y   | C   |attended.\n"
    let config .= "Mark = m   |     |\Sympathize.\n"
    let config .= "Mark = r!  | C   |preference\n"
    let config .= "Mark = b_  | C   |unpleasing\n"
    let config .= "Mark = g@  | C   |Mrs\n"
    let config .= "Mark = g   | lC  |Oh accept\n"
    let config .= "Mark = y@  | lC  |towards.\n"
    let config .= "#--------------------------\n"
    let config .= "# End commands\n"
    let config .= "#--------------------------\n"
    let config .= "Filt = all\n"

    echom "Open config editor"
    exec 'Hie'
    " Remove previous comented config example 
    silent g/#.*=/d
    call search("HIGHLIGHT")
    normal j
    " Add new config
    echom "Change editor config"
    silent put = l:config
    normal o
    " Apply changes on config editor window
    exec 'Hier'
endfunc


func! hi#test#TestAll()
    call hi#test#TestBasicHighlight("test_basic_highlight")
    call hi#test#TestAgFilter("test_ag_filter")
    call hi#test#TestGrepFilter("test_grep_filter")
    call hi#test#TestConfigEditor("test_config_editor")
endfunc



"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
