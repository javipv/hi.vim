" Script Name: hi.vim
 "Description: Highlight patterns in different colors. 
 "Allows to save, reload and modify the highlighting configuration.
"
" Copyright:   (C) 2017-2018 Javier Puigdevall Garcia
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:  Javier Garcia Puigdevall <javierpuigdevall@gmail.com>
" Contributors:
"
" Dependencies:
"
" Version:      2.0.3
" Changes:
" 2.0.3 	Thu, 03 Sep 20.     JPuigdevall
"   - New: add on term config 256, colors N1...N8 N1!...N8! N1_...N8_ N1@...N8@ N1@!...N8@!
"   - New: add on gui config, colors: N1...N6 N1!...N6! N1_...N6_ N1@...N6@ N1@!...N6@!
"   - New: align columns.
" 2.0.0 	Tue, 21 May 20.     JPuigdevall
"   - New: change file name from highlightFilter.vim to hi.vim
" 1.0.4 	Wed, 17 May 19.     JPuigdevall
"   - Change all # to @
" 1.0.2 	Wed, 20 Feb 19.     JPuigdevall
" 1.0.1 	Tue, 12 Feb 19.     JPuigdevall
" 1.0.0 	Sun, 10 Feb 19.     JPuigdevall
"   - Initial realease.

