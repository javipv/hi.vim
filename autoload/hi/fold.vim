" Script Name: hi/fold.vim
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


" Choose folding level on current line
function! s:MarkdownFolds(foldexpr)
    if a:foldexpr == ""
        return 0
    endif

    if matchstr( getline(v:lnum), a:foldexpr ) != ""
        return 0
    else
       if matchstr( getline(v:lnum-1), a:foldexpr) != "" || matchstr( getline(v:lnum+1), a:foldexpr) != ""
           return 1
       else
          return 2
       endif
    endif
endfunction



" Fold file using patterns from the selected colors
" Command: Hifold
function! hi#fold#Colors(colors)
    let separator = "###"

    let patterns = s:GetColorPatterns(a:colors,l:separator,"")
    if l:patterns == ""
        call hi#log#Warn("Empty search ".a:colors)
        return
    endif

    call hi#log#Warn("Attention: on large files this could take several minuts")

    let tmp = substitute(l:patterns, l:separator, ', ', 'g')
    call confirm("Fold patterns: ".l:tmp)
    redraw
    echo "This may take a while ..."

    let w:foldexpr = substitute(l:patterns, l:separator, '\\|', 'g')
    setlocal foldmethod=expr
    setlocal foldexpr=s:MarkdownFolds(w:foldexpr)

    " Set fold colors
    hi Folded term=NONE cterm=NONE gui=NONE ctermbg=DarkGrey

    " Remove fold padding charactesr -----
    setlocal fillchars="vert:|,fold: "
    setlocal foldtext="..."
    setlocal foldlevel=0
    setlocal foldcolumn=0
endfunction


" Fold file using selected patterns
function! hi#fold#FoldPatterns(patterns)
    if a:patterns == ""
        let separator = "###"

        let patterns = s:GetColorPatterns("",l:separator,"")
        if l:patterns == ""
            call hi#log#Warn("Empty search ".a:patterns)
            return
        endif

        call hi#log#Warn("Attention: on large files this could take several minuts")

        let tmp = substitute(l:patterns, l:separator, ', ', 'g')
        call confirm("Fold patterns: ".l:tmp)
        redraw
        echo "This may take a while ..."

        let w:foldexpr = substitute(l:patterns, l:separator, '\\|', 'g')
    else
        let w:foldexpr = substitute(a:patterns, ' ', '\\|', 'g')
    endif

    setlocal foldmethod=expr
    setlocal foldexpr=s:MarkdownFolds(w:foldexpr)

    " Set fold colors
    hi Folded term=NONE cterm=NONE gui=NONE ctermbg=DarkGrey

    " Remove fold padding charactesr -----
    setlocal fillchars="vert:|,fold: "
    setlocal foldtext="..."
    setlocal foldlevel=0
    setlocal foldcolumn=0
endfunction


" Show patterns used for folding.
" Commands: Hifoldsh
function! hi#fold#ShowFoldExpr()
    if !exists('w:foldexpr')
        call hi#log#Warn("Fold patterns not found.")
        return
    endif
    echo "Fold expr: ".substitute(w:foldexpr, '\\|', ' ', 'g')
endfunction





"- initializations ------------------------------------------------------------

call hi#hi#Initialize()