if has("gui_running")
    echom "HighlightMatch Gui config"

    highlight! HiColorN     gui=none      guibg=bg              guifg=fg
    highlight! HiColorN1    gui=none      guibg=bg              guifg=fg
    highlight! HiColorN2    gui=none      guibg=bg              guifg=fg
    highlight! HiColorN3    gui=none      guibg=bg              guifg=fg
    highlight! HiColorN4    gui=none      guibg=bg              guifg=fg
    highlight! HiColorN5    gui=none      guibg=bg              guifg=fg
    highlight! HiColorN6    gui=none      guibg=bg              guifg=fg
    highlight! HiColorN7    gui=none      guibg=bg              guifg=fg
    highlight! HiColorW1    gui=none      guibg=bg              guifg=snow
    highlight! HiColorW2    gui=none      guibg=bg              guifg=WhiteSmoke
    highlight! HiColorW3    gui=none      guibg=bg              guifg=FloralWhite
    highlight! HiColorW4    gui=none      guibg=bg              guifg=OldLace
    highlight! HiColorW5    gui=none      guibg=bg              guifg=linen
    highlight! HiColorW7    gui=none      guibg=bg              guifg=AntiqueWhite
    highlight! HiColorW     gui=none      guibg=bg              guifg=white
    highlight! HiColorY1    gui=none      guibg=bg              guifg=khaki
    highlight! HiColorY2    gui=none      guibg=bg              guifg=PaleGoldenrod
    highlight! HiColorY     gui=none      guibg=bg              guifg=yellow
    highlight! HiColorY3    gui=none      guibg=bg              guifg=gold
    highlight! HiColorY4    gui=none      guibg=bg              guifg=LightGoldenrod
    highlight! HiColorY5    gui=none      guibg=bg              guifg=goldenrod
    highlight! HiColorY6    gui=none      guibg=bg              guifg=DarkGoldenrod
    highlight! HiColorG1    gui=none      guibg=bg              guifg=DarkGreen
    highlight! HiColorG2    gui=none      guibg=bg              guifg=SeaGreen
    highlight! HiColorG3    gui=none      guibg=bg              guifg=MediumSeaGreen
    highlight! HiColorG4    gui=none      guibg=bg              guifg=PaleGreen
    highlight! HiColorG5    gui=none      guibg=bg              guifg=SpringGreen
    highlight! HiColorG6    gui=none      guibg=bg              guifg=LawnGreen
    highlight! HiColorG     gui=none      guibg=bg              guifg=green
    highlight! HiColorB1    gui=none      guibg=bg              guifg=NavyBlue
    highlight! HiColorB2    gui=none      guibg=bg              guifg=RoyalBlue
    highlight! HiColorB     gui=none      guibg=bg              guifg=blue
    highlight! HiColorB3    gui=none      guibg=bg              guifg=DodgerBlue
    highlight! HiColorB4    gui=none      guibg=bg              guifg=DeepSkyBlue
    highlight! HiColorB5    gui=none      guibg=bg              guifg=skyBlue
    highlight! HiColorB6    gui=none      guibg=bg              guifg=SteelBlue
    highlight! HiColorM     gui=none      guibg=bg              guifg=magenta
    highlight! HiColorM1    gui=none      guibg=bg              guifg=orchid
    highlight! HiColorM2    gui=none      guibg=bg              guifg=MediumOrchid
    highlight! HiColorM3    gui=none      guibg=bg              guifg=DarkOrchid
    highlight! HiColorM5    gui=none      guibg=bg              guifg=purple
    highlight! HiColorM6    gui=none      guibg=bg              guifg=MediumPurple
    highlight! HiColorC1    gui=none      guibg=bg              guifg=PaleTurquoise
    highlight! HiColorC2    gui=none      guibg=bg              guifg=DarkTurquoise
    highlight! HiColorC3    gui=none      guibg=bg              guifg=DarkTurquoise
    highlight! HiColorC4    gui=none      guibg=bg              guifg=MediumTurquoise
    highlight! HiColorC5    gui=none      guibg=bg              guifg=turquoise
    highlight! HiColorC     gui=none      guibg=bg              guifg=cyan
    highlight! HiColorC6    gui=none      guibg=bg              guifg=aquamarine
    highlight! HiColorV1    gui=none      guibg=bg              guifg=PaleVioletRed
    highlight! HiColorV2    gui=none      guibg=bg              guifg=VioletRed
    highlight! HiColorV3    gui=none      guibg=bg              guifg=HotPink
    highlight! HiColorV4    gui=none      guibg=bg              guifg=DeepPink
    highlight! HiColorV     gui=none      guibg=bg              guifg=violet
    highlight! HiColorV5    gui=none      guibg=bg              guifg=DarkViolet
    highlight! HiColorV6    gui=none      guibg=bg              guifg=BlueViolet
    highlight! HiColorO1    gui=none      guibg=bg              guifg=DarkSalmon
    highlight! HiColorO2    gui=none      guibg=bg              guifg=salmon
    highlight! HiColorO3    gui=none      guibg=bg              guifg=LightSalmon
    highlight! HiColorO     gui=none      guibg=bg              guifg=orange
    highlight! HiColorO4    gui=none      guibg=bg              guifg=DarkOrange
    highlight! HiColorO5    gui=none      guibg=bg              guifg=coral
    highlight! HiColorO6    gui=none      guibg=bg              guifg=LightCoral
    highlight! HiColorR1    gui=none      guibg=bg              guifg=IndianRed
    highlight! HiColorR2    gui=none      guibg=bg              guifg=firebrick
    highlight! HiColorR3    gui=none      guibg=bg              guifg=tomato
    highlight! HiColorR4    gui=none      guibg=bg              guifg=OrangeRed
    highlight! HiColorR     gui=none      guibg=bg              guifg=red
    highlight! HiColorR5    gui=none      guibg=bg              guifg=DarkRed
    highlight! HiColorR6    gui=none      guibg=bg              guifg=maroon
    highlight! HiColorBR1   gui=none      guibg=bg              guifg=RosyBrown
    highlight! HiColorBR2   gui=none      guibg=bg              guifg=SaddleBrown
    highlight! HiColorBR3   gui=none      guibg=bg              guifg=sienna
    highlight! HiColorBR4   gui=none      guibg=bg              guifg=peru
    highlight! HiColorBR    gui=none      guibg=bg              guifg=burlywood
    highlight! HiColorBR5   gui=none      guibg=bg              guifg=SandyBrown
    highlight! HiColorBR6   gui=none      guibg=bg              guifg=chocolate
    highlight! HiColorNB    gui=bold      guibg=bg              guifg=fg
    highlight! HiColorN1B   gui=bold      guibg=bg              guifg=fg
    highlight! HiColorN2B   gui=bold      guibg=bg              guifg=fg
    highlight! HiColorN3B   gui=bold      guibg=bg              guifg=fg
    highlight! HiColorN4B   gui=bold      guibg=bg              guifg=fg
    highlight! HiColorN5B   gui=bold      guibg=bg              guifg=fg
    highlight! HiColorN6B   gui=bold      guibg=bg              guifg=fg
    highlight! HiColorN7B   gui=bold      guibg=bg              guifg=fg
    highlight! HiColorW1B   gui=bold      guibg=bg              guifg=snow
    highlight! HiColorW2B   gui=bold      guibg=bg              guifg=WhiteSmoke
    highlight! HiColorW3B   gui=bold      guibg=bg              guifg=FloralWhite
    highlight! HiColorW4B   gui=bold      guibg=bg              guifg=OldLace
    highlight! HiColorW5B   gui=bold      guibg=bg              guifg=linen
    highlight! HiColorW7B   gui=bold      guibg=bg              guifg=AntiqueWhite
    highlight! HiColorWB    gui=bold      guibg=bg              guifg=white
    highlight! HiColorY1B   gui=bold      guibg=bg              guifg=khaki
    highlight! HiColorY2B   gui=bold      guibg=bg              guifg=PaleGoldenrod
    highlight! HiColorYB    gui=bold      guibg=bg              guifg=yellow
    highlight! HiColorY3B   gui=bold      guibg=bg              guifg=gold
    highlight! HiColorY4B   gui=bold      guibg=bg              guifg=LightGoldenrod
    highlight! HiColorY5B   gui=bold      guibg=bg              guifg=goldenrod
    highlight! HiColorY6B   gui=bold      guibg=bg              guifg=DarkGoldenrod
    highlight! HiColorG1B   gui=bold      guibg=bg              guifg=DarkGreen
    highlight! HiColorG2B   gui=bold      guibg=bg              guifg=SeaGreen
    highlight! HiColorG3B   gui=bold      guibg=bg              guifg=MediumSeaGreen
    highlight! HiColorG4B   gui=bold      guibg=bg              guifg=PaleGreen
    highlight! HiColorG5B   gui=bold      guibg=bg              guifg=SpringGreen
    highlight! HiColorG6B   gui=bold      guibg=bg              guifg=LawnGreen
    highlight! HiColorGB    gui=bold      guibg=bg              guifg=green
    highlight! HiColorB1B   gui=bold      guibg=bg              guifg=NavyBlue
    highlight! HiColorB2B   gui=bold      guibg=bg              guifg=RoyalBlue
    highlight! HiColorBB    gui=bold      guibg=bg              guifg=blue
    highlight! HiColorB3B   gui=bold      guibg=bg              guifg=DodgerBlue
    highlight! HiColorB4B   gui=bold      guibg=bg              guifg=DeepSkyBlue
    highlight! HiColorB5B   gui=bold      guibg=bg              guifg=skyBlue
    highlight! HiColorB6B   gui=bold      guibg=bg              guifg=SteelBlue
    highlight! HiColorMB    gui=bold      guibg=bg              guifg=magenta
    highlight! HiColorM1B   gui=bold      guibg=bg              guifg=orchid
    highlight! HiColorM2B   gui=bold      guibg=bg              guifg=MediumOrchid
    highlight! HiColorM3B   gui=bold      guibg=bg              guifg=DarkOrchid
    highlight! HiColorM5B   gui=bold      guibg=bg              guifg=purple
    highlight! HiColorM6B   gui=bold      guibg=bg              guifg=MediumPurple
    highlight! HiColorC1B   gui=bold      guibg=bg              guifg=PaleTurquoise
    highlight! HiColorC2B   gui=bold      guibg=bg              guifg=DarkTurquoise
    highlight! HiColorC3B   gui=bold      guibg=bg              guifg=DarkTurquoise
    highlight! HiColorC4B   gui=bold      guibg=bg              guifg=MediumTurquoise
    highlight! HiColorC5B   gui=bold      guibg=bg              guifg=turquoise
    highlight! HiColorCB    gui=bold      guibg=bg              guifg=cyan
    highlight! HiColorC6B   gui=bold      guibg=bg              guifg=aquamarine
    highlight! HiColorV1B   gui=bold      guibg=bg              guifg=PaleVioletRed
    highlight! HiColorV2B   gui=bold      guibg=bg              guifg=VioletRed
    highlight! HiColorV3B   gui=bold      guibg=bg              guifg=HotPink
    highlight! HiColorV4B   gui=bold      guibg=bg              guifg=DeepPink
    highlight! HiColorVB    gui=bold      guibg=bg              guifg=violet
    highlight! HiColorV5B   gui=bold      guibg=bg              guifg=DarkViolet
    highlight! HiColorV6B   gui=bold      guibg=bg              guifg=BlueViolet
    highlight! HiColorO1B   gui=bold      guibg=bg              guifg=DarkSalmon
    highlight! HiColorO2B   gui=bold      guibg=bg              guifg=salmon
    highlight! HiColorO3B   gui=bold      guibg=bg              guifg=LightSalmon
    highlight! HiColorOB    gui=bold      guibg=bg              guifg=orange
    highlight! HiColorO4B   gui=bold      guibg=bg              guifg=DarkOrange
    highlight! HiColorO5B   gui=bold      guibg=bg              guifg=coral
    highlight! HiColorO6B   gui=bold      guibg=bg              guifg=LightCoral
    highlight! HiColorR1B   gui=bold      guibg=bg              guifg=IndianRed
    highlight! HiColorR2B   gui=bold      guibg=bg              guifg=firebrick
    highlight! HiColorR3B   gui=bold      guibg=bg              guifg=tomato
    highlight! HiColorR4B   gui=bold      guibg=bg              guifg=OrangeRed
    highlight! HiColorRB    gui=bold      guibg=bg              guifg=red
    highlight! HiColorR5B   gui=bold      guibg=bg              guifg=DarkRed
    highlight! HiColorR6B   gui=bold      guibg=bg              guifg=maroon
    highlight! HiColorBR1B  gui=bold      guibg=bg              guifg=RosyBrown
    highlight! HiColorBR2B  gui=bold      guibg=bg              guifg=SaddleBrown
    highlight! HiColorBR3B  gui=bold      guibg=bg              guifg=sienna
    highlight! HiColorBR4B  gui=bold      guibg=bg              guifg=peru
    highlight! HiColorBRB   gui=bold      guibg=bg              guifg=burlywood
    highlight! HiColorBR5B  gui=bold      guibg=bg              guifg=SandyBrown
    highlight! HiColorBR6B  gui=bold      guibg=bg              guifg=chocolate
    highlight! HiColorNU    gui=underline guibg=bg              guifg=fg
    highlight! HiColorN1U   gui=underline guibg=bg              guifg=fg
    highlight! HiColorN2U   gui=underline guibg=bg              guifg=fg
    highlight! HiColorN3U   gui=underline guibg=bg              guifg=fg
    highlight! HiColorN4U   gui=underline guibg=bg              guifg=fg
    highlight! HiColorN5U   gui=underline guibg=bg              guifg=fg
    highlight! HiColorN6U   gui=underline guibg=bg              guifg=fg
    highlight! HiColorN7U   gui=underline guibg=bg              guifg=fg
    highlight! HiColorW1U   gui=underline guibg=bg              guifg=snow
    highlight! HiColorW2U   gui=underline guibg=bg              guifg=WhiteSmoke
    highlight! HiColorW3U   gui=underline guibg=bg              guifg=FloralWhite
    highlight! HiColorW4U   gui=underline guibg=bg              guifg=OldLace
    highlight! HiColorW5U   gui=underline guibg=bg              guifg=linen
    highlight! HiColorW7U   gui=underline guibg=bg              guifg=AntiqueWhite
    highlight! HiColorWU    gui=underline guibg=bg              guifg=white
    highlight! HiColorY1U   gui=underline guibg=bg              guifg=khaki
    highlight! HiColorY2U   gui=underline guibg=bg              guifg=PaleGoldenrod
    highlight! HiColorYU    gui=underline guibg=bg              guifg=yellow
    highlight! HiColorY3U   gui=underline guibg=bg              guifg=gold
    highlight! HiColorY4U   gui=underline guibg=bg              guifg=LightGoldenrod
    highlight! HiColorY5U   gui=underline guibg=bg              guifg=goldenrod
    highlight! HiColorY6U   gui=underline guibg=bg              guifg=DarkGoldenrod
    highlight! HiColorG1U   gui=underline guibg=bg              guifg=DarkGreen
    highlight! HiColorG2U   gui=underline guibg=bg              guifg=SeaGreen
    highlight! HiColorG3U   gui=underline guibg=bg              guifg=MediumSeaGreen
    highlight! HiColorG4U   gui=underline guibg=bg              guifg=PaleGreen
    highlight! HiColorG5U   gui=underline guibg=bg              guifg=SpringGreen
    highlight! HiColorG6U   gui=underline guibg=bg              guifg=LawnGreen
    highlight! HiColorGU    gui=underline guibg=bg              guifg=green
    highlight! HiColorB1U   gui=underline guibg=bg              guifg=NavyBlue
    highlight! HiColorB2U   gui=underline guibg=bg              guifg=RoyalBlue
    highlight! HiColorBU    gui=underline guibg=bg              guifg=blue
    highlight! HiColorB3U   gui=underline guibg=bg              guifg=DodgerBlue
    highlight! HiColorB4U   gui=underline guibg=bg              guifg=DeepSkyBlue
    highlight! HiColorB5U   gui=underline guibg=bg              guifg=skyBlue
    highlight! HiColorB6U   gui=underline guibg=bg              guifg=SteelBlue
    highlight! HiColorMU    gui=underline guibg=bg              guifg=magenta
    highlight! HiColorM1U   gui=underline guibg=bg              guifg=orchid
    highlight! HiColorM2U   gui=underline guibg=bg              guifg=MediumOrchid
    highlight! HiColorM3U   gui=underline guibg=bg              guifg=DarkOrchid
    highlight! HiColorM5U   gui=underline guibg=bg              guifg=purple
    highlight! HiColorM6U   gui=underline guibg=bg              guifg=MediumPurple
    highlight! HiColorC1U   gui=underline guibg=bg              guifg=PaleTurquoise
    highlight! HiColorC2U   gui=underline guibg=bg              guifg=DarkTurquoise
    highlight! HiColorC3U   gui=underline guibg=bg              guifg=DarkTurquoise
    highlight! HiColorC4U   gui=underline guibg=bg              guifg=MediumTurquoise
    highlight! HiColorC5U   gui=underline guibg=bg              guifg=turquoise
    highlight! HiColorCU    gui=underline guibg=bg              guifg=cyan
    highlight! HiColorC6U   gui=underline guibg=bg              guifg=aquamarine
    highlight! HiColorV1U   gui=underline guibg=bg              guifg=PaleVioletRed
    highlight! HiColorV2U   gui=underline guibg=bg              guifg=VioletRed
    highlight! HiColorV3U   gui=underline guibg=bg              guifg=HotPink
    highlight! HiColorV4U   gui=underline guibg=bg              guifg=DeepPink
    highlight! HiColorVU    gui=underline guibg=bg              guifg=violet
    highlight! HiColorV5U   gui=underline guibg=bg              guifg=DarkViolet
    highlight! HiColorV6U   gui=underline guibg=bg              guifg=BlueViolet
    highlight! HiColorO1U   gui=underline guibg=bg              guifg=DarkSalmon
    highlight! HiColorO2U   gui=underline guibg=bg              guifg=salmon
    highlight! HiColorO3U   gui=underline guibg=bg              guifg=LightSalmon
    highlight! HiColorOU    gui=underline guibg=bg              guifg=orange
    highlight! HiColorO4U   gui=underline guibg=bg              guifg=DarkOrange
    highlight! HiColorO5U   gui=underline guibg=bg              guifg=coral
    highlight! HiColorO6U   gui=underline guibg=bg              guifg=LightCoral
    highlight! HiColorR1U   gui=underline guibg=bg              guifg=IndianRed
    highlight! HiColorR2U   gui=underline guibg=bg              guifg=firebrick
    highlight! HiColorR3U   gui=underline guibg=bg              guifg=tomato
    highlight! HiColorR4U   gui=underline guibg=bg              guifg=OrangeRed
    highlight! HiColorRU    gui=underline guibg=bg              guifg=red
    highlight! HiColorR5U   gui=underline guibg=bg              guifg=DarkRed
    highlight! HiColorR6U   gui=underline guibg=bg              guifg=maroon
    highlight! HiColorBR1U  gui=underline guibg=bg              guifg=RosyBrown
    highlight! HiColorBR2U  gui=underline guibg=bg              guifg=SaddleBrown
    highlight! HiColorBR3U  gui=underline guibg=bg              guifg=sienna
    highlight! HiColorBR4U  gui=underline guibg=bg              guifg=peru
    highlight! HiColorBRU   gui=underline guibg=bg              guifg=burlywood
    highlight! HiColorBR5U  gui=underline guibg=bg              guifg=SandyBrown
    highlight! HiColorBR6U  gui=underline guibg=bg              guifg=chocolate
    highlight! HiColorNH    gui=none      guibg=fg              guifg=bg
    highlight! HiColorN1H   gui=none      guibg=fg              guifg=bg
    highlight! HiColorN2H   gui=none      guibg=fg              guifg=bg
    highlight! HiColorN3H   gui=none      guibg=fg              guifg=bg
    highlight! HiColorN4H   gui=none      guibg=fg              guifg=bg
    highlight! HiColorN5H   gui=none      guibg=fg              guifg=bg
    highlight! HiColorN6H   gui=none      guibg=fg              guifg=bg
    highlight! HiColorN7H   gui=none      guibg=fg              guifg=bg
    highlight! HiColorW1H   gui=none      guibg=snow            guifg=bg
    highlight! HiColorW2H   gui=none      guibg=WhiteSmoke      guifg=bg
    highlight! HiColorW3H   gui=none      guibg=FloralWhite     guifg=bg
    highlight! HiColorW4H   gui=none      guibg=OldLace         guifg=bg
    highlight! HiColorW5H   gui=none      guibg=linen           guifg=bg
    highlight! HiColorW7H   gui=none      guibg=AntiqueWhite    guifg=bg
    highlight! HiColorWH    gui=none      guibg=white           guifg=bg
    highlight! HiColorY1H   gui=none      guibg=khaki           guifg=bg
    highlight! HiColorY2H   gui=none      guibg=PaleGoldenrod   guifg=bg
    highlight! HiColorYH    gui=none      guibg=yellow          guifg=bg
    highlight! HiColorY3H   gui=none      guibg=gold            guifg=bg
    highlight! HiColorY4H   gui=none      guibg=LightGoldenrod  guifg=bg
    highlight! HiColorY5H   gui=none      guibg=goldenrod       guifg=bg
    highlight! HiColorY6H   gui=none      guibg=DarkGoldenrod   guifg=bg
    highlight! HiColorG1H   gui=none      guibg=DarkGreen       guifg=bg
    highlight! HiColorG2H   gui=none      guibg=SeaGreen        guifg=bg
    highlight! HiColorG3H   gui=none      guibg=MediumSeaGreen  guifg=bg
    highlight! HiColorG4H   gui=none      guibg=PaleGreen       guifg=bg
    highlight! HiColorG5H   gui=none      guibg=SpringGreen     guifg=bg
    highlight! HiColorG6H   gui=none      guibg=LawnGreen       guifg=bg
    highlight! HiColorGH    gui=none      guibg=green           guifg=bg
    highlight! HiColorB1H   gui=none      guibg=NavyBlue        guifg=bg
    highlight! HiColorB2H   gui=none      guibg=RoyalBlue       guifg=bg
    highlight! HiColorBH    gui=none      guibg=blue            guifg=bg
    highlight! HiColorB3H   gui=none      guibg=DodgerBlue      guifg=bg
    highlight! HiColorB4H   gui=none      guibg=DeepSkyBlue     guifg=bg
    highlight! HiColorB5H   gui=none      guibg=skyBlue         guifg=bg
    highlight! HiColorB6H   gui=none      guibg=SteelBlue       guifg=bg
    highlight! HiColorMH    gui=none      guibg=magenta         guifg=bg
    highlight! HiColorM1H   gui=none      guibg=orchid          guifg=bg
    highlight! HiColorM2H   gui=none      guibg=MediumOrchid    guifg=bg
    highlight! HiColorM3H   gui=none      guibg=DarkOrchid      guifg=bg
    highlight! HiColorM5H   gui=none      guibg=purple          guifg=bg
    highlight! HiColorM6H   gui=none      guibg=MediumPurple    guifg=bg
    highlight! HiColorC1H   gui=none      guibg=PaleTurquoise   guifg=bg
    highlight! HiColorC2H   gui=none      guibg=DarkTurquoise   guifg=bg
    highlight! HiColorC3H   gui=none      guibg=DarkTurquoise   guifg=bg
    highlight! HiColorC4H   gui=none      guibg=MediumTurquoise guifg=bg
    highlight! HiColorC5H   gui=none      guibg=turquoise       guifg=bg
    highlight! HiColorCH    gui=none      guibg=cyan            guifg=bg
    highlight! HiColorC6H   gui=none      guibg=aquamarine      guifg=bg
    highlight! HiColorV1H   gui=none      guibg=PaleVioletRed   guifg=bg
    highlight! HiColorV2H   gui=none      guibg=VioletRed       guifg=bg
    highlight! HiColorV3H   gui=none      guibg=HotPink         guifg=bg
    highlight! HiColorV4H   gui=none      guibg=DeepPink        guifg=bg
    highlight! HiColorVH    gui=none      guibg=violet          guifg=bg
    highlight! HiColorV5H   gui=none      guibg=DarkViolet      guifg=bg
    highlight! HiColorV6H   gui=none      guibg=BlueViolet      guifg=bg
    highlight! HiColorO1H   gui=none      guibg=DarkSalmon      guifg=bg
    highlight! HiColorO2H   gui=none      guibg=salmon          guifg=bg
    highlight! HiColorO3H   gui=none      guibg=LightSalmon     guifg=bg
    highlight! HiColorOH    gui=none      guibg=orange          guifg=bg
    highlight! HiColorO4H   gui=none      guibg=DarkOrange      guifg=bg
    highlight! HiColorO5H   gui=none      guibg=coral           guifg=bg
    highlight! HiColorO6H   gui=none      guibg=LightCoral      guifg=bg
    highlight! HiColorR1H   gui=none      guibg=IndianRed       guifg=bg
    highlight! HiColorR2H   gui=none      guibg=firebrick       guifg=bg
    highlight! HiColorR3H   gui=none      guibg=tomato          guifg=bg
    highlight! HiColorR4H   gui=none      guibg=OrangeRed       guifg=bg
    highlight! HiColorRH    gui=none      guibg=red             guifg=bg
    highlight! HiColorR5H   gui=none      guibg=DarkRed         guifg=bg
    highlight! HiColorR6H   gui=none      guibg=maroon          guifg=bg
    highlight! HiColorBR1H  gui=none      guibg=RosyBrown       guifg=bg
    highlight! HiColorBR2H  gui=none      guibg=SaddleBrown     guifg=bg
    highlight! HiColorBR3H  gui=none      guibg=sienna          guifg=bg
    highlight! HiColorBR4H  gui=none      guibg=peru            guifg=bg
    highlight! HiColorBRH   gui=none      guibg=burlywood       guifg=bg
    highlight! HiColorBR5H  gui=none      guibg=SandyBrown      guifg=bg
    highlight! HiColorBR6H  gui=none      guibg=chocolate       guifg=bg
    highlight! HiColorNHB   gui=bold      guibg=fg              guifg=bg
    highlight! HiColorN1HB  gui=bold      guibg=fg              guifg=bg
    highlight! HiColorN2HB  gui=bold      guibg=fg              guifg=bg
    highlight! HiColorN3HB  gui=bold      guibg=fg              guifg=bg
    highlight! HiColorN4HB  gui=bold      guibg=fg              guifg=bg
    highlight! HiColorN5HB  gui=bold      guibg=fg              guifg=bg
    highlight! HiColorN6HB  gui=bold      guibg=fg              guifg=bg
    highlight! HiColorN7HB  gui=bold      guibg=fg              guifg=bg
    highlight! HiColorW1HB  gui=bold      guibg=snow            guifg=bg
    highlight! HiColorW2HB  gui=bold      guibg=WhiteSmoke      guifg=bg
    highlight! HiColorW3HB  gui=bold      guibg=FloralWhite     guifg=bg
    highlight! HiColorW4HB  gui=bold      guibg=OldLace         guifg=bg
    highlight! HiColorW5HB  gui=bold      guibg=linen           guifg=bg
    highlight! HiColorW7HB  gui=bold      guibg=AntiqueWhite    guifg=bg
    highlight! HiColorWHB   gui=bold      guibg=white           guifg=bg
    highlight! HiColorY1HB  gui=bold      guibg=khaki           guifg=bg
    highlight! HiColorY2HB  gui=bold      guibg=PaleGoldenrod   guifg=bg
    highlight! HiColorYHB   gui=bold      guibg=yellow          guifg=bg
    highlight! HiColorY3HB  gui=bold      guibg=gold            guifg=bg
    highlight! HiColorY4HB  gui=bold      guibg=LightGoldenrod  guifg=bg
    highlight! HiColorY5HB  gui=bold      guibg=goldenrod       guifg=bg
    highlight! HiColorY6HB  gui=bold      guibg=DarkGoldenrod   guifg=bg
    highlight! HiColorG1HB  gui=bold      guibg=DarkGreen       guifg=bg
    highlight! HiColorG2HB  gui=bold      guibg=SeaGreen        guifg=bg
    highlight! HiColorG3HB  gui=bold      guibg=MediumSeaGreen  guifg=bg
    highlight! HiColorG4HB  gui=bold      guibg=PaleGreen       guifg=bg
    highlight! HiColorG5HB  gui=bold      guibg=SpringGreen     guifg=bg
    highlight! HiColorG6HB  gui=bold      guibg=LawnGreen       guifg=bg
    highlight! HiColorGHB   gui=bold      guibg=green           guifg=bg
    highlight! HiColorB1HB  gui=bold      guibg=NavyBlue        guifg=bg
    highlight! HiColorB2HB  gui=bold      guibg=RoyalBlue       guifg=bg
    highlight! HiColorBHB   gui=bold      guibg=blue            guifg=bg
    highlight! HiColorB3HB  gui=bold      guibg=DodgerBlue      guifg=bg
    highlight! HiColorB4HB  gui=bold      guibg=DeepSkyBlue     guifg=bg
    highlight! HiColorB5HB  gui=bold      guibg=skyBlue         guifg=bg
    highlight! HiColorB6HB  gui=bold      guibg=SteelBlue       guifg=bg
    highlight! HiColorMHB   gui=bold      guibg=magenta         guifg=bg
    highlight! HiColorM1HB  gui=bold      guibg=orchid          guifg=bg
    highlight! HiColorM2HB  gui=bold      guibg=MediumOrchid    guifg=bg
    highlight! HiColorM3HB  gui=bold      guibg=DarkOrchid      guifg=bg
    highlight! HiColorM5HB  gui=bold      guibg=purple          guifg=bg
    highlight! HiColorM6HB  gui=bold      guibg=MediumPurple    guifg=bg
    highlight! HiColorC1HB  gui=bold      guibg=PaleTurquoise   guifg=bg
    highlight! HiColorC2HB  gui=bold      guibg=DarkTurquoise   guifg=bg
    highlight! HiColorC3HB  gui=bold      guibg=DarkTurquoise   guifg=bg
    highlight! HiColorC4HB  gui=bold      guibg=MediumTurquoise guifg=bg
    highlight! HiColorC5HB  gui=bold      guibg=turquoise       guifg=bg
    highlight! HiColorCHB   gui=bold      guibg=cyan            guifg=bg
    highlight! HiColorC6HB  gui=bold      guibg=aquamarine      guifg=bg
    highlight! HiColorV1HB  gui=bold      guibg=PaleVioletRed   guifg=bg
    highlight! HiColorV2HB  gui=bold      guibg=VioletRed       guifg=bg
    highlight! HiColorV3HB  gui=bold      guibg=HotPink         guifg=bg
    highlight! HiColorV4HB  gui=bold      guibg=DeepPink        guifg=bg
    highlight! HiColorVHB   gui=bold      guibg=violet          guifg=bg
    highlight! HiColorV5HB  gui=bold      guibg=DarkViolet      guifg=bg
    highlight! HiColorV6HB  gui=bold      guibg=BlueViolet      guifg=bg
    highlight! HiColorO1HB  gui=bold      guibg=DarkSalmon      guifg=bg
    highlight! HiColorO2HB  gui=bold      guibg=salmon          guifg=bg
    highlight! HiColorO3HB  gui=bold      guibg=LightSalmon     guifg=bg
    highlight! HiColorOHB   gui=bold      guibg=orange          guifg=bg
    highlight! HiColorO4HB  gui=bold      guibg=DarkOrange      guifg=bg
    highlight! HiColorO5HB  gui=bold      guibg=coral           guifg=bg
    highlight! HiColorO6HB  gui=bold      guibg=LightCoral      guifg=bg
    highlight! HiColorR1HB  gui=bold      guibg=IndianRed       guifg=bg
    highlight! HiColorR2HB  gui=bold      guibg=firebrick       guifg=bg
    highlight! HiColorR3HB  gui=bold      guibg=tomato          guifg=bg
    highlight! HiColorR4HB  gui=bold      guibg=OrangeRed       guifg=bg
    highlight! HiColorRHB   gui=bold      guibg=red             guifg=bg
    highlight! HiColorR5HB  gui=bold      guibg=DarkRed         guifg=bg
    highlight! HiColorR6HB  gui=bold      guibg=maroon          guifg=bg
    highlight! HiColorBR1HB gui=bold      guibg=RosyBrown       guifg=bg
    highlight! HiColorBR2HB gui=bold      guibg=SaddleBrown     guifg=bg
    highlight! HiColorBR3HB gui=bold      guibg=sienna          guifg=bg
    highlight! HiColorBR4HB gui=bold      guibg=peru            guifg=bg
    highlight! HiColorBRHB  gui=bold      guibg=burlywood       guifg=bg
    highlight! HiColorBR5HB gui=bold      guibg=SandyBrown      guifg=bg
    highlight! HiColorBR6HB gui=bold      guibg=chocolate       guifg=bg

    let g:HiColorDefinitionList = []
    let g:HiColorDefinitionList += [ [ "N"     ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N1"    ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N2"    ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N3"    ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N4"    ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N5"    ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N6"    ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N7"    ,  "none"      ,  "bg"              ,  "fg"              ,  "none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W1"    ,  "none"      ,  "bg"              ,  "snow"            ,  "snow-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W2"    ,  "none"      ,  "bg"              ,  "WhiteSmoke"      ,  "WhiteSmoke-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W3"    ,  "none"      ,  "bg"              ,  "FloralWhite"     ,  "FloralWhite-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W4"    ,  "none"      ,  "bg"              ,  "OldLace"         ,  "OldLace-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W5"    ,  "none"      ,  "bg"              ,  "linen"           ,  "linen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W7"    ,  "none"      ,  "bg"              ,  "AntiqueWhite"    ,  "AntiqueWhite-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W"     ,  "none"      ,  "bg"              ,  "white"           ,  "white-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y1"    ,  "none"      ,  "bg"              ,  "khaki"           ,  "khaki-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y2"    ,  "none"      ,  "bg"              ,  "PaleGoldenrod"   ,  "PaleGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y"     ,  "none"      ,  "bg"              ,  "yellow"          ,  "yellow-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y3"    ,  "none"      ,  "bg"              ,  "gold"            ,  "gold-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y4"    ,  "none"      ,  "bg"              ,  "LightGoldenrod"  ,  "LightGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y5"    ,  "none"      ,  "bg"              ,  "goldenrod"       ,  "goldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y6"    ,  "none"      ,  "bg"              ,  "DarkGoldenrod"   ,  "DarkGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G1"    ,  "none"      ,  "bg"              ,  "DarkGreen"       ,  "DarkGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G2"    ,  "none"      ,  "bg"              ,  "SeaGreen"        ,  "SeaGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G3"    ,  "none"      ,  "bg"              ,  "MediumSeaGreen"  ,  "MediumSeaGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G4"    ,  "none"      ,  "bg"              ,  "PaleGreen"       ,  "PaleGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G5"    ,  "none"      ,  "bg"              ,  "SpringGreen"     ,  "SpringGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G6"    ,  "none"      ,  "bg"              ,  "LawnGreen"       ,  "LawnGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G"     ,  "none"      ,  "bg"              ,  "green"           ,  "green-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B1"    ,  "none"      ,  "bg"              ,  "NavyBlue"        ,  "NavyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B2"    ,  "none"      ,  "bg"              ,  "RoyalBlue"       ,  "RoyalBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B"     ,  "none"      ,  "bg"              ,  "blue"            ,  "blue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B3"    ,  "none"      ,  "bg"              ,  "DodgerBlue"      ,  "DodgerBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B4"    ,  "none"      ,  "bg"              ,  "DeepSkyBlue"     ,  "DeepSkyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B5"    ,  "none"      ,  "bg"              ,  "skyBlue"         ,  "skyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B6"    ,  "none"      ,  "bg"              ,  "SteelBlue"       ,  "SteelBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M"     ,  "none"      ,  "bg"              ,  "magenta"         ,  "magenta-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M1"    ,  "none"      ,  "bg"              ,  "orchid"          ,  "orchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M2"    ,  "none"      ,  "bg"              ,  "MediumOrchid"    ,  "MediumOrchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M3"    ,  "none"      ,  "bg"              ,  "DarkOrchid"      ,  "DarkOrchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M5"    ,  "none"      ,  "bg"              ,  "purple"          ,  "purple-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M6"    ,  "none"      ,  "bg"              ,  "MediumPurple"    ,  "MediumPurple-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C1"    ,  "none"      ,  "bg"              ,  "PaleTurquoise"   ,  "PaleTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C2"    ,  "none"      ,  "bg"              ,  "DarkTurquoise"   ,  "DarkTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C3"    ,  "none"      ,  "bg"              ,  "DarkTurquoise"   ,  "DarkTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C4"    ,  "none"      ,  "bg"              ,  "MediumTurquoise" ,  "MediumTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C5"    ,  "none"      ,  "bg"              ,  "turquoise"       ,  "turquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C"     ,  "none"      ,  "bg"              ,  "cyan"            ,  "cyan-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C6"    ,  "none"      ,  "bg"              ,  "aquamarine"      ,  "aquamarine-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V1"    ,  "none"      ,  "bg"              ,  "PaleVioletRed"   ,  "PaleVioletRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V2"    ,  "none"      ,  "bg"              ,  "VioletRed"       ,  "VioletRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V3"    ,  "none"      ,  "bg"              ,  "HotPink"         ,  "HotPink-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V4"    ,  "none"      ,  "bg"              ,  "DeepPink"        ,  "DeepPink-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V"     ,  "none"      ,  "bg"              ,  "violet"          ,  "violet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V5"    ,  "none"      ,  "bg"              ,  "DarkViolet"      ,  "DarkViolet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V6"    ,  "none"      ,  "bg"              ,  "BlueViolet"      ,  "BlueViolet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O1"    ,  "none"      ,  "bg"              ,  "DarkSalmon"      ,  "DarkSalmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O2"    ,  "none"      ,  "bg"              ,  "salmon"          ,  "salmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O3"    ,  "none"      ,  "bg"              ,  "LightSalmon"     ,  "LightSalmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O"     ,  "none"      ,  "bg"              ,  "orange"          ,  "orange-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O4"    ,  "none"      ,  "bg"              ,  "DarkOrange"      ,  "DarkOrange-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O5"    ,  "none"      ,  "bg"              ,  "coral"           ,  "coral-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O6"    ,  "none"      ,  "bg"              ,  "LightCoral"      ,  "LightCoral-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R1"    ,  "none"      ,  "bg"              ,  "IndianRed"       ,  "IndianRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R2"    ,  "none"      ,  "bg"              ,  "firebrick"       ,  "firebrick-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R3"    ,  "none"      ,  "bg"              ,  "tomato"          ,  "tomato-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R4"    ,  "none"      ,  "bg"              ,  "OrangeRed"       ,  "OrangeRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R"     ,  "none"      ,  "bg"              ,  "red"             ,  "red-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R5"    ,  "none"      ,  "bg"              ,  "DarkRed"         ,  "DarkRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R6"    ,  "none"      ,  "bg"              ,  "maroon"          ,  "maroon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR1"   ,  "none"      ,  "bg"              ,  "RosyBrown"       ,  "RosyBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR2"   ,  "none"      ,  "bg"              ,  "SaddleBrown"     ,  "SaddleBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR3"   ,  "none"      ,  "bg"              ,  "sienna"          ,  "sienna-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR4"   ,  "none"      ,  "bg"              ,  "peru"            ,  "peru-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR"    ,  "none"      ,  "bg"              ,  "burlywood"       ,  "burlywood-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR5"   ,  "none"      ,  "bg"              ,  "SandyBrown"      ,  "SandyBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR6"   ,  "none"      ,  "bg"              ,  "chocolate"       ,  "chocolate-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N!"    ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N1!"   ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N2!"   ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N3!"   ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N4!"   ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N5!"   ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N6!"   ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N7!"   ,  "bold"      ,  "bg"              ,  "fg"              ,  "bold-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W1!"   ,  "bold"      ,  "bg"              ,  "snow"            ,  "bold-snow-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W2!"   ,  "bold"      ,  "bg"              ,  "WhiteSmoke"      ,  "bold-WhiteSmoke-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W3!"   ,  "bold"      ,  "bg"              ,  "FloralWhite"     ,  "bold-FloralWhite-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W4!"   ,  "bold"      ,  "bg"              ,  "OldLace"         ,  "bold-OldLace-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W5!"   ,  "bold"      ,  "bg"              ,  "linen"           ,  "bold-linen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W7!"   ,  "bold"      ,  "bg"              ,  "AntiqueWhite"    ,  "bold-AntiqueWhite-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W!"    ,  "bold"      ,  "bg"              ,  "white"           ,  "bold-white-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y1!"   ,  "bold"      ,  "bg"              ,  "khaki"           ,  "bold-khaki-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y2!"   ,  "bold"      ,  "bg"              ,  "PaleGoldenrod"   ,  "bold-PaleGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y!"    ,  "bold"      ,  "bg"              ,  "yellow"          ,  "bold-yellow-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y3!"   ,  "bold"      ,  "bg"              ,  "gold"            ,  "bold-gold-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y4!"   ,  "bold"      ,  "bg"              ,  "LightGoldenrod"  ,  "bold-LightGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y5!"   ,  "bold"      ,  "bg"              ,  "goldenrod"       ,  "bold-goldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y6!"   ,  "bold"      ,  "bg"              ,  "DarkGoldenrod"   ,  "bold-DarkGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G1!"   ,  "bold"      ,  "bg"              ,  "DarkGreen"       ,  "bold-DarkGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G2!"   ,  "bold"      ,  "bg"              ,  "SeaGreen"        ,  "bold-SeaGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G3!"   ,  "bold"      ,  "bg"              ,  "MediumSeaGreen"  ,  "bold-MediumSeaGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G4!"   ,  "bold"      ,  "bg"              ,  "PaleGreen"       ,  "bold-PaleGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G5!"   ,  "bold"      ,  "bg"              ,  "SpringGreen"     ,  "bold-SpringGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G6!"   ,  "bold"      ,  "bg"              ,  "LawnGreen"       ,  "bold-LawnGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G!"    ,  "bold"      ,  "bg"              ,  "green"           ,  "bold-green-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B1!"   ,  "bold"      ,  "bg"              ,  "NavyBlue"        ,  "bold-NavyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B2!"   ,  "bold"      ,  "bg"              ,  "RoyalBlue"       ,  "bold-RoyalBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B!"    ,  "bold"      ,  "bg"              ,  "blue"            ,  "bold-blue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B3!"   ,  "bold"      ,  "bg"              ,  "DodgerBlue"      ,  "bold-DodgerBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B4!"   ,  "bold"      ,  "bg"              ,  "DeepSkyBlue"     ,  "bold-DeepSkyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B5!"   ,  "bold"      ,  "bg"              ,  "skyBlue"         ,  "bold-skyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B6!"   ,  "bold"      ,  "bg"              ,  "SteelBlue"       ,  "bold-SteelBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M!"    ,  "bold"      ,  "bg"              ,  "magenta"         ,  "bold-magenta-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M1!"   ,  "bold"      ,  "bg"              ,  "orchid"          ,  "bold-orchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M2!"   ,  "bold"      ,  "bg"              ,  "MediumOrchid"    ,  "bold-MediumOrchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M3!"   ,  "bold"      ,  "bg"              ,  "DarkOrchid"      ,  "bold-DarkOrchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M5!"   ,  "bold"      ,  "bg"              ,  "purple"          ,  "bold-purple-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M6!"   ,  "bold"      ,  "bg"              ,  "MediumPurple"    ,  "bold-MediumPurple-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C1!"   ,  "bold"      ,  "bg"              ,  "PaleTurquoise"   ,  "bold-PaleTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C2!"   ,  "bold"      ,  "bg"              ,  "DarkTurquoise"   ,  "bold-DarkTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C3!"   ,  "bold"      ,  "bg"              ,  "DarkTurquoise"   ,  "bold-DarkTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C4!"   ,  "bold"      ,  "bg"              ,  "MediumTurquoise" ,  "bold-MediumTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C5!"   ,  "bold"      ,  "bg"              ,  "turquoise"       ,  "bold-turquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C!"    ,  "bold"      ,  "bg"              ,  "cyan"            ,  "bold-cyan-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C6!"   ,  "bold"      ,  "bg"              ,  "aquamarine"      ,  "bold-aquamarine-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V1!"   ,  "bold"      ,  "bg"              ,  "PaleVioletRed"   ,  "bold-PaleVioletRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V2!"   ,  "bold"      ,  "bg"              ,  "VioletRed"       ,  "bold-VioletRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V3!"   ,  "bold"      ,  "bg"              ,  "HotPink"         ,  "bold-HotPink-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V4!"   ,  "bold"      ,  "bg"              ,  "DeepPink"        ,  "bold-DeepPink-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V!"    ,  "bold"      ,  "bg"              ,  "violet"          ,  "bold-violet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V5!"   ,  "bold"      ,  "bg"              ,  "DarkViolet"      ,  "bold-DarkViolet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V6!"   ,  "bold"      ,  "bg"              ,  "BlueViolet"      ,  "bold-BlueViolet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O1!"   ,  "bold"      ,  "bg"              ,  "DarkSalmon"      ,  "bold-DarkSalmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O2!"   ,  "bold"      ,  "bg"              ,  "salmon"          ,  "bold-salmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O3!"   ,  "bold"      ,  "bg"              ,  "LightSalmon"     ,  "bold-LightSalmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O!"    ,  "bold"      ,  "bg"              ,  "orange"          ,  "bold-orange-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O4!"   ,  "bold"      ,  "bg"              ,  "DarkOrange"      ,  "bold-DarkOrange-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O5!"   ,  "bold"      ,  "bg"              ,  "coral"           ,  "bold-coral-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O6!"   ,  "bold"      ,  "bg"              ,  "LightCoral"      ,  "bold-LightCoral-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R1!"   ,  "bold"      ,  "bg"              ,  "IndianRed"       ,  "bold-IndianRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R2!"   ,  "bold"      ,  "bg"              ,  "firebrick"       ,  "bold-firebrick-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R3!"   ,  "bold"      ,  "bg"              ,  "tomato"          ,  "bold-tomato-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R4!"   ,  "bold"      ,  "bg"              ,  "OrangeRed"       ,  "bold-OrangeRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R!"    ,  "bold"      ,  "bg"              ,  "red"             ,  "bold-red-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R5!"   ,  "bold"      ,  "bg"              ,  "DarkRed"         ,  "bold-DarkRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R6!"   ,  "bold"      ,  "bg"              ,  "maroon"          ,  "bold-maroon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR1!"  ,  "bold"      ,  "bg"              ,  "RosyBrown"       ,  "bold-RosyBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR2!"  ,  "bold"      ,  "bg"              ,  "SaddleBrown"     ,  "bold-SaddleBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR3!"  ,  "bold"      ,  "bg"              ,  "sienna"          ,  "bold-sienna-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR4!"  ,  "bold"      ,  "bg"              ,  "peru"            ,  "bold-peru-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR!"   ,  "bold"      ,  "bg"              ,  "burlywood"       ,  "bold-burlywood-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR5!"  ,  "bold"      ,  "bg"              ,  "SandyBrown"      ,  "bold-SandyBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR6!"  ,  "bold"      ,  "bg"              ,  "chocolate"       ,  "bold-chocolate-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N_"    ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N1_"   ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N2_"   ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N3_"   ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N4_"   ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N5_"   ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N6_"   ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N7_"   ,  "underline" ,  "bg"              ,  "fg"              ,  "underline-none-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W1_"   ,  "underline" ,  "bg"              ,  "snow"            ,  "underline-snow-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W2_"   ,  "underline" ,  "bg"              ,  "WhiteSmoke"      ,  "underline-WhiteSmoke-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W3_"   ,  "underline" ,  "bg"              ,  "FloralWhite"     ,  "underline-FloralWhite-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W4_"   ,  "underline" ,  "bg"              ,  "OldLace"         ,  "underline-OldLace-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W5_"   ,  "underline" ,  "bg"              ,  "linen"           ,  "underline-linen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W7_"   ,  "underline" ,  "bg"              ,  "AntiqueWhite"    ,  "underline-AntiqueWhite-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "W_"    ,  "underline" ,  "bg"              ,  "white"           ,  "underline-white-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y1_"   ,  "underline" ,  "bg"              ,  "khaki"           ,  "underline-khaki-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y2_"   ,  "underline" ,  "bg"              ,  "PaleGoldenrod"   ,  "underline-PaleGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y_"    ,  "underline" ,  "bg"              ,  "yellow"          ,  "underline-yellow-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y3_"   ,  "underline" ,  "bg"              ,  "gold"            ,  "underline-gold-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y4_"   ,  "underline" ,  "bg"              ,  "LightGoldenrod"  ,  "underline-LightGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y5_"   ,  "underline" ,  "bg"              ,  "goldenrod"       ,  "underline-goldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "Y6_"   ,  "underline" ,  "bg"              ,  "DarkGoldenrod"   ,  "underline-DarkGoldenrod-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G1_"   ,  "underline" ,  "bg"              ,  "DarkGreen"       ,  "underline-DarkGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G2_"   ,  "underline" ,  "bg"              ,  "SeaGreen"        ,  "underline-SeaGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G3_"   ,  "underline" ,  "bg"              ,  "MediumSeaGreen"  ,  "underline-MediumSeaGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G4_"   ,  "underline" ,  "bg"              ,  "PaleGreen"       ,  "underline-PaleGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G5_"   ,  "underline" ,  "bg"              ,  "SpringGreen"     ,  "underline-SpringGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G6_"   ,  "underline" ,  "bg"              ,  "LawnGreen"       ,  "underline-LawnGreen-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "G_"    ,  "underline" ,  "bg"              ,  "green"           ,  "underline-green-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B1_"   ,  "underline" ,  "bg"              ,  "NavyBlue"        ,  "underline-NavyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B2_"   ,  "underline" ,  "bg"              ,  "RoyalBlue"       ,  "underline-RoyalBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B_"    ,  "underline" ,  "bg"              ,  "blue"            ,  "underline-blue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B3_"   ,  "underline" ,  "bg"              ,  "DodgerBlue"      ,  "underline-DodgerBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B4_"   ,  "underline" ,  "bg"              ,  "DeepSkyBlue"     ,  "underline-DeepSkyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B5_"   ,  "underline" ,  "bg"              ,  "skyBlue"         ,  "underline-skyBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "B6_"   ,  "underline" ,  "bg"              ,  "SteelBlue"       ,  "underline-SteelBlue-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M_"    ,  "underline" ,  "bg"              ,  "magenta"         ,  "underline-magenta-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M1_"   ,  "underline" ,  "bg"              ,  "orchid"          ,  "underline-orchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M2_"   ,  "underline" ,  "bg"              ,  "MediumOrchid"    ,  "underline-MediumOrchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M3_"   ,  "underline" ,  "bg"              ,  "DarkOrchid"      ,  "underline-DarkOrchid-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M5_"   ,  "underline" ,  "bg"              ,  "purple"          ,  "underline-purple-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "M6_"   ,  "underline" ,  "bg"              ,  "MediumPurple"    ,  "underline-MediumPurple-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C1_"   ,  "underline" ,  "bg"              ,  "PaleTurquoise"   ,  "underline-PaleTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C2_"   ,  "underline" ,  "bg"              ,  "DarkTurquoise"   ,  "underline-DarkTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C3_"   ,  "underline" ,  "bg"              ,  "DarkTurquoise"   ,  "underline-DarkTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C4_"   ,  "underline" ,  "bg"              ,  "MediumTurquoise" ,  "underline-MediumTurquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C5_"   ,  "underline" ,  "bg"              ,  "turquoise"       ,  "underline-turquoise-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C_"    ,  "underline" ,  "bg"              ,  "cyan"            ,  "underline-cyan-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "C6_"   ,  "underline" ,  "bg"              ,  "aquamarine"      ,  "underline-aquamarine-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V1_"   ,  "underline" ,  "bg"              ,  "PaleVioletRed"   ,  "underline-PaleVioletRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V2_"   ,  "underline" ,  "bg"              ,  "VioletRed"       ,  "underline-VioletRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V3_"   ,  "underline" ,  "bg"              ,  "HotPink"         ,  "underline-HotPink-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V4_"   ,  "underline" ,  "bg"              ,  "DeepPink"        ,  "underline-DeepPink-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V_"    ,  "underline" ,  "bg"              ,  "violet"          ,  "underline-violet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V5_"   ,  "underline" ,  "bg"              ,  "DarkViolet"      ,  "underline-DarkViolet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "V6_"   ,  "underline" ,  "bg"              ,  "BlueViolet"      ,  "underline-BlueViolet-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O1_"   ,  "underline" ,  "bg"              ,  "DarkSalmon"      ,  "underline-DarkSalmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O2_"   ,  "underline" ,  "bg"              ,  "salmon"          ,  "underline-salmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O3_"   ,  "underline" ,  "bg"              ,  "LightSalmon"     ,  "underline-LightSalmon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O_"    ,  "underline" ,  "bg"              ,  "orange"          ,  "underline-orange-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O4_"   ,  "underline" ,  "bg"              ,  "DarkOrange"      ,  "underline-DarkOrange-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O5_"   ,  "underline" ,  "bg"              ,  "coral"           ,  "underline-coral-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "O6_"   ,  "underline" ,  "bg"              ,  "LightCoral"      ,  "underline-LightCoral-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R1_"   ,  "underline" ,  "bg"              ,  "IndianRed"       ,  "underline-IndianRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R2_"   ,  "underline" ,  "bg"              ,  "firebrick"       ,  "underline-firebrick-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R3_"   ,  "underline" ,  "bg"              ,  "tomato"          ,  "underline-tomato-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R4_"   ,  "underline" ,  "bg"              ,  "OrangeRed"       ,  "underline-OrangeRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R_"    ,  "underline" ,  "bg"              ,  "red"             ,  "underline-red-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R5_"   ,  "underline" ,  "bg"              ,  "DarkRed"         ,  "underline-DarkRed-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "R6_"   ,  "underline" ,  "bg"              ,  "maroon"          ,  "underline-maroon-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR1_"  ,  "underline" ,  "bg"              ,  "RosyBrown"       ,  "underline-RosyBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR2_"  ,  "underline" ,  "bg"              ,  "SaddleBrown"     ,  "underline-SaddleBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR3_"  ,  "underline" ,  "bg"              ,  "sienna"          ,  "underline-sienna-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR4_"  ,  "underline" ,  "bg"              ,  "peru"            ,  "underline-peru-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR_"   ,  "underline" ,  "bg"              ,  "burlywood"       ,  "underline-burlywood-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR5_"  ,  "underline" ,  "bg"              ,  "SandyBrown"      ,  "underline-SandyBrown-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "BR6_"  ,  "underline" ,  "bg"              ,  "chocolate"       ,  "underline-chocolate-foreground" ] ]
    let g:HiColorDefinitionList += [ [ "N@"    ,  "none"      ,  "fg"              ,  "bg"              ,  "none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N1@"   ,  "none"      ,  "fg"              ,  "bg"              ,  "none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N2@"   ,  "none"      ,  "fg"              ,  "bg"              ,  "none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N3@"   ,  "none"      ,  "fg"              ,  "bg"              ,  "none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N4@"   ,  "none"      ,  "fg"              ,  "bg"              ,  "none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N5@"   ,  "none"      ,  "fg"              ,  "bg"              ,  "none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N6@"   ,  "none"      ,  "fg"              ,  "bg"              ,  "none-background" ] ]
    let g:HiColorDefinitionList += [ [ "W1@"   ,  "none"      ,  "snow"            ,  "bg"              ,  "snow-background" ] ]
    let g:HiColorDefinitionList += [ [ "W2@"   ,  "none"      ,  "WhiteSmoke"      ,  "bg"              ,  "WhiteSmoke-background" ] ]
    let g:HiColorDefinitionList += [ [ "W3@"   ,  "none"      ,  "FloralWhite"     ,  "bg"              ,  "FloralWhite-background" ] ]
    let g:HiColorDefinitionList += [ [ "W4@"   ,  "none"      ,  "OldLace"         ,  "bg"              ,  "OldLace-background" ] ]
    let g:HiColorDefinitionList += [ [ "W5@"   ,  "none"      ,  "linen"           ,  "bg"              ,  "linen-background" ] ]
    let g:HiColorDefinitionList += [ [ "W7@"   ,  "none"      ,  "AntiqueWhite"    ,  "bg"              ,  "AntiqueWhite-background" ] ]
    let g:HiColorDefinitionList += [ [ "W@"    ,  "none"      ,  "white"           ,  "bg"              ,  "white-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y1@"   ,  "none"      ,  "khaki"           ,  "bg"              ,  "khaki-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y2@"   ,  "none"      ,  "PaleGoldenrod"   ,  "bg"              ,  "PaleGoldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y@"    ,  "none"      ,  "yellow"          ,  "bg"              ,  "yellow-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y3@"   ,  "none"      ,  "gold"            ,  "bg"              ,  "gold-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y4@"   ,  "none"      ,  "LightGoldenrod"  ,  "bg"              ,  "LightGoldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y5@"   ,  "none"      ,  "goldenrod"       ,  "bg"              ,  "goldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y6@"   ,  "none"      ,  "DarkGoldenrod"   ,  "bg"              ,  "DarkGoldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "G1@"   ,  "none"      ,  "DarkGreen"       ,  "bg"              ,  "DarkGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G2@"   ,  "none"      ,  "SeaGreen"        ,  "bg"              ,  "SeaGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G3@"   ,  "none"      ,  "MediumSeaGreen"  ,  "bg"              ,  "MediumSeaGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G4@"   ,  "none"      ,  "PaleGreen"       ,  "bg"              ,  "PaleGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G5@"   ,  "none"      ,  "SpringGreen"     ,  "bg"              ,  "SpringGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G6@"   ,  "none"      ,  "LawnGreen"       ,  "bg"              ,  "LawnGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G@"    ,  "none"      ,  "green"           ,  "bg"              ,  "green-background" ] ]
    let g:HiColorDefinitionList += [ [ "B1@"   ,  "none"      ,  "NavyBlue"        ,  "bg"              ,  "NavyBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B2@"   ,  "none"      ,  "RoyalBlue"       ,  "bg"              ,  "RoyalBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B@"    ,  "none"      ,  "blue"            ,  "bg"              ,  "blue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B3@"   ,  "none"      ,  "DodgerBlue"      ,  "bg"              ,  "DodgerBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B4@"   ,  "none"      ,  "DeepSkyBlue"     ,  "bg"              ,  "DeepSkyBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B5@"   ,  "none"      ,  "skyBlue"         ,  "bg"              ,  "skyBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B6@"   ,  "none"      ,  "SteelBlue"       ,  "bg"              ,  "SteelBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "M@"    ,  "none"      ,  "magenta"         ,  "bg"              ,  "magenta-background" ] ]
    let g:HiColorDefinitionList += [ [ "M1@"   ,  "none"      ,  "orchid"          ,  "bg"              ,  "orchid-background" ] ]
    let g:HiColorDefinitionList += [ [ "M2@"   ,  "none"      ,  "MediumOrchid"    ,  "bg"              ,  "MediumOrchid-background" ] ]
    let g:HiColorDefinitionList += [ [ "M3@"   ,  "none"      ,  "DarkOrchid"      ,  "bg"              ,  "DarkOrchid-background" ] ]
    let g:HiColorDefinitionList += [ [ "M5@"   ,  "none"      ,  "purple"          ,  "bg"              ,  "purple-background" ] ]
    let g:HiColorDefinitionList += [ [ "M6@"   ,  "none"      ,  "MediumPurple"    ,  "bg"              ,  "MediumPurple-background" ] ]
    let g:HiColorDefinitionList += [ [ "C1@"   ,  "none"      ,  "PaleTurquoise"   ,  "bg"              ,  "PaleTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C2@"   ,  "none"      ,  "DarkTurquoise"   ,  "bg"              ,  "DarkTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C3@"   ,  "none"      ,  "DarkTurquoise"   ,  "bg"              ,  "DarkTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C4@"   ,  "none"      ,  "MediumTurquoise" ,  "bg"              ,  "MediumTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C5@"   ,  "none"      ,  "turquoise"       ,  "bg"              ,  "turquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C@"    ,  "none"      ,  "cyan"            ,  "bg"              ,  "cyan-background" ] ]
    let g:HiColorDefinitionList += [ [ "C6@"   ,  "none"      ,  "aquamarine"      ,  "bg"              ,  "aquamarine-background" ] ]
    let g:HiColorDefinitionList += [ [ "V1@"   ,  "none"      ,  "PaleVioletRed"   ,  "bg"              ,  "PaleVioletRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "V2@"   ,  "none"      ,  "VioletRed"       ,  "bg"              ,  "VioletRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "V3@"   ,  "none"      ,  "HotPink"         ,  "bg"              ,  "HotPink-background" ] ]
    let g:HiColorDefinitionList += [ [ "V4@"   ,  "none"      ,  "DeepPink"        ,  "bg"              ,  "DeepPink-background" ] ]
    let g:HiColorDefinitionList += [ [ "V@"    ,  "none"      ,  "violet"          ,  "bg"              ,  "violet-background" ] ]
    let g:HiColorDefinitionList += [ [ "V5@"   ,  "none"      ,  "DarkViolet"      ,  "bg"              ,  "DarkViolet-background" ] ]
    let g:HiColorDefinitionList += [ [ "V6@"   ,  "none"      ,  "BlueViolet"      ,  "bg"              ,  "BlueViolet-background" ] ]
    let g:HiColorDefinitionList += [ [ "O1@"   ,  "none"      ,  "DarkSalmon"      ,  "bg"              ,  "DarkSalmon-background" ] ]
    let g:HiColorDefinitionList += [ [ "O2@"   ,  "none"      ,  "salmon"          ,  "bg"              ,  "salmon-background" ] ]
    let g:HiColorDefinitionList += [ [ "O3@"   ,  "none"      ,  "LightSalmon"     ,  "bg"              ,  "LightSalmon-background" ] ]
    let g:HiColorDefinitionList += [ [ "O@"    ,  "none"      ,  "orange"          ,  "bg"              ,  "orange-background" ] ]
    let g:HiColorDefinitionList += [ [ "O4@"   ,  "none"      ,  "DarkOrange"      ,  "bg"              ,  "DarkOrange-background" ] ]
    let g:HiColorDefinitionList += [ [ "O5@"   ,  "none"      ,  "coral"           ,  "bg"              ,  "coral-background" ] ]
    let g:HiColorDefinitionList += [ [ "O6@"   ,  "none"      ,  "LightCoral"      ,  "bg"              ,  "LightCoral-background" ] ]
    let g:HiColorDefinitionList += [ [ "R1@"   ,  "none"      ,  "IndianRed"       ,  "bg"              ,  "IndianRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "R2@"   ,  "none"      ,  "firebrick"       ,  "bg"              ,  "firebrick-background" ] ]
    let g:HiColorDefinitionList += [ [ "R3@"   ,  "none"      ,  "tomato"          ,  "bg"              ,  "tomato-background" ] ]
    let g:HiColorDefinitionList += [ [ "R4@"   ,  "none"      ,  "OrangeRed"       ,  "bg"              ,  "OrangeRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "R@"    ,  "none"      ,  "red"             ,  "bg"              ,  "red-background" ] ]
    let g:HiColorDefinitionList += [ [ "R5@"   ,  "none"      ,  "DarkRed"         ,  "bg"              ,  "DarkRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "R6@"   ,  "none"      ,  "maroon"          ,  "bg"              ,  "maroon-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR1@"  ,  "none"      ,  "RosyBrown"       ,  "bg"              ,  "RosyBrown-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR2@"  ,  "none"      ,  "SaddleBrown"     ,  "bg"              ,  "SaddleBrown-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR3@"  ,  "none"      ,  "sienna"          ,  "bg"              ,  "sienna-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR4@"  ,  "none"      ,  "peru"            ,  "bg"              ,  "peru-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR@"   ,  "none"      ,  "burlywood"       ,  "bg"              ,  "burlywood-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR5@"  ,  "none"      ,  "SandyBrown"      ,  "bg"              ,  "SandyBrown-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR6@"  ,  "none"      ,  "chocolate"       ,  "bg"              ,  "chocolate-background" ] ]
    let g:HiColorDefinitionList += [ [ "N@!"   ,  "bold"      ,  "fg"              ,  "bg"              ,  "bold-none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N1@!"  ,  "bold"      ,  "fg"              ,  "bg"              ,  "bold-none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N2@!"  ,  "bold"      ,  "fg"              ,  "bg"              ,  "bold-none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N3@!"  ,  "bold"      ,  "fg"              ,  "bg"              ,  "bold-none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N4@!"  ,  "bold"      ,  "fg"              ,  "bg"              ,  "bold-none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N5@!"  ,  "bold"      ,  "fg"              ,  "bg"              ,  "bold-none-background" ] ]
    let g:HiColorDefinitionList += [ [ "N6@!"  ,  "bold"      ,  "fg"              ,  "bg"              ,  "bold-none-background" ] ]
    let g:HiColorDefinitionList += [ [ "W1@!"  ,  "bold"      ,  "snow"            ,  "bg"              ,  "bold-snow-background" ] ]
    let g:HiColorDefinitionList += [ [ "W2@!"  ,  "bold"      ,  "WhiteSmoke"      ,  "bg"              ,  "bold-WhiteSmoke-background" ] ]
    let g:HiColorDefinitionList += [ [ "W3@!"  ,  "bold"      ,  "FloralWhite"     ,  "bg"              ,  "bold-FloralWhite-background" ] ]
    let g:HiColorDefinitionList += [ [ "W4@!"  ,  "bold"      ,  "OldLace"         ,  "bg"              ,  "bold-OldLace-background" ] ]
    let g:HiColorDefinitionList += [ [ "W5@!"  ,  "bold"      ,  "linen"           ,  "bg"              ,  "bold-linen-background" ] ]
    let g:HiColorDefinitionList += [ [ "W7@!"  ,  "bold"      ,  "AntiqueWhite"    ,  "bg"              ,  "bold-AntiqueWhite-background" ] ]
    let g:HiColorDefinitionList += [ [ "W@!"   ,  "bold"      ,  "white"           ,  "bg"              ,  "bold-white-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y1@!"  ,  "bold"      ,  "khaki"           ,  "bg"              ,  "bold-khaki-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y2@!"  ,  "bold"      ,  "PaleGoldenrod"   ,  "bg"              ,  "bold-PaleGoldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y@!"   ,  "bold"      ,  "yellow"          ,  "bg"              ,  "bold-yellow-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y3@!"  ,  "bold"      ,  "gold"            ,  "bg"              ,  "bold-gold-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y4@!"  ,  "bold"      ,  "LightGoldenrod"  ,  "bg"              ,  "bold-LightGoldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y5@!"  ,  "bold"      ,  "goldenrod"       ,  "bg"              ,  "bold-goldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "Y6@!"  ,  "bold"      ,  "DarkGoldenrod"   ,  "bg"              ,  "bold-DarkGoldenrod-background" ] ]
    let g:HiColorDefinitionList += [ [ "G1@!"  ,  "bold"      ,  "DarkGreen"       ,  "bg"              ,  "bold-DarkGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G2@!"  ,  "bold"      ,  "SeaGreen"        ,  "bg"              ,  "bold-SeaGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G3@!"  ,  "bold"      ,  "MediumSeaGreen"  ,  "bg"              ,  "bold-MediumSeaGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G4@!"  ,  "bold"      ,  "PaleGreen"       ,  "bg"              ,  "bold-PaleGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G5@!"  ,  "bold"      ,  "SpringGreen"     ,  "bg"              ,  "bold-SpringGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G6@!"  ,  "bold"      ,  "LawnGreen"       ,  "bg"              ,  "bold-LawnGreen-background" ] ]
    let g:HiColorDefinitionList += [ [ "G@!"   ,  "bold"      ,  "green"           ,  "bg"              ,  "bold-green-background" ] ]
    let g:HiColorDefinitionList += [ [ "B1@!"  ,  "bold"      ,  "NavyBlue"        ,  "bg"              ,  "bold-NavyBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B2@!"  ,  "bold"      ,  "RoyalBlue"       ,  "bg"              ,  "bold-RoyalBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B@!"   ,  "bold"      ,  "blue"            ,  "bg"              ,  "bold-blue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B3@!"  ,  "bold"      ,  "DodgerBlue"      ,  "bg"              ,  "bold-DodgerBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B4@!"  ,  "bold"      ,  "DeepSkyBlue"     ,  "bg"              ,  "bold-DeepSkyBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B5@!"  ,  "bold"      ,  "skyBlue"         ,  "bg"              ,  "bold-skyBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "B6@!"  ,  "bold"      ,  "SteelBlue"       ,  "bg"              ,  "bold-SteelBlue-background" ] ]
    let g:HiColorDefinitionList += [ [ "M@!"   ,  "bold"      ,  "magenta"         ,  "bg"              ,  "bold-magenta-background" ] ]
    let g:HiColorDefinitionList += [ [ "M1@!"  ,  "bold"      ,  "orchid"          ,  "bg"              ,  "bold-orchid-background" ] ]
    let g:HiColorDefinitionList += [ [ "M2@!"  ,  "bold"      ,  "MediumOrchid"    ,  "bg"              ,  "bold-MediumOrchid-background" ] ]
    let g:HiColorDefinitionList += [ [ "M3@!"  ,  "bold"      ,  "DarkOrchid"      ,  "bg"              ,  "bold-DarkOrchid-background" ] ]
    let g:HiColorDefinitionList += [ [ "M5@!"  ,  "bold"      ,  "purple"          ,  "bg"              ,  "bold-purple-background" ] ]
    let g:HiColorDefinitionList += [ [ "M6@!"  ,  "bold"      ,  "MediumPurple"    ,  "bg"              ,  "bold-MediumPurple-background" ] ]
    let g:HiColorDefinitionList += [ [ "C1@!"  ,  "bold"      ,  "PaleTurquoise"   ,  "bg"              ,  "bold-PaleTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C2@!"  ,  "bold"      ,  "DarkTurquoise"   ,  "bg"              ,  "bold-DarkTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C3@!"  ,  "bold"      ,  "DarkTurquoise"   ,  "bg"              ,  "bold-DarkTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C4@!"  ,  "bold"      ,  "MediumTurquoise" ,  "bg"              ,  "bold-MediumTurquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C5@!"  ,  "bold"      ,  "turquoise"       ,  "bg"              ,  "bold-turquoise-background" ] ]
    let g:HiColorDefinitionList += [ [ "C@!"   ,  "bold"      ,  "cyan"            ,  "bg"              ,  "bold-cyan-background" ] ]
    let g:HiColorDefinitionList += [ [ "C6@!"  ,  "bold"      ,  "aquamarine"      ,  "bg"              ,  "bold-aquamarine-background" ] ]
    let g:HiColorDefinitionList += [ [ "V1@!"  ,  "bold"      ,  "PaleVioletRed"   ,  "bg"              ,  "bold-PaleVioletRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "V2@!"  ,  "bold"      ,  "VioletRed"       ,  "bg"              ,  "bold-VioletRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "V3@!"  ,  "bold"      ,  "HotPink"         ,  "bg"              ,  "bold-HotPink-background" ] ]
    let g:HiColorDefinitionList += [ [ "V4@!"  ,  "bold"      ,  "DeepPink"        ,  "bg"              ,  "bold-DeepPink-background" ] ]
    let g:HiColorDefinitionList += [ [ "V@!"   ,  "bold"      ,  "violet"          ,  "bg"              ,  "bold-violet-background" ] ]
    let g:HiColorDefinitionList += [ [ "V5@!"  ,  "bold"      ,  "DarkViolet"      ,  "bg"              ,  "bold-DarkViolet-background" ] ]
    let g:HiColorDefinitionList += [ [ "V6@!"  ,  "bold"      ,  "BlueViolet"      ,  "bg"              ,  "bold-BlueViolet-background" ] ]
    let g:HiColorDefinitionList += [ [ "O1@!"  ,  "bold"      ,  "DarkSalmon"      ,  "bg"              ,  "bold-DarkSalmon-background" ] ]
    let g:HiColorDefinitionList += [ [ "O2@!"  ,  "bold"      ,  "salmon"          ,  "bg"              ,  "bold-salmon-background" ] ]
    let g:HiColorDefinitionList += [ [ "O3@!"  ,  "bold"      ,  "LightSalmon"     ,  "bg"              ,  "bold-LightSalmon-background" ] ]
    let g:HiColorDefinitionList += [ [ "O@!"   ,  "bold"      ,  "orange"          ,  "bg"              ,  "bold-orange-background" ] ]
    let g:HiColorDefinitionList += [ [ "O4@!"  ,  "bold"      ,  "DarkOrange"      ,  "bg"              ,  "bold-DarkOrange-background" ] ]
    let g:HiColorDefinitionList += [ [ "O5@!"  ,  "bold"      ,  "coral"           ,  "bg"              ,  "bold-coral-background" ] ]
    let g:HiColorDefinitionList += [ [ "O6@!"  ,  "bold"      ,  "LightCoral"      ,  "bg"              ,  "bold-LightCoral-background" ] ]
    let g:HiColorDefinitionList += [ [ "R1@!"  ,  "bold"      ,  "IndianRed"       ,  "bg"              ,  "bold-IndianRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "R2@!"  ,  "bold"      ,  "firebrick"       ,  "bg"              ,  "bold-firebrick-background" ] ]
    let g:HiColorDefinitionList += [ [ "R3@!"  ,  "bold"      ,  "tomato"          ,  "bg"              ,  "bold-tomato-background" ] ]
    let g:HiColorDefinitionList += [ [ "R4@!"  ,  "bold"      ,  "OrangeRed"       ,  "bg"              ,  "bold-OrangeRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "R@!"   ,  "bold"      ,  "red"             ,  "bg"              ,  "bold-red-background" ] ]
    let g:HiColorDefinitionList += [ [ "R5@!"  ,  "bold"      ,  "DarkRed"         ,  "bg"              ,  "bold-DarkRed-background" ] ]
    let g:HiColorDefinitionList += [ [ "R6@!"  ,  "bold"      ,  "maroon"          ,  "bg"              ,  "bold-maroon-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR1@!" ,  "bold"      ,  "RosyBrown"       ,  "bg"              ,  "bold-RosyBrown-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR2@!" ,  "bold"      ,  "SaddleBrown"     ,  "bg"              ,  "bold-SaddleBrown-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR3@!" ,  "bold"      ,  "sienna"          ,  "bg"              ,  "bold-sienna-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR4@!" ,  "bold"      ,  "peru"            ,  "bg"              ,  "bold-peru-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR@!"  ,  "bold"      ,  "burlywood"       ,  "bg"              ,  "bold-burlywood-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR5@!" ,  "bold"      ,  "SandyBrown"      ,  "bg"              ,  "bold-SandyBrown-background" ] ]
    let g:HiColorDefinitionList += [ [ "BR6@!" ,  "bold"      ,  "chocolate"       ,  "bg"              ,  "bold-chocolate-background" ] ]

    let g:HiBaseColors = "none snow WhiteSmoke FloralWhite OldLace linen AntiqueWhite white khaki PaleGoldenrod yellow gold LightGoldenrod goldenrod DarkGoldenrod DarkGreen SeaGreen MediumSeaGreen PaleGreen SpringGreen LawnGreen green NavyBlue RoyalBlue blue DodgerBlue DeepSkyBlue skyBlue SteelBlue magenta orchid MediumOrchid DarkOrchid purple MediumPurple PaleTurquoise DarkTurquoise DarkTurquoise MediumTurquoise turquoise cyan aquamarine PaleVioletRed VioletRed HotPink DeepPink violet DarkViolet BlueViolet DarkSalmon salmon LightSalmon orange DarkOrange coral LightCoral IndianRed firebrick tomato OrangeRed red DarkRed maroon RosyBrown SaddleBrown sienna peru burlywood SandyBrown chocolate "

    let g:HiColorIds = "N N2 N3 N4 N5 N6 W1 W2 W3 W4 W5 W7 W Y1 Y2 Y Y3 Y4 Y5 Y6 G1 G2 G3 G4 G5 G6 G B1 B2 B B3 B4 B5 B6 M M1 M2 M3 M5 M6 C1 C2 C3 C4 C5 C C6 V1 V2 V3 V4 V V5 V6 O1 O2 O3 O O4 O5 O6 R1 R2 R3 R4 R R5 R6 BR1 BR2 BR3 BR4 BR BR5 BR6 "
else
    if g:HiTermColors == 256
        echom "HighlightMatch Term 256 config"

        highlight! HiColorN    cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN1   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN2   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN3   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN4   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN5   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN6   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN7   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorN8   cterm=none      ctermbg=bg      ctermfg=fg
        highlight! HiColorY    cterm=none      ctermbg=bg      ctermfg=3
        highlight! HiColorY1   cterm=none      ctermbg=bg      ctermfg=186
        highlight! HiColorY2   cterm=none      ctermbg=bg      ctermfg=229
        highlight! HiColorY3   cterm=none      ctermbg=bg      ctermfg=228
        highlight! HiColorY4   cterm=none      ctermbg=bg      ctermfg=192
        highlight! HiColorY5   cterm=none      ctermbg=bg      ctermfg=227
        highlight! HiColorY6   cterm=none      ctermbg=bg      ctermfg=191
        highlight! HiColorY7   cterm=none      ctermbg=bg      ctermfg=190
        highlight! HiColorY8   cterm=none      ctermbg=bg      ctermfg=220
        highlight! HiColorG    cterm=none      ctermbg=bg      ctermfg=64
        highlight! HiColorG1   cterm=none      ctermbg=bg      ctermfg=64
        highlight! HiColorG2   cterm=none      ctermbg=bg      ctermfg=48
        highlight! HiColorG3   cterm=none      ctermbg=bg      ctermfg=47
        highlight! HiColorG4   cterm=none      ctermbg=bg      ctermfg=41
        highlight! HiColorG5   cterm=none      ctermbg=bg      ctermfg=40
        highlight! HiColorG6   cterm=none      ctermbg=bg      ctermfg=34
        highlight! HiColorG7   cterm=none      ctermbg=bg      ctermfg=28
        highlight! HiColorG8   cterm=none      ctermbg=bg      ctermfg=22
        highlight! HiColorB    cterm=none      ctermbg=bg      ctermfg=4
        highlight! HiColorB1   cterm=none      ctermbg=bg      ctermfg=45
        highlight! HiColorB2   cterm=none      ctermbg=bg      ctermfg=39
        highlight! HiColorB3   cterm=none      ctermbg=bg      ctermfg=33
        highlight! HiColorB4   cterm=none      ctermbg=bg      ctermfg=27
        highlight! HiColorB5   cterm=none      ctermbg=bg      ctermfg=20
        highlight! HiColorB6   cterm=none      ctermbg=bg      ctermfg=19
        highlight! HiColorB7   cterm=none      ctermbg=bg      ctermfg=18
        highlight! HiColorB8   cterm=none      ctermbg=bg      ctermfg=17
        highlight! HiColorM    cterm=none      ctermbg=bg      ctermfg=125
        highlight! HiColorM1   cterm=none      ctermbg=bg      ctermfg=177
        highlight! HiColorM2   cterm=none      ctermbg=bg      ctermfg=171
        highlight! HiColorM3   cterm=none      ctermbg=bg      ctermfg=165
        highlight! HiColorM4   cterm=none      ctermbg=bg      ctermfg=164
        highlight! HiColorM5   cterm=none      ctermbg=bg      ctermfg=128
        highlight! HiColorM6   cterm=none      ctermbg=bg      ctermfg=127
        highlight! HiColorM7   cterm=none      ctermbg=bg      ctermfg=126
        highlight! HiColorM8   cterm=none      ctermbg=bg      ctermfg=90
        highlight! HiColorC    cterm=none      ctermbg=bg      ctermfg=6
        highlight! HiColorC1   cterm=none      ctermbg=bg      ctermfg=159
        highlight! HiColorC2   cterm=none      ctermbg=bg      ctermfg=123
        highlight! HiColorC3   cterm=none      ctermbg=bg      ctermfg=87
        highlight! HiColorC4   cterm=none      ctermbg=bg      ctermfg=50
        highlight! HiColorC5   cterm=none      ctermbg=bg      ctermfg=44
        highlight! HiColorC6   cterm=none      ctermbg=bg      ctermfg=37
        highlight! HiColorC7   cterm=none      ctermbg=bg      ctermfg=30
        highlight! HiColorC8   cterm=none      ctermbg=bg      ctermfg=23
        highlight! HiColorV    cterm=none      ctermbg=bg      ctermfg=13
        highlight! HiColorV1   cterm=none      ctermbg=bg      ctermfg=67
        highlight! HiColorV2   cterm=none      ctermbg=bg      ctermfg=68
        highlight! HiColorV3   cterm=none      ctermbg=bg      ctermfg=69
        highlight! HiColorV4   cterm=none      ctermbg=bg      ctermfg=63
        highlight! HiColorV5   cterm=none      ctermbg=bg      ctermfg=57
        highlight! HiColorV6   cterm=none      ctermbg=bg      ctermfg=56
        highlight! HiColorV7   cterm=none      ctermbg=bg      ctermfg=55
        highlight! HiColorV8   cterm=none      ctermbg=bg      ctermfg=54
        highlight! HiColorW    cterm=none      ctermbg=bg      ctermfg=255
        highlight! HiColorW1   cterm=none      ctermbg=bg      ctermfg=254
        highlight! HiColorW2   cterm=none      ctermbg=bg      ctermfg=253
        highlight! HiColorW3   cterm=none      ctermbg=bg      ctermfg=252
        highlight! HiColorW4   cterm=none      ctermbg=bg      ctermfg=251
        highlight! HiColorW5   cterm=none      ctermbg=bg      ctermfg=250
        highlight! HiColorW6   cterm=none      ctermbg=bg      ctermfg=249
        highlight! HiColorW7   cterm=none      ctermbg=bg      ctermfg=246
        highlight! HiColorW8   cterm=none      ctermbg=bg      ctermfg=243
        highlight! HiColorO    cterm=none      ctermbg=bg      ctermfg=9
        highlight! HiColorO1   cterm=none      ctermbg=bg      ctermfg=174
        highlight! HiColorO2   cterm=none      ctermbg=bg      ctermfg=216
        highlight! HiColorO3   cterm=none      ctermbg=bg      ctermfg=215
        highlight! HiColorO4   cterm=none      ctermbg=bg      ctermfg=214
        highlight! HiColorO5   cterm=none      ctermbg=bg      ctermfg=208
        highlight! HiColorO6   cterm=none      ctermbg=bg      ctermfg=202
        highlight! HiColorO7   cterm=none      ctermbg=bg      ctermfg=166
        highlight! HiColorO8   cterm=none      ctermbg=bg      ctermfg=130
        highlight! HiColorR    cterm=none      ctermbg=bg      ctermfg=1
        highlight! HiColorR1   cterm=none      ctermbg=bg      ctermfg=197
        highlight! HiColorR2   cterm=none      ctermbg=bg      ctermfg=161
        highlight! HiColorR3   cterm=none      ctermbg=bg      ctermfg=125
        highlight! HiColorR4   cterm=none      ctermbg=bg      ctermfg=196
        highlight! HiColorR5   cterm=none      ctermbg=bg      ctermfg=160
        highlight! HiColorR6   cterm=none      ctermbg=bg      ctermfg=124
        highlight! HiColorR7   cterm=none      ctermbg=bg      ctermfg=88
        highlight! HiColorR8   cterm=none      ctermbg=bg      ctermfg=52
        highlight! HiColorNB   cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN1B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN2B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN3B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN4B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN5B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN6B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN7B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorN8B  cterm=bold      ctermbg=bg      ctermfg=fg
        highlight! HiColorYB   cterm=bold      ctermbg=bg      ctermfg=3
        highlight! HiColorY1B  cterm=bold      ctermbg=bg      ctermfg=186
        highlight! HiColorY2B  cterm=bold      ctermbg=bg      ctermfg=229
        highlight! HiColorY3B  cterm=bold      ctermbg=bg      ctermfg=228
        highlight! HiColorY4B  cterm=bold      ctermbg=bg      ctermfg=192
        highlight! HiColorY5B  cterm=bold      ctermbg=bg      ctermfg=227
        highlight! HiColorY6B  cterm=bold      ctermbg=bg      ctermfg=191
        highlight! HiColorY7B  cterm=bold      ctermbg=bg      ctermfg=190
        highlight! HiColorY8B  cterm=bold      ctermbg=bg      ctermfg=220
        highlight! HiColorGB   cterm=bold      ctermbg=bg      ctermfg=64
        highlight! HiColorG1B  cterm=bold      ctermbg=bg      ctermfg=64
        highlight! HiColorG2B  cterm=bold      ctermbg=bg      ctermfg=48
        highlight! HiColorG3B  cterm=bold      ctermbg=bg      ctermfg=47
        highlight! HiColorG4B  cterm=bold      ctermbg=bg      ctermfg=41
        highlight! HiColorG5B  cterm=bold      ctermbg=bg      ctermfg=40
        highlight! HiColorG6B  cterm=bold      ctermbg=bg      ctermfg=34
        highlight! HiColorG7B  cterm=bold      ctermbg=bg      ctermfg=28
        highlight! HiColorG8B  cterm=bold      ctermbg=bg      ctermfg=22
        highlight! HiColorBB   cterm=bold      ctermbg=bg      ctermfg=4
        highlight! HiColorB1B  cterm=bold      ctermbg=bg      ctermfg=45
        highlight! HiColorB2B  cterm=bold      ctermbg=bg      ctermfg=39
        highlight! HiColorB3B  cterm=bold      ctermbg=bg      ctermfg=33
        highlight! HiColorB4B  cterm=bold      ctermbg=bg      ctermfg=27
        highlight! HiColorB5B  cterm=bold      ctermbg=bg      ctermfg=20
        highlight! HiColorB6B  cterm=bold      ctermbg=bg      ctermfg=19
        highlight! HiColorB7B  cterm=bold      ctermbg=bg      ctermfg=18
        highlight! HiColorB8B  cterm=bold      ctermbg=bg      ctermfg=17
        highlight! HiColorMB   cterm=bold      ctermbg=bg      ctermfg=125
        highlight! HiColorM1B  cterm=bold      ctermbg=bg      ctermfg=177
        highlight! HiColorM2B  cterm=bold      ctermbg=bg      ctermfg=171
        highlight! HiColorM3B  cterm=bold      ctermbg=bg      ctermfg=165
        highlight! HiColorM4B  cterm=bold      ctermbg=bg      ctermfg=164
        highlight! HiColorM5B  cterm=bold      ctermbg=bg      ctermfg=128
        highlight! HiColorM6B  cterm=bold      ctermbg=bg      ctermfg=127
        highlight! HiColorM7B  cterm=bold      ctermbg=bg      ctermfg=126
        highlight! HiColorM8B  cterm=bold      ctermbg=bg      ctermfg=90
        highlight! HiColorCB   cterm=bold      ctermbg=bg      ctermfg=6
        highlight! HiColorC1B  cterm=bold      ctermbg=bg      ctermfg=159
        highlight! HiColorC2B  cterm=bold      ctermbg=bg      ctermfg=123
        highlight! HiColorC3B  cterm=bold      ctermbg=bg      ctermfg=87
        highlight! HiColorC4B  cterm=bold      ctermbg=bg      ctermfg=50
        highlight! HiColorC5B  cterm=bold      ctermbg=bg      ctermfg=44
        highlight! HiColorC6B  cterm=bold      ctermbg=bg      ctermfg=37
        highlight! HiColorC7B  cterm=bold      ctermbg=bg      ctermfg=30
        highlight! HiColorC8B  cterm=bold      ctermbg=bg      ctermfg=23
        highlight! HiColorVB   cterm=bold      ctermbg=bg      ctermfg=13
        highlight! HiColorV1B  cterm=bold      ctermbg=bg      ctermfg=67
        highlight! HiColorV2B  cterm=bold      ctermbg=bg      ctermfg=68
        highlight! HiColorV3B  cterm=bold      ctermbg=bg      ctermfg=69
        highlight! HiColorV4B  cterm=bold      ctermbg=bg      ctermfg=63
        highlight! HiColorV5B  cterm=bold      ctermbg=bg      ctermfg=57
        highlight! HiColorV6B  cterm=bold      ctermbg=bg      ctermfg=56
        highlight! HiColorV7B  cterm=bold      ctermbg=bg      ctermfg=55
        highlight! HiColorV8B  cterm=bold      ctermbg=bg      ctermfg=54
        highlight! HiColorWB   cterm=bold      ctermbg=bg      ctermfg=255
        highlight! HiColorW1B  cterm=bold      ctermbg=bg      ctermfg=254
        highlight! HiColorW2B  cterm=bold      ctermbg=bg      ctermfg=253
        highlight! HiColorW3B  cterm=bold      ctermbg=bg      ctermfg=252
        highlight! HiColorW4B  cterm=bold      ctermbg=bg      ctermfg=251
        highlight! HiColorW5B  cterm=bold      ctermbg=bg      ctermfg=250
        highlight! HiColorW6B  cterm=bold      ctermbg=bg      ctermfg=249
        highlight! HiColorW7B  cterm=bold      ctermbg=bg      ctermfg=246
        highlight! HiColorW8B  cterm=bold      ctermbg=bg      ctermfg=243
        highlight! HiColorOB   cterm=bold      ctermbg=bg      ctermfg=9
        highlight! HiColorO1B  cterm=bold      ctermbg=bg      ctermfg=174
        highlight! HiColorO2B  cterm=bold      ctermbg=bg      ctermfg=216
        highlight! HiColorO3B  cterm=bold      ctermbg=bg      ctermfg=215
        highlight! HiColorO4B  cterm=bold      ctermbg=bg      ctermfg=214
        highlight! HiColorO5B  cterm=bold      ctermbg=bg      ctermfg=208
        highlight! HiColorO6B  cterm=bold      ctermbg=bg      ctermfg=202
        highlight! HiColorO7B  cterm=bold      ctermbg=bg      ctermfg=166
        highlight! HiColorO8B  cterm=bold      ctermbg=bg      ctermfg=130
        highlight! HiColorRB   cterm=bold      ctermbg=bg      ctermfg=1
        highlight! HiColorR1B  cterm=bold      ctermbg=bg      ctermfg=197
        highlight! HiColorR2B  cterm=bold      ctermbg=bg      ctermfg=161
        highlight! HiColorR3B  cterm=bold      ctermbg=bg      ctermfg=125
        highlight! HiColorR4B  cterm=bold      ctermbg=bg      ctermfg=196
        highlight! HiColorR5B  cterm=bold      ctermbg=bg      ctermfg=160
        highlight! HiColorR6B  cterm=bold      ctermbg=bg      ctermfg=124
        highlight! HiColorR7B  cterm=bold      ctermbg=bg      ctermfg=88
        highlight! HiColorR8B  cterm=bold      ctermbg=bg      ctermfg=52
        highlight! HiColorNU   cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN1U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN2U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN3U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN4U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN5U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN6U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN7U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorN8U  cterm=underline ctermbg=bg      ctermfg=fg
        highlight! HiColorYU   cterm=underline ctermbg=bg      ctermfg=3
        highlight! HiColorY1U  cterm=underline ctermbg=bg      ctermfg=186
        highlight! HiColorY2U  cterm=underline ctermbg=bg      ctermfg=229
        highlight! HiColorY3U  cterm=underline ctermbg=bg      ctermfg=228
        highlight! HiColorY4U  cterm=underline ctermbg=bg      ctermfg=192
        highlight! HiColorY5U  cterm=underline ctermbg=bg      ctermfg=227
        highlight! HiColorY6U  cterm=underline ctermbg=bg      ctermfg=191
        highlight! HiColorY7U  cterm=underline ctermbg=bg      ctermfg=190
        highlight! HiColorY8U  cterm=underline ctermbg=bg      ctermfg=220
        highlight! HiColorGU   cterm=underline ctermbg=bg      ctermfg=64
        highlight! HiColorG1U  cterm=underline ctermbg=bg      ctermfg=64
        highlight! HiColorG2U  cterm=underline ctermbg=bg      ctermfg=48
        highlight! HiColorG3U  cterm=underline ctermbg=bg      ctermfg=47
        highlight! HiColorG4U  cterm=underline ctermbg=bg      ctermfg=41
        highlight! HiColorG5U  cterm=underline ctermbg=bg      ctermfg=40
        highlight! HiColorG6U  cterm=underline ctermbg=bg      ctermfg=34
        highlight! HiColorG7U  cterm=underline ctermbg=bg      ctermfg=28
        highlight! HiColorG8U  cterm=underline ctermbg=bg      ctermfg=22
        highlight! HiColorBU   cterm=underline ctermbg=bg      ctermfg=4
        highlight! HiColorB1U  cterm=underline ctermbg=bg      ctermfg=45
        highlight! HiColorB2U  cterm=underline ctermbg=bg      ctermfg=39
        highlight! HiColorB3U  cterm=underline ctermbg=bg      ctermfg=33
        highlight! HiColorB4U  cterm=underline ctermbg=bg      ctermfg=27
        highlight! HiColorB5U  cterm=underline ctermbg=bg      ctermfg=20
        highlight! HiColorB6U  cterm=underline ctermbg=bg      ctermfg=19
        highlight! HiColorB7U  cterm=underline ctermbg=bg      ctermfg=18
        highlight! HiColorB8U  cterm=underline ctermbg=bg      ctermfg=17
        highlight! HiColorMU   cterm=underline ctermbg=bg      ctermfg=125
        highlight! HiColorM1U  cterm=underline ctermbg=bg      ctermfg=177
        highlight! HiColorM2U  cterm=underline ctermbg=bg      ctermfg=171
        highlight! HiColorM3U  cterm=underline ctermbg=bg      ctermfg=165
        highlight! HiColorM4U  cterm=underline ctermbg=bg      ctermfg=164
        highlight! HiColorM5U  cterm=underline ctermbg=bg      ctermfg=128
        highlight! HiColorM6U  cterm=underline ctermbg=bg      ctermfg=127
        highlight! HiColorM7U  cterm=underline ctermbg=bg      ctermfg=126
        highlight! HiColorM8U  cterm=underline ctermbg=bg      ctermfg=90
        highlight! HiColorCU   cterm=underline ctermbg=bg      ctermfg=6
        highlight! HiColorC1U  cterm=underline ctermbg=bg      ctermfg=159
        highlight! HiColorC2U  cterm=underline ctermbg=bg      ctermfg=123
        highlight! HiColorC3U  cterm=underline ctermbg=bg      ctermfg=87
        highlight! HiColorC4U  cterm=underline ctermbg=bg      ctermfg=50
        highlight! HiColorC5U  cterm=underline ctermbg=bg      ctermfg=44
        highlight! HiColorC6U  cterm=underline ctermbg=bg      ctermfg=37
        highlight! HiColorC7U  cterm=underline ctermbg=bg      ctermfg=30
        highlight! HiColorC8U  cterm=underline ctermbg=bg      ctermfg=23
        highlight! HiColorVU   cterm=underline ctermbg=bg      ctermfg=13
        highlight! HiColorV1U  cterm=underline ctermbg=bg      ctermfg=67
        highlight! HiColorV2U  cterm=underline ctermbg=bg      ctermfg=68
        highlight! HiColorV3U  cterm=underline ctermbg=bg      ctermfg=69
        highlight! HiColorV4U  cterm=underline ctermbg=bg      ctermfg=63
        highlight! HiColorV5U  cterm=underline ctermbg=bg      ctermfg=57
        highlight! HiColorV6U  cterm=underline ctermbg=bg      ctermfg=56
        highlight! HiColorV7U  cterm=underline ctermbg=bg      ctermfg=55
        highlight! HiColorV8U  cterm=underline ctermbg=bg      ctermfg=54
        highlight! HiColorWU   cterm=underline ctermbg=bg      ctermfg=255
        highlight! HiColorW1U  cterm=underline ctermbg=bg      ctermfg=254
        highlight! HiColorW2U  cterm=underline ctermbg=bg      ctermfg=253
        highlight! HiColorW3U  cterm=underline ctermbg=bg      ctermfg=252
        highlight! HiColorW4U  cterm=underline ctermbg=bg      ctermfg=251
        highlight! HiColorW5U  cterm=underline ctermbg=bg      ctermfg=250
        highlight! HiColorW6U  cterm=underline ctermbg=bg      ctermfg=249
        highlight! HiColorW7U  cterm=underline ctermbg=bg      ctermfg=246
        highlight! HiColorW8U  cterm=underline ctermbg=bg      ctermfg=243
        highlight! HiColorOU   cterm=underline ctermbg=bg      ctermfg=9
        highlight! HiColorO1U  cterm=underline ctermbg=bg      ctermfg=174
        highlight! HiColorO2U  cterm=underline ctermbg=bg      ctermfg=216
        highlight! HiColorO3U  cterm=underline ctermbg=bg      ctermfg=215
        highlight! HiColorO4U  cterm=underline ctermbg=bg      ctermfg=214
        highlight! HiColorO5U  cterm=underline ctermbg=bg      ctermfg=208
        highlight! HiColorO6U  cterm=underline ctermbg=bg      ctermfg=202
        highlight! HiColorO7U  cterm=underline ctermbg=bg      ctermfg=166
        highlight! HiColorO8U  cterm=underline ctermbg=bg      ctermfg=130
        highlight! HiColorRU   cterm=underline ctermbg=bg      ctermfg=1
        highlight! HiColorR1U  cterm=underline ctermbg=bg      ctermfg=197
        highlight! HiColorR2U  cterm=underline ctermbg=bg      ctermfg=161
        highlight! HiColorR3U  cterm=underline ctermbg=bg      ctermfg=125
        highlight! HiColorR4U  cterm=underline ctermbg=bg      ctermfg=196
        highlight! HiColorR5U  cterm=underline ctermbg=bg      ctermfg=160
        highlight! HiColorR6U  cterm=underline ctermbg=bg      ctermfg=124
        highlight! HiColorR7U  cterm=underline ctermbg=bg      ctermfg=88
        highlight! HiColorR8U  cterm=underline ctermbg=bg      ctermfg=52
        highlight! HiColorNH   cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN1H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN2H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN3H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN4H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN5H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN6H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN7H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorN8H  cterm=none      ctermbg=fg      ctermfg=bg
        highlight! HiColorYH   cterm=none      ctermbg=3       ctermfg=bg
        highlight! HiColorY1H  cterm=none      ctermbg=186     ctermfg=bg
        highlight! HiColorY2H  cterm=none      ctermbg=229     ctermfg=bg
        highlight! HiColorY3H  cterm=none      ctermbg=228     ctermfg=bg
        highlight! HiColorY4H  cterm=none      ctermbg=192     ctermfg=bg
        highlight! HiColorY5H  cterm=none      ctermbg=227     ctermfg=bg
        highlight! HiColorY6H  cterm=none      ctermbg=191     ctermfg=bg
        highlight! HiColorY7H  cterm=none      ctermbg=190     ctermfg=bg
        highlight! HiColorY8H  cterm=none      ctermbg=220     ctermfg=bg
        highlight! HiColorGH   cterm=none      ctermbg=64      ctermfg=bg
        highlight! HiColorG1H  cterm=none      ctermbg=64      ctermfg=bg
        highlight! HiColorG2H  cterm=none      ctermbg=48      ctermfg=bg
        highlight! HiColorG3H  cterm=none      ctermbg=47      ctermfg=bg
        highlight! HiColorG4H  cterm=none      ctermbg=41      ctermfg=bg
        highlight! HiColorG5H  cterm=none      ctermbg=40      ctermfg=bg
        highlight! HiColorG6H  cterm=none      ctermbg=34      ctermfg=bg
        highlight! HiColorG7H  cterm=none      ctermbg=28      ctermfg=bg
        highlight! HiColorG8H  cterm=none      ctermbg=22      ctermfg=bg
        highlight! HiColorBH   cterm=none      ctermbg=4       ctermfg=bg
        highlight! HiColorB1H  cterm=none      ctermbg=45      ctermfg=bg
        highlight! HiColorB2H  cterm=none      ctermbg=39      ctermfg=bg
        highlight! HiColorB3H  cterm=none      ctermbg=33      ctermfg=bg
        highlight! HiColorB4H  cterm=none      ctermbg=27      ctermfg=bg
        highlight! HiColorB5H  cterm=none      ctermbg=20      ctermfg=bg
        highlight! HiColorB6H  cterm=none      ctermbg=19      ctermfg=bg
        highlight! HiColorB7H  cterm=none      ctermbg=18      ctermfg=bg
        highlight! HiColorB8H  cterm=none      ctermbg=17      ctermfg=bg
        highlight! HiColorMH   cterm=none      ctermbg=125     ctermfg=bg
        highlight! HiColorM1H  cterm=none      ctermbg=177     ctermfg=bg
        highlight! HiColorM2H  cterm=none      ctermbg=171     ctermfg=bg
        highlight! HiColorM3H  cterm=none      ctermbg=165     ctermfg=bg
        highlight! HiColorM4H  cterm=none      ctermbg=164     ctermfg=bg
        highlight! HiColorM5H  cterm=none      ctermbg=128     ctermfg=bg
        highlight! HiColorM6H  cterm=none      ctermbg=127     ctermfg=bg
        highlight! HiColorM7H  cterm=none      ctermbg=126     ctermfg=bg
        highlight! HiColorM8H  cterm=none      ctermbg=90      ctermfg=bg
        highlight! HiColorCH   cterm=none      ctermbg=6       ctermfg=bg
        highlight! HiColorC1H  cterm=none      ctermbg=159     ctermfg=bg
        highlight! HiColorC2H  cterm=none      ctermbg=123     ctermfg=bg
        highlight! HiColorC3H  cterm=none      ctermbg=87      ctermfg=bg
        highlight! HiColorC4H  cterm=none      ctermbg=50      ctermfg=bg
        highlight! HiColorC5H  cterm=none      ctermbg=44      ctermfg=bg
        highlight! HiColorC6H  cterm=none      ctermbg=37      ctermfg=bg
        highlight! HiColorC7H  cterm=none      ctermbg=30      ctermfg=bg
        highlight! HiColorC8H  cterm=none      ctermbg=23      ctermfg=bg
        highlight! HiColorVH   cterm=none      ctermbg=13      ctermfg=bg
        highlight! HiColorV1H  cterm=none      ctermbg=67      ctermfg=bg
        highlight! HiColorV2H  cterm=none      ctermbg=68      ctermfg=bg
        highlight! HiColorV3H  cterm=none      ctermbg=69      ctermfg=bg
        highlight! HiColorV4H  cterm=none      ctermbg=63      ctermfg=bg
        highlight! HiColorV5H  cterm=none      ctermbg=57      ctermfg=bg
        highlight! HiColorV6H  cterm=none      ctermbg=56      ctermfg=bg
        highlight! HiColorV7H  cterm=none      ctermbg=55      ctermfg=bg
        highlight! HiColorV8H  cterm=none      ctermbg=54      ctermfg=bg
        highlight! HiColorWH   cterm=none      ctermbg=255     ctermfg=bg
        highlight! HiColorW1H  cterm=none      ctermbg=254     ctermfg=bg
        highlight! HiColorW2H  cterm=none      ctermbg=253     ctermfg=bg
        highlight! HiColorW3H  cterm=none      ctermbg=252     ctermfg=bg
        highlight! HiColorW4H  cterm=none      ctermbg=251     ctermfg=bg
        highlight! HiColorW5H  cterm=none      ctermbg=250     ctermfg=bg
        highlight! HiColorW6H  cterm=none      ctermbg=249     ctermfg=bg
        highlight! HiColorW7H  cterm=none      ctermbg=246     ctermfg=bg
        highlight! HiColorW8H  cterm=none      ctermbg=243     ctermfg=bg
        highlight! HiColorOH   cterm=none      ctermbg=9       ctermfg=bg
        highlight! HiColorO1H  cterm=none      ctermbg=174     ctermfg=bg
        highlight! HiColorO2H  cterm=none      ctermbg=216     ctermfg=bg
        highlight! HiColorO3H  cterm=none      ctermbg=215     ctermfg=bg
        highlight! HiColorO4H  cterm=none      ctermbg=214     ctermfg=bg
        highlight! HiColorO5H  cterm=none      ctermbg=208     ctermfg=bg
        highlight! HiColorO6H  cterm=none      ctermbg=202     ctermfg=bg
        highlight! HiColorO7H  cterm=none      ctermbg=166     ctermfg=bg
        highlight! HiColorO8H  cterm=none      ctermbg=130     ctermfg=bg
        highlight! HiColorRH   cterm=none      ctermbg=1       ctermfg=bg
        highlight! HiColorR1H  cterm=none      ctermbg=197     ctermfg=bg
        highlight! HiColorR2H  cterm=none      ctermbg=161     ctermfg=bg
        highlight! HiColorR3H  cterm=none      ctermbg=125     ctermfg=bg
        highlight! HiColorR4H  cterm=none      ctermbg=196     ctermfg=bg
        highlight! HiColorR5H  cterm=none      ctermbg=160     ctermfg=bg
        highlight! HiColorR6H  cterm=none      ctermbg=124     ctermfg=bg
        highlight! HiColorR7H  cterm=none      ctermbg=88      ctermfg=bg
        highlight! HiColorR8H  cterm=none      ctermbg=52      ctermfg=bg
        highlight! HiColorNHB  cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN1HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN2HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN3HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN4HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN5HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN6HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN7HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorN8HB cterm=bold      ctermbg=fg      ctermfg=bg
        highlight! HiColorYHB  cterm=bold      ctermbg=3       ctermfg=bg
        highlight! HiColorY1HB cterm=bold      ctermbg=186     ctermfg=bg
        highlight! HiColorY2HB cterm=bold      ctermbg=229     ctermfg=bg
        highlight! HiColorY3HB cterm=bold      ctermbg=228     ctermfg=bg
        highlight! HiColorY4HB cterm=bold      ctermbg=192     ctermfg=bg
        highlight! HiColorY5HB cterm=bold      ctermbg=227     ctermfg=bg
        highlight! HiColorY6HB cterm=bold      ctermbg=191     ctermfg=bg
        highlight! HiColorY7HB cterm=bold      ctermbg=190     ctermfg=bg
        highlight! HiColorY8HB cterm=bold      ctermbg=220     ctermfg=bg
        highlight! HiColorGHB  cterm=bold      ctermbg=64      ctermfg=bg
        highlight! HiColorG1HB cterm=bold      ctermbg=64      ctermfg=bg
        highlight! HiColorG2HB cterm=bold      ctermbg=48      ctermfg=bg
        highlight! HiColorG3HB cterm=bold      ctermbg=47      ctermfg=bg
        highlight! HiColorG4HB cterm=bold      ctermbg=41      ctermfg=bg
        highlight! HiColorG5HB cterm=bold      ctermbg=40      ctermfg=bg
        highlight! HiColorG6HB cterm=bold      ctermbg=34      ctermfg=bg
        highlight! HiColorG7HB cterm=bold      ctermbg=28      ctermfg=bg
        highlight! HiColorG8HB cterm=bold      ctermbg=22      ctermfg=bg
        highlight! HiColorBHB  cterm=bold      ctermbg=4       ctermfg=bg
        highlight! HiColorB1HB cterm=bold      ctermbg=45      ctermfg=bg
        highlight! HiColorB2HB cterm=bold      ctermbg=39      ctermfg=bg
        highlight! HiColorB3HB cterm=bold      ctermbg=33      ctermfg=bg
        highlight! HiColorB4HB cterm=bold      ctermbg=27      ctermfg=bg
        highlight! HiColorB5HB cterm=bold      ctermbg=20      ctermfg=bg
        highlight! HiColorB6HB cterm=bold      ctermbg=19      ctermfg=bg
        highlight! HiColorB7HB cterm=bold      ctermbg=18      ctermfg=bg
        highlight! HiColorB8HB cterm=bold      ctermbg=17      ctermfg=bg
        highlight! HiColorMHB  cterm=bold      ctermbg=125     ctermfg=bg
        highlight! HiColorM1HB cterm=bold      ctermbg=177     ctermfg=bg
        highlight! HiColorM2HB cterm=bold      ctermbg=171     ctermfg=bg
        highlight! HiColorM3HB cterm=bold      ctermbg=165     ctermfg=bg
        highlight! HiColorM4HB cterm=bold      ctermbg=164     ctermfg=bg
        highlight! HiColorM5HB cterm=bold      ctermbg=128     ctermfg=bg
        highlight! HiColorM6HB cterm=bold      ctermbg=127     ctermfg=bg
        highlight! HiColorM7HB cterm=bold      ctermbg=126     ctermfg=bg
        highlight! HiColorM8HB cterm=bold      ctermbg=90      ctermfg=bg
        highlight! HiColorCHB  cterm=bold      ctermbg=6       ctermfg=bg
        highlight! HiColorC1HB cterm=bold      ctermbg=159     ctermfg=bg
        highlight! HiColorC2HB cterm=bold      ctermbg=123     ctermfg=bg
        highlight! HiColorC3HB cterm=bold      ctermbg=87      ctermfg=bg
        highlight! HiColorC4HB cterm=bold      ctermbg=50      ctermfg=bg
        highlight! HiColorC5HB cterm=bold      ctermbg=44      ctermfg=bg
        highlight! HiColorC6HB cterm=bold      ctermbg=37      ctermfg=bg
        highlight! HiColorC7HB cterm=bold      ctermbg=30      ctermfg=bg
        highlight! HiColorC8HB cterm=bold      ctermbg=23      ctermfg=bg
        highlight! HiColorVHB  cterm=bold      ctermbg=13      ctermfg=bg
        highlight! HiColorV1HB cterm=bold      ctermbg=67      ctermfg=bg
        highlight! HiColorV2HB cterm=bold      ctermbg=68      ctermfg=bg
        highlight! HiColorV3HB cterm=bold      ctermbg=69      ctermfg=bg
        highlight! HiColorV4HB cterm=bold      ctermbg=63      ctermfg=bg
        highlight! HiColorV5HB cterm=bold      ctermbg=57      ctermfg=bg
        highlight! HiColorV6HB cterm=bold      ctermbg=56      ctermfg=bg
        highlight! HiColorV7HB cterm=bold      ctermbg=55      ctermfg=bg
        highlight! HiColorV8HB cterm=bold      ctermbg=54      ctermfg=bg
        highlight! HiColorWHB  cterm=bold      ctermbg=255     ctermfg=bg
        highlight! HiColorW1HB cterm=bold      ctermbg=254     ctermfg=bg
        highlight! HiColorW2HB cterm=bold      ctermbg=253     ctermfg=bg
        highlight! HiColorW3HB cterm=bold      ctermbg=252     ctermfg=bg
        highlight! HiColorW4HB cterm=bold      ctermbg=251     ctermfg=bg
        highlight! HiColorW5HB cterm=bold      ctermbg=250     ctermfg=bg
        highlight! HiColorW6HB cterm=bold      ctermbg=249     ctermfg=bg
        highlight! HiColorW7HB cterm=bold      ctermbg=246     ctermfg=bg
        highlight! HiColorW8HB cterm=bold      ctermbg=243     ctermfg=bg
        highlight! HiColorOHB  cterm=bold      ctermbg=9       ctermfg=bg
        highlight! HiColorO1HB cterm=bold      ctermbg=174     ctermfg=bg
        highlight! HiColorO2HB cterm=bold      ctermbg=216     ctermfg=bg
        highlight! HiColorO3HB cterm=bold      ctermbg=215     ctermfg=bg
        highlight! HiColorO4HB cterm=bold      ctermbg=214     ctermfg=bg
        highlight! HiColorO5HB cterm=bold      ctermbg=208     ctermfg=bg
        highlight! HiColorO6HB cterm=bold      ctermbg=202     ctermfg=bg
        highlight! HiColorO7HB cterm=bold      ctermbg=166     ctermfg=bg
        highlight! HiColorO8HB cterm=bold      ctermbg=130     ctermfg=bg
        highlight! HiColorRHB  cterm=bold      ctermbg=1       ctermfg=bg
        highlight! HiColorR1HB cterm=bold      ctermbg=197     ctermfg=bg
        highlight! HiColorR2HB cterm=bold      ctermbg=161     ctermfg=bg
        highlight! HiColorR3HB cterm=bold      ctermbg=125     ctermfg=bg
        highlight! HiColorR4HB cterm=bold      ctermbg=196     ctermfg=bg
        highlight! HiColorR5HB cterm=bold      ctermbg=160     ctermfg=bg
        highlight! HiColorR6HB cterm=bold      ctermbg=124     ctermfg=bg
        highlight! HiColorR7HB cterm=bold      ctermbg=88      ctermfg=bg
        highlight! HiColorR8HB cterm=bold      ctermbg=52      ctermfg=bg

        let g:HiColorDefinitionList = []
        let g:HiColorDefinitionList += [ [ "N"    ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N1"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N2"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N3"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N4"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N5"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N6"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N7"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N8"   ,  "none"      ,  "bg"  ,  "fg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y"    ,  "none"      ,  "bg"  ,  "3"   ,  "yellow-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y1"   ,  "none"      ,  "bg"  ,  "186" ,  "yellow1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y2"   ,  "none"      ,  "bg"  ,  "229" ,  "yellow2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y3"   ,  "none"      ,  "bg"  ,  "228" ,  "yellow3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y4"   ,  "none"      ,  "bg"  ,  "192" ,  "yellow4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y5"   ,  "none"      ,  "bg"  ,  "227" ,  "yellow5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y6"   ,  "none"      ,  "bg"  ,  "191" ,  "yellow6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y7"   ,  "none"      ,  "bg"  ,  "190" ,  "yellow7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y8"   ,  "none"      ,  "bg"  ,  "220" ,  "yellow8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G"    ,  "none"      ,  "bg"  ,  "64"  ,  "green-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G1"   ,  "none"      ,  "bg"  ,  "64"  ,  "green1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G2"   ,  "none"      ,  "bg"  ,  "48"  ,  "green2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G3"   ,  "none"      ,  "bg"  ,  "47"  ,  "green3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G4"   ,  "none"      ,  "bg"  ,  "41"  ,  "green4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G5"   ,  "none"      ,  "bg"  ,  "40"  ,  "green5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G6"   ,  "none"      ,  "bg"  ,  "34"  ,  "green6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G7"   ,  "none"      ,  "bg"  ,  "28"  ,  "green7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G8"   ,  "none"      ,  "bg"  ,  "22"  ,  "green8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B"    ,  "none"      ,  "bg"  ,  "4"   ,  "blue-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B1"   ,  "none"      ,  "bg"  ,  "45"  ,  "blue1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B2"   ,  "none"      ,  "bg"  ,  "39"  ,  "blue2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B3"   ,  "none"      ,  "bg"  ,  "33"  ,  "blue3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B4"   ,  "none"      ,  "bg"  ,  "27"  ,  "blue4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B5"   ,  "none"      ,  "bg"  ,  "20"  ,  "blue5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B6"   ,  "none"      ,  "bg"  ,  "19"  ,  "blue6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B7"   ,  "none"      ,  "bg"  ,  "18"  ,  "blue7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B8"   ,  "none"      ,  "bg"  ,  "17"  ,  "blue8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M"    ,  "none"      ,  "bg"  ,  "125" ,  "magenta-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M1"   ,  "none"      ,  "bg"  ,  "177" ,  "magenta1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M2"   ,  "none"      ,  "bg"  ,  "171" ,  "magenta2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M3"   ,  "none"      ,  "bg"  ,  "165" ,  "magenta3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M4"   ,  "none"      ,  "bg"  ,  "164" ,  "magenta4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M5"   ,  "none"      ,  "bg"  ,  "128" ,  "magenta5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M6"   ,  "none"      ,  "bg"  ,  "127" ,  "magenta6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M7"   ,  "none"      ,  "bg"  ,  "126" ,  "magenta7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M8"   ,  "none"      ,  "bg"  ,  "90"  ,  "magenta8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C"    ,  "none"      ,  "bg"  ,  "6"   ,  "cyan-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C1"   ,  "none"      ,  "bg"  ,  "159" ,  "cyan1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C2"   ,  "none"      ,  "bg"  ,  "123" ,  "cyan2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C3"   ,  "none"      ,  "bg"  ,  "87"  ,  "cyan3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C4"   ,  "none"      ,  "bg"  ,  "50"  ,  "cyan4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C5"   ,  "none"      ,  "bg"  ,  "44"  ,  "cyan5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C6"   ,  "none"      ,  "bg"  ,  "37"  ,  "cyan6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C7"   ,  "none"      ,  "bg"  ,  "30"  ,  "cyan7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C8"   ,  "none"      ,  "bg"  ,  "23"  ,  "cyan8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V"    ,  "none"      ,  "bg"  ,  "13"  ,  "violet-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V1"   ,  "none"      ,  "bg"  ,  "67"  ,  "violet1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V2"   ,  "none"      ,  "bg"  ,  "68"  ,  "violet2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V3"   ,  "none"      ,  "bg"  ,  "69"  ,  "violet3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V4"   ,  "none"      ,  "bg"  ,  "63"  ,  "violet4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V5"   ,  "none"      ,  "bg"  ,  "57"  ,  "violet5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V6"   ,  "none"      ,  "bg"  ,  "56"  ,  "violet6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V7"   ,  "none"      ,  "bg"  ,  "55"  ,  "violet7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V8"   ,  "none"      ,  "bg"  ,  "54"  ,  "violet8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W"    ,  "none"      ,  "bg"  ,  "255" ,  "white-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W1"   ,  "none"      ,  "bg"  ,  "254" ,  "white1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W2"   ,  "none"      ,  "bg"  ,  "253" ,  "white2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W3"   ,  "none"      ,  "bg"  ,  "252" ,  "white3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W4"   ,  "none"      ,  "bg"  ,  "251" ,  "white4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W5"   ,  "none"      ,  "bg"  ,  "250" ,  "white5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W6"   ,  "none"      ,  "bg"  ,  "249" ,  "white6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W7"   ,  "none"      ,  "bg"  ,  "246" ,  "white7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W8"   ,  "none"      ,  "bg"  ,  "243" ,  "white8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O"    ,  "none"      ,  "bg"  ,  "9"   ,  "orange-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O1"   ,  "none"      ,  "bg"  ,  "174" ,  "orange1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O2"   ,  "none"      ,  "bg"  ,  "216" ,  "orange2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O3"   ,  "none"      ,  "bg"  ,  "215" ,  "orange3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O4"   ,  "none"      ,  "bg"  ,  "214" ,  "orange4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O5"   ,  "none"      ,  "bg"  ,  "208" ,  "orange5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O6"   ,  "none"      ,  "bg"  ,  "202" ,  "orange6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O7"   ,  "none"      ,  "bg"  ,  "166" ,  "orange7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O8"   ,  "none"      ,  "bg"  ,  "130" ,  "orange8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R"    ,  "none"      ,  "bg"  ,  "1"   ,  "red-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R1"   ,  "none"      ,  "bg"  ,  "197" ,  "red1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R2"   ,  "none"      ,  "bg"  ,  "161" ,  "red2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R3"   ,  "none"      ,  "bg"  ,  "125" ,  "red3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R4"   ,  "none"      ,  "bg"  ,  "196" ,  "red4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R5"   ,  "none"      ,  "bg"  ,  "160" ,  "red5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R6"   ,  "none"      ,  "bg"  ,  "124" ,  "red6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R7"   ,  "none"      ,  "bg"  ,  "88"  ,  "red7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R8"   ,  "none"      ,  "bg"  ,  "52"  ,  "red8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N!"   ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N1!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N2!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N3!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N4!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N5!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N6!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N7!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N8!"  ,  "bold"      ,  "bg"  ,  "fg"  ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y!"   ,  "bold"      ,  "bg"  ,  "3"   ,  "bold-yellow-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y1!"  ,  "bold"      ,  "bg"  ,  "186" ,  "bold-yellow1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y2!"  ,  "bold"      ,  "bg"  ,  "229" ,  "bold-yellow2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y3!"  ,  "bold"      ,  "bg"  ,  "228" ,  "bold-yellow3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y4!"  ,  "bold"      ,  "bg"  ,  "192" ,  "bold-yellow4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y5!"  ,  "bold"      ,  "bg"  ,  "227" ,  "bold-yellow5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y6!"  ,  "bold"      ,  "bg"  ,  "191" ,  "bold-yellow6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y7!"  ,  "bold"      ,  "bg"  ,  "190" ,  "bold-yellow7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y8!"  ,  "bold"      ,  "bg"  ,  "220" ,  "bold-yellow8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G!"   ,  "bold"      ,  "bg"  ,  "64"  ,  "bold-green-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G1!"  ,  "bold"      ,  "bg"  ,  "64"  ,  "bold-green1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G2!"  ,  "bold"      ,  "bg"  ,  "48"  ,  "bold-green2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G3!"  ,  "bold"      ,  "bg"  ,  "47"  ,  "bold-green3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G4!"  ,  "bold"      ,  "bg"  ,  "41"  ,  "bold-green4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G5!"  ,  "bold"      ,  "bg"  ,  "40"  ,  "bold-green5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G6!"  ,  "bold"      ,  "bg"  ,  "34"  ,  "bold-green6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G7!"  ,  "bold"      ,  "bg"  ,  "28"  ,  "bold-green7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G8!"  ,  "bold"      ,  "bg"  ,  "22"  ,  "bold-green8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B!"   ,  "bold"      ,  "bg"  ,  "4"   ,  "bold-blue-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B1!"  ,  "bold"      ,  "bg"  ,  "45"  ,  "bold-blue1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B2!"  ,  "bold"      ,  "bg"  ,  "39"  ,  "bold-blue2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B3!"  ,  "bold"      ,  "bg"  ,  "33"  ,  "bold-blue3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B4!"  ,  "bold"      ,  "bg"  ,  "27"  ,  "bold-blue4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B5!"  ,  "bold"      ,  "bg"  ,  "20"  ,  "bold-blue5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B6!"  ,  "bold"      ,  "bg"  ,  "19"  ,  "bold-blue6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B7!"  ,  "bold"      ,  "bg"  ,  "18"  ,  "bold-blue7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B8!"  ,  "bold"      ,  "bg"  ,  "17"  ,  "bold-blue8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M!"   ,  "bold"      ,  "bg"  ,  "125" ,  "bold-magenta-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M1!"  ,  "bold"      ,  "bg"  ,  "177" ,  "bold-magenta1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M2!"  ,  "bold"      ,  "bg"  ,  "171" ,  "bold-magenta2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M3!"  ,  "bold"      ,  "bg"  ,  "165" ,  "bold-magenta3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M4!"  ,  "bold"      ,  "bg"  ,  "164" ,  "bold-magenta4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M5!"  ,  "bold"      ,  "bg"  ,  "128" ,  "bold-magenta5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M6!"  ,  "bold"      ,  "bg"  ,  "127" ,  "bold-magenta6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M7!"  ,  "bold"      ,  "bg"  ,  "126" ,  "bold-magenta7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M8!"  ,  "bold"      ,  "bg"  ,  "90"  ,  "bold-magenta8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C!"   ,  "bold"      ,  "bg"  ,  "6"   ,  "bold-cyan-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C1!"  ,  "bold"      ,  "bg"  ,  "159" ,  "bold-cyan1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C2!"  ,  "bold"      ,  "bg"  ,  "123" ,  "bold-cyan2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C3!"  ,  "bold"      ,  "bg"  ,  "87"  ,  "bold-cyan3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C4!"  ,  "bold"      ,  "bg"  ,  "50"  ,  "bold-cyan4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C5!"  ,  "bold"      ,  "bg"  ,  "44"  ,  "bold-cyan5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C6!"  ,  "bold"      ,  "bg"  ,  "37"  ,  "bold-cyan6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C7!"  ,  "bold"      ,  "bg"  ,  "30"  ,  "bold-cyan7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C8!"  ,  "bold"      ,  "bg"  ,  "23"  ,  "bold-cyan8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V!"   ,  "bold"      ,  "bg"  ,  "13"  ,  "bold-violet-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V1!"  ,  "bold"      ,  "bg"  ,  "67"  ,  "bold-violet1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V2!"  ,  "bold"      ,  "bg"  ,  "68"  ,  "bold-violet2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V3!"  ,  "bold"      ,  "bg"  ,  "69"  ,  "bold-violet3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V4!"  ,  "bold"      ,  "bg"  ,  "63"  ,  "bold-violet4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V5!"  ,  "bold"      ,  "bg"  ,  "57"  ,  "bold-violet5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V6!"  ,  "bold"      ,  "bg"  ,  "56"  ,  "bold-violet6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V7!"  ,  "bold"      ,  "bg"  ,  "55"  ,  "bold-violet7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V8!"  ,  "bold"      ,  "bg"  ,  "54"  ,  "bold-violet8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W!"   ,  "bold"      ,  "bg"  ,  "255" ,  "bold-white-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W1!"  ,  "bold"      ,  "bg"  ,  "254" ,  "bold-white1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W2!"  ,  "bold"      ,  "bg"  ,  "253" ,  "bold-white2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W3!"  ,  "bold"      ,  "bg"  ,  "252" ,  "bold-white3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W4!"  ,  "bold"      ,  "bg"  ,  "251" ,  "bold-white4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W5!"  ,  "bold"      ,  "bg"  ,  "250" ,  "bold-white5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W6!"  ,  "bold"      ,  "bg"  ,  "249" ,  "bold-white6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W7!"  ,  "bold"      ,  "bg"  ,  "246" ,  "bold-white7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W8!"  ,  "bold"      ,  "bg"  ,  "243" ,  "bold-white8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O!"   ,  "bold"      ,  "bg"  ,  "9"   ,  "bold-orange-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O1!"  ,  "bold"      ,  "bg"  ,  "174" ,  "bold-orange1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O2!"  ,  "bold"      ,  "bg"  ,  "216" ,  "bold-orange2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O3!"  ,  "bold"      ,  "bg"  ,  "215" ,  "bold-orange3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O4!"  ,  "bold"      ,  "bg"  ,  "214" ,  "bold-orange4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O5!"  ,  "bold"      ,  "bg"  ,  "208" ,  "bold-orange5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O6!"  ,  "bold"      ,  "bg"  ,  "202" ,  "bold-orange6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O7!"  ,  "bold"      ,  "bg"  ,  "166" ,  "bold-orange7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O8!"  ,  "bold"      ,  "bg"  ,  "130" ,  "bold-orange8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R!"   ,  "bold"      ,  "bg"  ,  "1"   ,  "bold-red-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R1!"  ,  "bold"      ,  "bg"  ,  "197" ,  "bold-red1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R2!"  ,  "bold"      ,  "bg"  ,  "161" ,  "bold-red2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R3!"  ,  "bold"      ,  "bg"  ,  "125" ,  "bold-red3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R4!"  ,  "bold"      ,  "bg"  ,  "196" ,  "bold-red4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R5!"  ,  "bold"      ,  "bg"  ,  "160" ,  "bold-red5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R6!"  ,  "bold"      ,  "bg"  ,  "124" ,  "bold-red6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R7!"  ,  "bold"      ,  "bg"  ,  "88"  ,  "bold-red7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R8!"  ,  "bold"      ,  "bg"  ,  "52"  ,  "bold-red8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N_"   ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N1_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N2_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N3_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N4_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N5_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N6_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N7_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N8_"  ,  "underline" ,  "bg"  ,  "fg"  ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y_"   ,  "underline" ,  "bg"  ,  "3"   ,  "underline-yellow-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y1_"  ,  "underline" ,  "bg"  ,  "186" ,  "underline-yellow1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y2_"  ,  "underline" ,  "bg"  ,  "229" ,  "underline-yellow2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y3_"  ,  "underline" ,  "bg"  ,  "228" ,  "underline-yellow3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y4_"  ,  "underline" ,  "bg"  ,  "192" ,  "underline-yellow4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y5_"  ,  "underline" ,  "bg"  ,  "227" ,  "underline-yellow5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y6_"  ,  "underline" ,  "bg"  ,  "191" ,  "underline-yellow6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y7_"  ,  "underline" ,  "bg"  ,  "190" ,  "underline-yellow7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y8_"  ,  "underline" ,  "bg"  ,  "220" ,  "underline-yellow8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G_"   ,  "underline" ,  "bg"  ,  "64"  ,  "underline-green-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G1_"  ,  "underline" ,  "bg"  ,  "64"  ,  "underline-green1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G2_"  ,  "underline" ,  "bg"  ,  "48"  ,  "underline-green2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G3_"  ,  "underline" ,  "bg"  ,  "47"  ,  "underline-green3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G4_"  ,  "underline" ,  "bg"  ,  "41"  ,  "underline-green4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G5_"  ,  "underline" ,  "bg"  ,  "40"  ,  "underline-green5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G6_"  ,  "underline" ,  "bg"  ,  "34"  ,  "underline-green6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G7_"  ,  "underline" ,  "bg"  ,  "28"  ,  "underline-green7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G8_"  ,  "underline" ,  "bg"  ,  "22"  ,  "underline-green8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B_"   ,  "underline" ,  "bg"  ,  "4"   ,  "underline-blue-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B1_"  ,  "underline" ,  "bg"  ,  "45"  ,  "underline-blue1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B2_"  ,  "underline" ,  "bg"  ,  "39"  ,  "underline-blue2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B3_"  ,  "underline" ,  "bg"  ,  "33"  ,  "underline-blue3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B4_"  ,  "underline" ,  "bg"  ,  "27"  ,  "underline-blue4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B5_"  ,  "underline" ,  "bg"  ,  "20"  ,  "underline-blue5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B6_"  ,  "underline" ,  "bg"  ,  "19"  ,  "underline-blue6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B7_"  ,  "underline" ,  "bg"  ,  "18"  ,  "underline-blue7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B8_"  ,  "underline" ,  "bg"  ,  "17"  ,  "underline-blue8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M_"   ,  "underline" ,  "bg"  ,  "125" ,  "underline-magenta-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M1_"  ,  "underline" ,  "bg"  ,  "177" ,  "underline-magenta1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M2_"  ,  "underline" ,  "bg"  ,  "171" ,  "underline-magenta2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M3_"  ,  "underline" ,  "bg"  ,  "165" ,  "underline-magenta3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M4_"  ,  "underline" ,  "bg"  ,  "164" ,  "underline-magenta4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M5_"  ,  "underline" ,  "bg"  ,  "128" ,  "underline-magenta5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M6_"  ,  "underline" ,  "bg"  ,  "127" ,  "underline-magenta6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M7_"  ,  "underline" ,  "bg"  ,  "126" ,  "underline-magenta7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M8_"  ,  "underline" ,  "bg"  ,  "90"  ,  "underline-magenta8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C_"   ,  "underline" ,  "bg"  ,  "6"   ,  "underline-cyan-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C1_"  ,  "underline" ,  "bg"  ,  "159" ,  "underline-cyan1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C2_"  ,  "underline" ,  "bg"  ,  "123" ,  "underline-cyan2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C3_"  ,  "underline" ,  "bg"  ,  "87"  ,  "underline-cyan3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C4_"  ,  "underline" ,  "bg"  ,  "50"  ,  "underline-cyan4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C5_"  ,  "underline" ,  "bg"  ,  "44"  ,  "underline-cyan5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C6_"  ,  "underline" ,  "bg"  ,  "37"  ,  "underline-cyan6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C7_"  ,  "underline" ,  "bg"  ,  "30"  ,  "underline-cyan7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C8_"  ,  "underline" ,  "bg"  ,  "23"  ,  "underline-cyan8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V_"   ,  "underline" ,  "bg"  ,  "13"  ,  "underline-violet-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V1_"  ,  "underline" ,  "bg"  ,  "67"  ,  "underline-violet1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V2_"  ,  "underline" ,  "bg"  ,  "68"  ,  "underline-violet2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V3_"  ,  "underline" ,  "bg"  ,  "69"  ,  "underline-violet3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V4_"  ,  "underline" ,  "bg"  ,  "63"  ,  "underline-violet4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V5_"  ,  "underline" ,  "bg"  ,  "57"  ,  "underline-violet5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V6_"  ,  "underline" ,  "bg"  ,  "56"  ,  "underline-violet6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V7_"  ,  "underline" ,  "bg"  ,  "55"  ,  "underline-violet7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V8_"  ,  "underline" ,  "bg"  ,  "54"  ,  "underline-violet8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W_"   ,  "underline" ,  "bg"  ,  "255" ,  "underline-white-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W1_"  ,  "underline" ,  "bg"  ,  "254" ,  "underline-white1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W2_"  ,  "underline" ,  "bg"  ,  "253" ,  "underline-white2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W3_"  ,  "underline" ,  "bg"  ,  "252" ,  "underline-white3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W4_"  ,  "underline" ,  "bg"  ,  "251" ,  "underline-white4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W5_"  ,  "underline" ,  "bg"  ,  "250" ,  "underline-white5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W6_"  ,  "underline" ,  "bg"  ,  "249" ,  "underline-white6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W7_"  ,  "underline" ,  "bg"  ,  "246" ,  "underline-white7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W8_"  ,  "underline" ,  "bg"  ,  "243" ,  "underline-white8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O_"   ,  "underline" ,  "bg"  ,  "9"   ,  "underline-orange-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O1_"  ,  "underline" ,  "bg"  ,  "174" ,  "underline-orange1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O2_"  ,  "underline" ,  "bg"  ,  "216" ,  "underline-orange2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O3_"  ,  "underline" ,  "bg"  ,  "215" ,  "underline-orange3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O4_"  ,  "underline" ,  "bg"  ,  "214" ,  "underline-orange4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O5_"  ,  "underline" ,  "bg"  ,  "208" ,  "underline-orange5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O6_"  ,  "underline" ,  "bg"  ,  "202" ,  "underline-orange6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O7_"  ,  "underline" ,  "bg"  ,  "166" ,  "underline-orange7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O8_"  ,  "underline" ,  "bg"  ,  "130" ,  "underline-orange8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R_"   ,  "underline" ,  "bg"  ,  "1"   ,  "underline-red-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R1_"  ,  "underline" ,  "bg"  ,  "197" ,  "underline-red1-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R2_"  ,  "underline" ,  "bg"  ,  "161" ,  "underline-red2-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R3_"  ,  "underline" ,  "bg"  ,  "125" ,  "underline-red3-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R4_"  ,  "underline" ,  "bg"  ,  "196" ,  "underline-red4-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R5_"  ,  "underline" ,  "bg"  ,  "160" ,  "underline-red5-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R6_"  ,  "underline" ,  "bg"  ,  "124" ,  "underline-red6-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R7_"  ,  "underline" ,  "bg"  ,  "88"  ,  "underline-red7-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R8_"  ,  "underline" ,  "bg"  ,  "52"  ,  "underline-red8-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N@"   ,  "none"      ,  "fg"  ,  "bg"  ,  "none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N1@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N2@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N3@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N4@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N5@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N6@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N7@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N8@"  ,  "none"      ,  "fg"  ,  "bg"  ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y@"   ,  "none"      ,  "3"   ,  "bg"  ,  "yellow-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y1@"  ,  "none"      ,  "186" ,  "bg"  ,  "yellow1-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y2@"  ,  "none"      ,  "229" ,  "bg"  ,  "yellow2-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y3@"  ,  "none"      ,  "228" ,  "bg"  ,  "yellow3-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y4@"  ,  "none"      ,  "192" ,  "bg"  ,  "yellow4-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y5@"  ,  "none"      ,  "227" ,  "bg"  ,  "yellow5-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y6@"  ,  "none"      ,  "191" ,  "bg"  ,  "yellow6-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y7@"  ,  "none"      ,  "190" ,  "bg"  ,  "yellow7-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y8@"  ,  "none"      ,  "220" ,  "bg"  ,  "yellow8-background" ] ]
        let g:HiColorDefinitionList += [ [ "G@"   ,  "none"      ,  "64"  ,  "bg"  ,  "green-background" ] ]
        let g:HiColorDefinitionList += [ [ "G1@"  ,  "none"      ,  "64"  ,  "bg"  ,  "green1-background" ] ]
        let g:HiColorDefinitionList += [ [ "G2@"  ,  "none"      ,  "48"  ,  "bg"  ,  "green2-background" ] ]
        let g:HiColorDefinitionList += [ [ "G3@"  ,  "none"      ,  "47"  ,  "bg"  ,  "green3-background" ] ]
        let g:HiColorDefinitionList += [ [ "G4@"  ,  "none"      ,  "41"  ,  "bg"  ,  "green4-background" ] ]
        let g:HiColorDefinitionList += [ [ "G5@"  ,  "none"      ,  "40"  ,  "bg"  ,  "green5-background" ] ]
        let g:HiColorDefinitionList += [ [ "G6@"  ,  "none"      ,  "34"  ,  "bg"  ,  "green6-background" ] ]
        let g:HiColorDefinitionList += [ [ "G7@"  ,  "none"      ,  "28"  ,  "bg"  ,  "green7-background" ] ]
        let g:HiColorDefinitionList += [ [ "G8@"  ,  "none"      ,  "22"  ,  "bg"  ,  "green8-background" ] ]
        let g:HiColorDefinitionList += [ [ "B@"   ,  "none"      ,  "4"   ,  "bg"  ,  "blue-background" ] ]
        let g:HiColorDefinitionList += [ [ "B1@"  ,  "none"      ,  "45"  ,  "bg"  ,  "blue1-background" ] ]
        let g:HiColorDefinitionList += [ [ "B2@"  ,  "none"      ,  "39"  ,  "bg"  ,  "blue2-background" ] ]
        let g:HiColorDefinitionList += [ [ "B3@"  ,  "none"      ,  "33"  ,  "bg"  ,  "blue3-background" ] ]
        let g:HiColorDefinitionList += [ [ "B4@"  ,  "none"      ,  "27"  ,  "bg"  ,  "blue4-background" ] ]
        let g:HiColorDefinitionList += [ [ "B5@"  ,  "none"      ,  "20"  ,  "bg"  ,  "blue5-background" ] ]
        let g:HiColorDefinitionList += [ [ "B6@"  ,  "none"      ,  "19"  ,  "bg"  ,  "blue6-background" ] ]
        let g:HiColorDefinitionList += [ [ "B7@"  ,  "none"      ,  "18"  ,  "bg"  ,  "blue7-background" ] ]
        let g:HiColorDefinitionList += [ [ "B8@"  ,  "none"      ,  "17"  ,  "bg"  ,  "blue8-background" ] ]
        let g:HiColorDefinitionList += [ [ "M@"   ,  "none"      ,  "125" ,  "bg"  ,  "magenta-background" ] ]
        let g:HiColorDefinitionList += [ [ "M1@"  ,  "none"      ,  "177" ,  "bg"  ,  "magenta1-background" ] ]
        let g:HiColorDefinitionList += [ [ "M2@"  ,  "none"      ,  "171" ,  "bg"  ,  "magenta2-background" ] ]
        let g:HiColorDefinitionList += [ [ "M3@"  ,  "none"      ,  "165" ,  "bg"  ,  "magenta3-background" ] ]
        let g:HiColorDefinitionList += [ [ "M4@"  ,  "none"      ,  "164" ,  "bg"  ,  "magenta4-background" ] ]
        let g:HiColorDefinitionList += [ [ "M5@"  ,  "none"      ,  "128" ,  "bg"  ,  "magenta5-background" ] ]
        let g:HiColorDefinitionList += [ [ "M6@"  ,  "none"      ,  "127" ,  "bg"  ,  "magenta6-background" ] ]
        let g:HiColorDefinitionList += [ [ "M7@"  ,  "none"      ,  "126" ,  "bg"  ,  "magenta7-background" ] ]
        let g:HiColorDefinitionList += [ [ "M8@"  ,  "none"      ,  "90"  ,  "bg"  ,  "magenta8-background" ] ]
        let g:HiColorDefinitionList += [ [ "C@"   ,  "none"      ,  "6"   ,  "bg"  ,  "cyan-background" ] ]
        let g:HiColorDefinitionList += [ [ "C1@"  ,  "none"      ,  "159" ,  "bg"  ,  "cyan1-background" ] ]
        let g:HiColorDefinitionList += [ [ "C2@"  ,  "none"      ,  "123" ,  "bg"  ,  "cyan2-background" ] ]
        let g:HiColorDefinitionList += [ [ "C3@"  ,  "none"      ,  "87"  ,  "bg"  ,  "cyan3-background" ] ]
        let g:HiColorDefinitionList += [ [ "C4@"  ,  "none"      ,  "50"  ,  "bg"  ,  "cyan4-background" ] ]
        let g:HiColorDefinitionList += [ [ "C5@"  ,  "none"      ,  "44"  ,  "bg"  ,  "cyan5-background" ] ]
        let g:HiColorDefinitionList += [ [ "C6@"  ,  "none"      ,  "37"  ,  "bg"  ,  "cyan6-background" ] ]
        let g:HiColorDefinitionList += [ [ "C7@"  ,  "none"      ,  "30"  ,  "bg"  ,  "cyan7-background" ] ]
        let g:HiColorDefinitionList += [ [ "C8@"  ,  "none"      ,  "23"  ,  "bg"  ,  "cyan8-background" ] ]
        let g:HiColorDefinitionList += [ [ "V@"   ,  "none"      ,  "13"  ,  "bg"  ,  "violet-background" ] ]
        let g:HiColorDefinitionList += [ [ "V1@"  ,  "none"      ,  "67"  ,  "bg"  ,  "violet1-background" ] ]
        let g:HiColorDefinitionList += [ [ "V2@"  ,  "none"      ,  "68"  ,  "bg"  ,  "violet2-background" ] ]
        let g:HiColorDefinitionList += [ [ "V3@"  ,  "none"      ,  "69"  ,  "bg"  ,  "violet3-background" ] ]
        let g:HiColorDefinitionList += [ [ "V4@"  ,  "none"      ,  "63"  ,  "bg"  ,  "violet4-background" ] ]
        let g:HiColorDefinitionList += [ [ "V5@"  ,  "none"      ,  "57"  ,  "bg"  ,  "violet5-background" ] ]
        let g:HiColorDefinitionList += [ [ "V6@"  ,  "none"      ,  "56"  ,  "bg"  ,  "violet6-background" ] ]
        let g:HiColorDefinitionList += [ [ "V7@"  ,  "none"      ,  "55"  ,  "bg"  ,  "violet7-background" ] ]
        let g:HiColorDefinitionList += [ [ "V8@"  ,  "none"      ,  "54"  ,  "bg"  ,  "violet8-background" ] ]
        let g:HiColorDefinitionList += [ [ "W@"   ,  "none"      ,  "255" ,  "bg"  ,  "white-background" ] ]
        let g:HiColorDefinitionList += [ [ "W1@"  ,  "none"      ,  "254" ,  "bg"  ,  "white1-background" ] ]
        let g:HiColorDefinitionList += [ [ "W2@"  ,  "none"      ,  "253" ,  "bg"  ,  "white2-background" ] ]
        let g:HiColorDefinitionList += [ [ "W3@"  ,  "none"      ,  "252" ,  "bg"  ,  "white3-background" ] ]
        let g:HiColorDefinitionList += [ [ "W4@"  ,  "none"      ,  "251" ,  "bg"  ,  "white4-background" ] ]
        let g:HiColorDefinitionList += [ [ "W5@"  ,  "none"      ,  "250" ,  "bg"  ,  "white5-background" ] ]
        let g:HiColorDefinitionList += [ [ "W6@"  ,  "none"      ,  "249" ,  "bg"  ,  "white6-background" ] ]
        let g:HiColorDefinitionList += [ [ "W7@"  ,  "none"      ,  "246" ,  "bg"  ,  "white7-background" ] ]
        let g:HiColorDefinitionList += [ [ "W8@"  ,  "none"      ,  "243" ,  "bg"  ,  "white8-background" ] ]
        let g:HiColorDefinitionList += [ [ "O@"   ,  "none"      ,  "9"   ,  "bg"  ,  "orange-background" ] ]
        let g:HiColorDefinitionList += [ [ "O1@"  ,  "none"      ,  "174" ,  "bg"  ,  "orange1-background" ] ]
        let g:HiColorDefinitionList += [ [ "O2@"  ,  "none"      ,  "216" ,  "bg"  ,  "orange2-background" ] ]
        let g:HiColorDefinitionList += [ [ "O3@"  ,  "none"      ,  "215" ,  "bg"  ,  "orange3-background" ] ]
        let g:HiColorDefinitionList += [ [ "O4@"  ,  "none"      ,  "214" ,  "bg"  ,  "orange4-background" ] ]
        let g:HiColorDefinitionList += [ [ "O5@"  ,  "none"      ,  "208" ,  "bg"  ,  "orange5-background" ] ]
        let g:HiColorDefinitionList += [ [ "O6@"  ,  "none"      ,  "202" ,  "bg"  ,  "orange6-background" ] ]
        let g:HiColorDefinitionList += [ [ "O7@"  ,  "none"      ,  "166" ,  "bg"  ,  "orange7-background" ] ]
        let g:HiColorDefinitionList += [ [ "O8@"  ,  "none"      ,  "130" ,  "bg"  ,  "orange8-background" ] ]
        let g:HiColorDefinitionList += [ [ "R@"   ,  "none"      ,  "1"   ,  "bg"  ,  "red-background" ] ]
        let g:HiColorDefinitionList += [ [ "R1@"  ,  "none"      ,  "197" ,  "bg"  ,  "red1-background" ] ]
        let g:HiColorDefinitionList += [ [ "R2@"  ,  "none"      ,  "161" ,  "bg"  ,  "red2-background" ] ]
        let g:HiColorDefinitionList += [ [ "R3@"  ,  "none"      ,  "125" ,  "bg"  ,  "red3-background" ] ]
        let g:HiColorDefinitionList += [ [ "R4@"  ,  "none"      ,  "196" ,  "bg"  ,  "red4-background" ] ]
        let g:HiColorDefinitionList += [ [ "R5@"  ,  "none"      ,  "160" ,  "bg"  ,  "red5-background" ] ]
        let g:HiColorDefinitionList += [ [ "R6@"  ,  "none"      ,  "124" ,  "bg"  ,  "red6-background" ] ]
        let g:HiColorDefinitionList += [ [ "R7@"  ,  "none"      ,  "88"  ,  "bg"  ,  "red7-background" ] ]
        let g:HiColorDefinitionList += [ [ "R8@"  ,  "none"      ,  "52"  ,  "bg"  ,  "red8-background" ] ]
        let g:HiColorDefinitionList += [ [ "N@!"  ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N1@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N2@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N3@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N4@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N5@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N6@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N7@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "N8@!" ,  "bold"      ,  "fg"  ,  "bg"  ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y@!"  ,  "bold"      ,  "3"   ,  "bg"  ,  "bold-yellow-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y1@!" ,  "bold"      ,  "186" ,  "bg"  ,  "bold-yellow1-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y2@!" ,  "bold"      ,  "229" ,  "bg"  ,  "bold-yellow2-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y3@!" ,  "bold"      ,  "228" ,  "bg"  ,  "bold-yellow3-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y4@!" ,  "bold"      ,  "192" ,  "bg"  ,  "bold-yellow4-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y5@!" ,  "bold"      ,  "227" ,  "bg"  ,  "bold-yellow5-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y6@!" ,  "bold"      ,  "191" ,  "bg"  ,  "bold-yellow6-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y7@!" ,  "bold"      ,  "190" ,  "bg"  ,  "bold-yellow7-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y8@!" ,  "bold"      ,  "220" ,  "bg"  ,  "bold-yellow8-background" ] ]
        let g:HiColorDefinitionList += [ [ "G@!"  ,  "bold"      ,  "64"  ,  "bg"  ,  "bold-green-background" ] ]
        let g:HiColorDefinitionList += [ [ "G1@!" ,  "bold"      ,  "64"  ,  "bg"  ,  "bold-green1-background" ] ]
        let g:HiColorDefinitionList += [ [ "G2@!" ,  "bold"      ,  "48"  ,  "bg"  ,  "bold-green2-background" ] ]
        let g:HiColorDefinitionList += [ [ "G3@!" ,  "bold"      ,  "47"  ,  "bg"  ,  "bold-green3-background" ] ]
        let g:HiColorDefinitionList += [ [ "G4@!" ,  "bold"      ,  "41"  ,  "bg"  ,  "bold-green4-background" ] ]
        let g:HiColorDefinitionList += [ [ "G5@!" ,  "bold"      ,  "40"  ,  "bg"  ,  "bold-green5-background" ] ]
        let g:HiColorDefinitionList += [ [ "G6@!" ,  "bold"      ,  "34"  ,  "bg"  ,  "bold-green6-background" ] ]
        let g:HiColorDefinitionList += [ [ "G7@!" ,  "bold"      ,  "28"  ,  "bg"  ,  "bold-green7-background" ] ]
        let g:HiColorDefinitionList += [ [ "G8@!" ,  "bold"      ,  "22"  ,  "bg"  ,  "bold-green8-background" ] ]
        let g:HiColorDefinitionList += [ [ "B@!"  ,  "bold"      ,  "4"   ,  "bg"  ,  "bold-blue-background" ] ]
        let g:HiColorDefinitionList += [ [ "B1@!" ,  "bold"      ,  "45"  ,  "bg"  ,  "bold-blue1-background" ] ]
        let g:HiColorDefinitionList += [ [ "B2@!" ,  "bold"      ,  "39"  ,  "bg"  ,  "bold-blue2-background" ] ]
        let g:HiColorDefinitionList += [ [ "B3@!" ,  "bold"      ,  "33"  ,  "bg"  ,  "bold-blue3-background" ] ]
        let g:HiColorDefinitionList += [ [ "B4@!" ,  "bold"      ,  "27"  ,  "bg"  ,  "bold-blue4-background" ] ]
        let g:HiColorDefinitionList += [ [ "B5@!" ,  "bold"      ,  "20"  ,  "bg"  ,  "bold-blue5-background" ] ]
        let g:HiColorDefinitionList += [ [ "B6@!" ,  "bold"      ,  "19"  ,  "bg"  ,  "bold-blue6-background" ] ]
        let g:HiColorDefinitionList += [ [ "B7@!" ,  "bold"      ,  "18"  ,  "bg"  ,  "bold-blue7-background" ] ]
        let g:HiColorDefinitionList += [ [ "B8@!" ,  "bold"      ,  "17"  ,  "bg"  ,  "bold-blue8-background" ] ]
        let g:HiColorDefinitionList += [ [ "M@!"  ,  "bold"      ,  "125" ,  "bg"  ,  "bold-magenta-background" ] ]
        let g:HiColorDefinitionList += [ [ "M1@!" ,  "bold"      ,  "177" ,  "bg"  ,  "bold-magenta1-background" ] ]
        let g:HiColorDefinitionList += [ [ "M2@!" ,  "bold"      ,  "171" ,  "bg"  ,  "bold-magenta2-background" ] ]
        let g:HiColorDefinitionList += [ [ "M3@!" ,  "bold"      ,  "165" ,  "bg"  ,  "bold-magenta3-background" ] ]
        let g:HiColorDefinitionList += [ [ "M4@!" ,  "bold"      ,  "164" ,  "bg"  ,  "bold-magenta4-background" ] ]
        let g:HiColorDefinitionList += [ [ "M5@!" ,  "bold"      ,  "128" ,  "bg"  ,  "bold-magenta5-background" ] ]
        let g:HiColorDefinitionList += [ [ "M6@!" ,  "bold"      ,  "127" ,  "bg"  ,  "bold-magenta6-background" ] ]
        let g:HiColorDefinitionList += [ [ "M7@!" ,  "bold"      ,  "126" ,  "bg"  ,  "bold-magenta7-background" ] ]
        let g:HiColorDefinitionList += [ [ "M8@!" ,  "bold"      ,  "90"  ,  "bg"  ,  "bold-magenta8-background" ] ]
        let g:HiColorDefinitionList += [ [ "C@!"  ,  "bold"      ,  "6"   ,  "bg"  ,  "bold-cyan-background" ] ]
        let g:HiColorDefinitionList += [ [ "C1@!" ,  "bold"      ,  "159" ,  "bg"  ,  "bold-cyan1-background" ] ]
        let g:HiColorDefinitionList += [ [ "C2@!" ,  "bold"      ,  "123" ,  "bg"  ,  "bold-cyan2-background" ] ]
        let g:HiColorDefinitionList += [ [ "C3@!" ,  "bold"      ,  "87"  ,  "bg"  ,  "bold-cyan3-background" ] ]
        let g:HiColorDefinitionList += [ [ "C4@!" ,  "bold"      ,  "50"  ,  "bg"  ,  "bold-cyan4-background" ] ]
        let g:HiColorDefinitionList += [ [ "C5@!" ,  "bold"      ,  "44"  ,  "bg"  ,  "bold-cyan5-background" ] ]
        let g:HiColorDefinitionList += [ [ "C6@!" ,  "bold"      ,  "37"  ,  "bg"  ,  "bold-cyan6-background" ] ]
        let g:HiColorDefinitionList += [ [ "C7@!" ,  "bold"      ,  "30"  ,  "bg"  ,  "bold-cyan7-background" ] ]
        let g:HiColorDefinitionList += [ [ "C8@!" ,  "bold"      ,  "23"  ,  "bg"  ,  "bold-cyan8-background" ] ]
        let g:HiColorDefinitionList += [ [ "V@!"  ,  "bold"      ,  "13"  ,  "bg"  ,  "bold-violet-background" ] ]
        let g:HiColorDefinitionList += [ [ "V1@!" ,  "bold"      ,  "67"  ,  "bg"  ,  "bold-violet1-background" ] ]
        let g:HiColorDefinitionList += [ [ "V2@!" ,  "bold"      ,  "68"  ,  "bg"  ,  "bold-violet2-background" ] ]
        let g:HiColorDefinitionList += [ [ "V3@!" ,  "bold"      ,  "69"  ,  "bg"  ,  "bold-violet3-background" ] ]
        let g:HiColorDefinitionList += [ [ "V4@!" ,  "bold"      ,  "63"  ,  "bg"  ,  "bold-violet4-background" ] ]
        let g:HiColorDefinitionList += [ [ "V5@!" ,  "bold"      ,  "57"  ,  "bg"  ,  "bold-violet5-background" ] ]
        let g:HiColorDefinitionList += [ [ "V6@!" ,  "bold"      ,  "56"  ,  "bg"  ,  "bold-violet6-background" ] ]
        let g:HiColorDefinitionList += [ [ "V7@!" ,  "bold"      ,  "55"  ,  "bg"  ,  "bold-violet7-background" ] ]
        let g:HiColorDefinitionList += [ [ "V8@!" ,  "bold"      ,  "54"  ,  "bg"  ,  "bold-violet8-background" ] ]
        let g:HiColorDefinitionList += [ [ "W@!"  ,  "bold"      ,  "255" ,  "bg"  ,  "bold-white-background" ] ]
        let g:HiColorDefinitionList += [ [ "W1@!" ,  "bold"      ,  "254" ,  "bg"  ,  "bold-white1-background" ] ]
        let g:HiColorDefinitionList += [ [ "W2@!" ,  "bold"      ,  "253" ,  "bg"  ,  "bold-white2-background" ] ]
        let g:HiColorDefinitionList += [ [ "W3@!" ,  "bold"      ,  "252" ,  "bg"  ,  "bold-white3-background" ] ]
        let g:HiColorDefinitionList += [ [ "W4@!" ,  "bold"      ,  "251" ,  "bg"  ,  "bold-white4-background" ] ]
        let g:HiColorDefinitionList += [ [ "W5@!" ,  "bold"      ,  "250" ,  "bg"  ,  "bold-white5-background" ] ]
        let g:HiColorDefinitionList += [ [ "W6@!" ,  "bold"      ,  "249" ,  "bg"  ,  "bold-white6-background" ] ]
        let g:HiColorDefinitionList += [ [ "W7@!" ,  "bold"      ,  "246" ,  "bg"  ,  "bold-white7-background" ] ]
        let g:HiColorDefinitionList += [ [ "W8@!" ,  "bold"      ,  "243" ,  "bg"  ,  "bold-white8-background" ] ]
        let g:HiColorDefinitionList += [ [ "O@!"  ,  "bold"      ,  "9"   ,  "bg"  ,  "bold-orange-background" ] ]
        let g:HiColorDefinitionList += [ [ "O1@!" ,  "bold"      ,  "174" ,  "bg"  ,  "bold-orange1-background" ] ]
        let g:HiColorDefinitionList += [ [ "O2@!" ,  "bold"      ,  "216" ,  "bg"  ,  "bold-orange2-background" ] ]
        let g:HiColorDefinitionList += [ [ "O3@!" ,  "bold"      ,  "215" ,  "bg"  ,  "bold-orange3-background" ] ]
        let g:HiColorDefinitionList += [ [ "O4@!" ,  "bold"      ,  "214" ,  "bg"  ,  "bold-orange4-background" ] ]
        let g:HiColorDefinitionList += [ [ "O5@!" ,  "bold"      ,  "208" ,  "bg"  ,  "bold-orange5-background" ] ]
        let g:HiColorDefinitionList += [ [ "O6@!" ,  "bold"      ,  "202" ,  "bg"  ,  "bold-orange6-background" ] ]
        let g:HiColorDefinitionList += [ [ "O7@!" ,  "bold"      ,  "166" ,  "bg"  ,  "bold-orange7-background" ] ]
        let g:HiColorDefinitionList += [ [ "O8@!" ,  "bold"      ,  "130" ,  "bg"  ,  "bold-orange8-background" ] ]
        let g:HiColorDefinitionList += [ [ "R@!"  ,  "bold"      ,  "1"   ,  "bg"  ,  "bold-red-background" ] ]
        let g:HiColorDefinitionList += [ [ "R1@!" ,  "bold"      ,  "197" ,  "bg"  ,  "bold-red1-background" ] ]
        let g:HiColorDefinitionList += [ [ "R2@!" ,  "bold"      ,  "161" ,  "bg"  ,  "bold-red2-background" ] ]
        let g:HiColorDefinitionList += [ [ "R3@!" ,  "bold"      ,  "125" ,  "bg"  ,  "bold-red3-background" ] ]
        let g:HiColorDefinitionList += [ [ "R4@!" ,  "bold"      ,  "196" ,  "bg"  ,  "bold-red4-background" ] ]
        let g:HiColorDefinitionList += [ [ "R5@!" ,  "bold"      ,  "160" ,  "bg"  ,  "bold-red5-background" ] ]
        let g:HiColorDefinitionList += [ [ "R6@!" ,  "bold"      ,  "124" ,  "bg"  ,  "bold-red6-background" ] ]
        let g:HiColorDefinitionList += [ [ "R7@!" ,  "bold"      ,  "88"  ,  "bg"  ,  "bold-red7-background" ] ]
        let g:HiColorDefinitionList += [ [ "R8@!" ,  "bold"      ,  "52"  ,  "bg"  ,  "bold-red8-background" ] ]

        let g:HiBaseColors = "none yellow green blue magenta cyan violet white orange red "

        let g:HiColorIds = "N Y G B M C V W O R "
    else
        echom "HighlightMatch Term 16 config"

        highlight! HiColorN   cterm=none      ctermbg=bg ctermfg=fg
        highlight! HiColorY   cterm=none      ctermbg=bg ctermfg=3
        highlight! HiColorG   cterm=none      ctermbg=bg ctermfg=2
        highlight! HiColorB   cterm=none      ctermbg=bg ctermfg=4
        highlight! HiColorM   cterm=none      ctermbg=bg ctermfg=5
        highlight! HiColorC   cterm=none      ctermbg=bg ctermfg=6
        highlight! HiColorV   cterm=none      ctermbg=bg ctermfg=61
        highlight! HiColorW   cterm=none      ctermbg=bg ctermfg=7
        highlight! HiColorO   cterm=none      ctermbg=bg ctermfg=9
        highlight! HiColorR   cterm=none      ctermbg=bg ctermfg=1
        highlight! HiColorNB  cterm=bold      ctermbg=bg ctermfg=fg
        highlight! HiColorYB  cterm=bold      ctermbg=bg ctermfg=3
        highlight! HiColorGB  cterm=bold      ctermbg=bg ctermfg=2
        highlight! HiColorBB  cterm=bold      ctermbg=bg ctermfg=4
        highlight! HiColorMB  cterm=bold      ctermbg=bg ctermfg=5
        highlight! HiColorCB  cterm=bold      ctermbg=bg ctermfg=6
        highlight! HiColorVB  cterm=bold      ctermbg=bg ctermfg=61
        highlight! HiColorWB  cterm=bold      ctermbg=bg ctermfg=7
        highlight! HiColorOB  cterm=bold      ctermbg=bg ctermfg=9
        highlight! HiColorRB  cterm=bold      ctermbg=bg ctermfg=1
        highlight! HiColorNU  cterm=underline ctermbg=bg ctermfg=fg
        highlight! HiColorYU  cterm=underline ctermbg=bg ctermfg=3
        highlight! HiColorGU  cterm=underline ctermbg=bg ctermfg=2
        highlight! HiColorBU  cterm=underline ctermbg=bg ctermfg=4
        highlight! HiColorMU  cterm=underline ctermbg=bg ctermfg=5
        highlight! HiColorCU  cterm=underline ctermbg=bg ctermfg=6
        highlight! HiColorVU  cterm=underline ctermbg=bg ctermfg=61
        highlight! HiColorWU  cterm=underline ctermbg=bg ctermfg=7
        highlight! HiColorOU  cterm=underline ctermbg=bg ctermfg=9
        highlight! HiColorRU  cterm=underline ctermbg=bg ctermfg=1
        highlight! HiColorNH  cterm=none      ctermbg=fg ctermfg=bg
        highlight! HiColorYH  cterm=none      ctermbg=3  ctermfg=bg
        highlight! HiColorGH  cterm=none      ctermbg=2  ctermfg=bg
        highlight! HiColorBH  cterm=none      ctermbg=4  ctermfg=bg
        highlight! HiColorMH  cterm=none      ctermbg=5  ctermfg=bg
        highlight! HiColorCH  cterm=none      ctermbg=6  ctermfg=bg
        highlight! HiColorVH  cterm=none      ctermbg=61 ctermfg=bg
        highlight! HiColorWH  cterm=none      ctermbg=7  ctermfg=bg
        highlight! HiColorOH  cterm=none      ctermbg=9  ctermfg=bg
        highlight! HiColorRH  cterm=none      ctermbg=1  ctermfg=bg
        highlight! HiColorNHB cterm=bold      ctermbg=fg ctermfg=bg
        highlight! HiColorYHB cterm=bold      ctermbg=3  ctermfg=bg
        highlight! HiColorGHB cterm=bold      ctermbg=2  ctermfg=bg
        highlight! HiColorBHB cterm=bold      ctermbg=4  ctermfg=bg
        highlight! HiColorMHB cterm=bold      ctermbg=5  ctermfg=bg
        highlight! HiColorCHB cterm=bold      ctermbg=6  ctermfg=bg
        highlight! HiColorVHB cterm=bold      ctermbg=61 ctermfg=bg
        highlight! HiColorWHB cterm=bold      ctermbg=7  ctermfg=bg
        highlight! HiColorOHB cterm=bold      ctermbg=9  ctermfg=bg
        highlight! HiColorRHB cterm=bold      ctermbg=1  ctermfg=bg

        let g:HiColorDefinitionList = []
        let g:HiColorDefinitionList += [ [ "N"   ,  "none"      ,  "bg" ,  "fg" ,  "none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y"   ,  "none"      ,  "bg" ,  "3"  ,  "yellow-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G"   ,  "none"      ,  "bg" ,  "2"  ,  "green-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B"   ,  "none"      ,  "bg" ,  "4"  ,  "blue-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M"   ,  "none"      ,  "bg" ,  "5"  ,  "magenta-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C"   ,  "none"      ,  "bg" ,  "6"  ,  "cyan-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V"   ,  "none"      ,  "bg" ,  "61" ,  "violet-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W"   ,  "none"      ,  "bg" ,  "7"  ,  "white-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O"   ,  "none"      ,  "bg" ,  "9"  ,  "orange-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R"   ,  "none"      ,  "bg" ,  "1"  ,  "red-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N!"  ,  "bold"      ,  "bg" ,  "fg" ,  "bold-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y!"  ,  "bold"      ,  "bg" ,  "3"  ,  "bold-yellow-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G!"  ,  "bold"      ,  "bg" ,  "2"  ,  "bold-green-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B!"  ,  "bold"      ,  "bg" ,  "4"  ,  "bold-blue-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M!"  ,  "bold"      ,  "bg" ,  "5"  ,  "bold-magenta-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C!"  ,  "bold"      ,  "bg" ,  "6"  ,  "bold-cyan-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V!"  ,  "bold"      ,  "bg" ,  "61" ,  "bold-violet-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W!"  ,  "bold"      ,  "bg" ,  "7"  ,  "bold-white-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O!"  ,  "bold"      ,  "bg" ,  "9"  ,  "bold-orange-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R!"  ,  "bold"      ,  "bg" ,  "1"  ,  "bold-red-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N_"  ,  "underline" ,  "bg" ,  "fg" ,  "underline-none-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "Y_"  ,  "underline" ,  "bg" ,  "3"  ,  "underline-yellow-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "G_"  ,  "underline" ,  "bg" ,  "2"  ,  "underline-green-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "B_"  ,  "underline" ,  "bg" ,  "4"  ,  "underline-blue-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "M_"  ,  "underline" ,  "bg" ,  "5"  ,  "underline-magenta-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "C_"  ,  "underline" ,  "bg" ,  "6"  ,  "underline-cyan-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "V_"  ,  "underline" ,  "bg" ,  "61" ,  "underline-violet-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "W_"  ,  "underline" ,  "bg" ,  "7"  ,  "underline-white-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "O_"  ,  "underline" ,  "bg" ,  "9"  ,  "underline-orange-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "R_"  ,  "underline" ,  "bg" ,  "1"  ,  "underline-red-foreground" ] ]
        let g:HiColorDefinitionList += [ [ "N@"  ,  "none"      ,  "fg" ,  "bg" ,  "none-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y@"  ,  "none"      ,  "3"  ,  "bg" ,  "yellow-background" ] ]
        let g:HiColorDefinitionList += [ [ "G@"  ,  "none"      ,  "2"  ,  "bg" ,  "green-background" ] ]
        let g:HiColorDefinitionList += [ [ "B@"  ,  "none"      ,  "4"  ,  "bg" ,  "blue-background" ] ]
        let g:HiColorDefinitionList += [ [ "M@"  ,  "none"      ,  "5"  ,  "bg" ,  "magenta-background" ] ]
        let g:HiColorDefinitionList += [ [ "C@"  ,  "none"      ,  "6"  ,  "bg" ,  "cyan-background" ] ]
        let g:HiColorDefinitionList += [ [ "V@"  ,  "none"      ,  "61" ,  "bg" ,  "violet-background" ] ]
        let g:HiColorDefinitionList += [ [ "W@"  ,  "none"      ,  "7"  ,  "bg" ,  "white-background" ] ]
        let g:HiColorDefinitionList += [ [ "O@"  ,  "none"      ,  "9"  ,  "bg" ,  "orange-background" ] ]
        let g:HiColorDefinitionList += [ [ "R@"  ,  "none"      ,  "1"  ,  "bg" ,  "red-background" ] ]
        let g:HiColorDefinitionList += [ [ "N@!" ,  "bold"      ,  "fg" ,  "bg" ,  "bold-none-background" ] ]
        let g:HiColorDefinitionList += [ [ "Y@!" ,  "bold"      ,  "3"  ,  "bg" ,  "bold-yellow-background" ] ]
        let g:HiColorDefinitionList += [ [ "G@!" ,  "bold"      ,  "2"  ,  "bg" ,  "bold-green-background" ] ]
        let g:HiColorDefinitionList += [ [ "B@!" ,  "bold"      ,  "4"  ,  "bg" ,  "bold-blue-background" ] ]
        let g:HiColorDefinitionList += [ [ "M@!" ,  "bold"      ,  "5"  ,  "bg" ,  "bold-magenta-background" ] ]
        let g:HiColorDefinitionList += [ [ "C@!" ,  "bold"      ,  "6"  ,  "bg" ,  "bold-cyan-background" ] ]
        let g:HiColorDefinitionList += [ [ "V@!" ,  "bold"      ,  "61" ,  "bg" ,  "bold-violet-background" ] ]
        let g:HiColorDefinitionList += [ [ "W@!" ,  "bold"      ,  "7"  ,  "bg" ,  "bold-white-background" ] ]
        let g:HiColorDefinitionList += [ [ "O@!" ,  "bold"      ,  "9"  ,  "bg" ,  "bold-orange-background" ] ]
        let g:HiColorDefinitionList += [ [ "R@!" ,  "bold"      ,  "1"  ,  "bg" ,  "bold-red-background" ] ]

        let g:HiBaseColors = "none yellow green blue magenta cyan violet white orange red "

        let g:HiColorIds = "N Y G B M C V W O R "
    endif
endif
