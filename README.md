# hi.vim

First at [vim.org/hi.vim](https://www.vim.org/scripts/script.php?script_id=5887)

Vim plugin for text highlight and filter.

This is a complex tool for log analysis. 

This script allows you to highlight the words, sentences or regular expressions you need, on up to 82 colors, and 410 color configurations, when including foreground colors, background colors, bold and underline configurations.

## INSTALL:

Minimum version: Vim 7.0+
Recomended version: Vim 8.0+

Binaries recommended: ag (silver searcher) or grep. Needed for the filter window.

To install with vimball:
- download hi_2.0.8.vmb
- vim hi_2.0.8.vmb
- :so %
- :q


## USAGE:

### 1) HIGHLIGHT COLORS:

Commands Hicol (highlight colors) and Hiid (highlight IDs) display the available colors.
Examples:
```vimscript
" Show basic color IDs: :Hiid
```

```vimscript
" Show all color IDs:
:Hiid all
```

":Hid all" will show all color ID available:

![Hiid_all](Hiid_all.png?raw=true ":Hiid all")

```vimscript
" Show all color IDs:
:Hicol all
```

":Hicol all" will show all colors available:

![Hiid_all](Hicol_all.png?raw=true ":Hicol all")

```vimscript
" Show red color IDs:
:Hicol r

" Show red color IDs including bold, underline and background colors:
:Hicol r all

" Show red and orange color IDs:
:Hiid r o

" Show red and orange color IDs including bold, underline and background colors:
:Hicol r o all
```

The n color ID is a special ID with no color highlight, its use is to mark patterns to be included later on the filter window without highlighting them.


### 2) TEXT EXAMPLE:

This is a little complex to explain so, let's write a text example to try the commands.

Write the following lines to a new buffer:
```
Example pattern1
Some more text with no highlights
Example pattern2
EXAMPLE PATTERN3
Example pattern4
Some more text with no highlights
Example pattern5
Example pattern6
Some more text with no highlights
Example pattern7
Example pattern8
Some more text with no highlights
Some more text with no highlights
Example pattern9
This is my pattern_10 example number 10
Example pattern_11 add to filter without highlighting
Some more text with no highlights
Some more text with no highlights
Example pattern_12
Example pattern_13
Example pattern_14
```


### 3) HIGHLIGHT COMMANDS:

To perform a color highlight, use command :Hic pattern colorID.

Threre are some modifiers that can be appended to color ID in order to obtain a different color result:
- Append * to to color ID to highlight all line.
- Append @ to to color ID to highlight the background instead of foreground (default).
- Append ! to to color ID to highlight in bold characters.
- Append _ to to color ID to highlight underlined.
- Append 0 to to color ID to highlight on top of a previous highlight.

Examples:
```vimscript
" Highlight word pattern1 in red color
:Hic pattern1 r

" Highlight word pattern2 in green color
:Hic pattern2 g

" Highlight word pattern3, case sensitive, in green2 color
:Hic \CPattern3 g2

" Highlight word pattern4, no case sensitive, in green5 color
:Hic \cpattern4 g5

" Highlight word pattern5 in yellow and bold
:Hic pattern5 y!

" Highlight word pattern6 in magenta underlined
:Hic pattern6 m_

" Highlight word pattern7 in violet background
:Hic pattern7 v@

" Highlight word pattern8 in violet background and bold text
:Hic pattern8 v@!

" Highlight the whole line containing word pattern9 background in red color
:Hic pattern9 r@*

" Highlight the regular expression my.*pattern_10 in green4 color
:Hic my.*pattern_10 g4

" Highlight in 'none' color
:Hic pattern_11 n

" Highlight word pattern_12 in blue3 and bold text
:Hic pattern_12 b3!

" Highlight word pattern_13 in cyan and underline text
:Hic pattern_13 c_

" Highlight the whole line containing pattern_14 in cyan and underline text
:Hic pattern_14 c_*

" Highlight the character 8 on top of the already highlighted pattern6 in cyan background
:Hic 6 c0

" Highlight the character 8 on top of the already highlighted pattern8 in cyan background
:Hic 8 c@0
```

When doing :Hif and :Hie, you should have this:

![Example1](hi_vim_example1.png?raw=true ":example1")


When using command ":Hicol PATTERN", omit the color ID to choose the color from a menu showing the basic colors.

Use ':Hish' to display the current color highlighting configuration.

Use \<leader>hw to highlight a word.

Use \<leader>hW to highlight the whole word.


### 4) SEARCH COMMAND:

Use command :Hics colorId, to search all patterns highlighted with the selected color IDs.

Examples:
```vimscript
" Search all red highlighted patterns:
:Hics r

" Search all red and yellow highlighted patterns:
:Hics r y

" Search all red foreground and red background highlighted patterns:
:Hics r@ r

" Search all highlights:
:Hics
```

### 5) CONFIGURATION SAVE COMMANDS:

Configurations can be saved on file to use them later again.

There are three basic configuration files:
- currenFile_vim_hi.cfg:  configurations only visible when vim is editing this file (currentFile).
- currenDir/.vim_hi.cfg: configurations only visible when vim is open on this directory.
- ~/.vim_hi.cfg:  general configurations, always available.

Examples:
```vimscript
" Save current highlight configuration with name:
" (You will be asked the file where the configuration will be saved)
:Hisv MyConfig

" Add a new configuration file:
:Hil MyConfigFile

" Edit all configuration files availble:
:Hicfg
```

### 6) CONFIGURATION FORMAT:

The configuration file is saved with ini file format.

This are all the allowed field names:
- [Name]: this is the configuration name.
- Mark: apply a highlight.
- Filt: open a filter window with the selected patterns or colors.
- Conf: apply a saved configuration type.
- Find: search a pattern or a highlight color
- Goto: change focus to main (init) window, filter window (parent/son) or last filter window.

Configuration format example:
```
[ConfigName]
Mark = ColorID|Flags|Patterns
Conf = clean
# this is a commented line
Conf = configName
Conf = configName1 configName2 configNameN
Conf = edit
Filt = close
Filt = colorID
Filt = colorID1 colorID2 colorIDN
Find = colorID
Find = colorID1 colorID2 colorIDN
Find = pattern colorID
Goto = init
Goto = son
Goto = parent
Goto = last
```

### 7) CONFIGURATION LOAD COMMANDS:

Configurations can be loaded with command :Hit (highlight types).

Examples:
- Show all available configurations :Hit
- Load the first configuration :Hit 1
- Load a configuration with name MyConfig :Hit MyConfig
- Remove any configuration, clean all highlighting :Hit 0

When launching Hit command you should see a menu like this:
```
  0)  Clear all
  1)  MyConfig
Select type:
```


### 8) FILTER WINDOW:

Filter tool, allows to open a separated split containing only the selected highlights with command Hif (highlight filter).

Use command Hif color/pattern.

Examples:
- Open a filter window displaying all lines with highlights :Hif
- Close previous filter and open a filter window displaying all lines with red highlights :close | Hif r
- Close previous filter and open a filter window displaying all lines with red  and green highlights :close | Hif r g2
- Close previous filter and open a filter window displaying all lines with green  and green1 highlights :close | Hif g2 g5
- Close previous filter and open a filter window displaying all lines with background green and red highlights :close | Hif v@ r@
- Close previous filter and open a filter window displaying all lines with word example :close | Hif example
- Close previous filter and open a filter window displaying all lines with word example and any red highlighted pattern :close | Hif This r

When launching this last command you'll see a new split showing:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ HI PLUGIN. FILTER WINDOW                      ┃
┃ Filter patterns: "pattern1|This"              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
Example pattern1
This is my pattern_10 example number 10
```

Once the filter window's opened, use ENTER key to synchronize the window position between main and filter windows (you can use :Hip command too).

Once the filter window's opened, use Alt+ENTER key to synchronize the window position between main and filter windows and switch the focus between main and filter splits (you can use :Hips command too).


### 9) EDITOR window:

The highlight configuration editor window allows a more convenient edit of the highlights and filters to apply. Open it with Hie (highlight edit).

Use :Hie to open the editor window (<leader>he too) on vertical split on the right side.

If you followed the previous example you'll see:

```  
┌───────────────────────────────────────┐
│ HIGHLIGHT CONFIG:                     │
└───────────────────────────────────────┘
Mark = r    | C    |pattern1
Mark = g    | C    |pattern2
Mark = g2   | C    |PATTERN3
Mark = g5   | c    |Pattern4
Mark = y!   | C    |pattern5
Mark = m_   | C    |pattern6
Mark = v@   | C    |pattern7
Mark = v    | Cl   |pattern8
Mark = r@   | Cl   |pattern9
Mark = g4   | C    |my.*pattern_10
Mark = n    | C    |pattern_11
Mark = b3!  | C    |pattern_12
Mark = c3_  | C    |pattern_13
Mark = c3_  | Cl   |pattern_14
Mark = c    | CT   |6
Mark = c@   | CT   |8
```

Edit the highlight configuration paragraph and replace it with this self explanatory one:
```
┌───────────────────────────────────────┐
│ HIGHLIGHT CONFIG:                     │
└───────────────────────────────────────┘
#------------------------------------------
# Clean previous highlights and filters
Conf = clear
Filt = close
#------------------------------------------
# Highlight commands:
Mark = r    | C    |pattern1
Mark = g    | C    |pattern2
Mark = g2   | C    |PATTERN3
Mark = g5   | c    |Pattern4
Mark = y!   | C    |pattern5
Mark = m_   | C    |pattern6
Mark = v@   | C    |pattern7
Mark = v    | Cl   |pattern8
Mark = r@   | Cl   |pattern9
Mark = g4   | C    |my.*pattern_10
Mark = n    | C    |pattern_11
Mark = b3!  | C    |pattern_12
Mark = c3_  | C    |pattern_13
Mark = c3_  | Cl   |pattern_14
Mark = c    | CT   |6
Mark = c@   | CT   |8
#------------------------------------------
# Filter commands:
Filt = all
#Filt = r g4 m r@
#------------------------------------------
# Search commands:
Find g4
```
Attention: the firs blank line will end the configuration parser on the editor window..

A blank line is mandatory to at the configuration end to stop config parser.

When changing to any other split the editor window will stay minimized, if you change the focus to the editor split again it will expand to its original size.

Add \# character at the beginning of line to comment any configuration command.

Use ENTER key to apply the configuration once finished editing

Use command :Hiy to yank this configuration to the default buffer and :Hicfg to open the configuration files and paste the configuration on the file you want.



### 10) AUTOLOAD CONFIG LINE (NEW Version 2.0.2)

Autoload a config highlight type defined on firs/last five lines of the file.

The configuration line will be checked and applied, if found, on file's open or reload.

Atuo configuration line examples:

Example 1: load highlight type MY_CONFIG (must be present on the default configuration files: ~/.vim_hi.cfg or ./.vim_hi.cfg)
```
vim_hi:cfg=MY_CONFIG
```
Example 2: load configuration file MY_CONFIG_FILE and then apply the highlight type MY_CONFIG.
```
vim_hi:cfg=MY_CONFIG::cfgfile=MY_CONFIG_FILE
```
  
Example 3 and 4: same as example 2
```  
# vim_hi:cfg=MY_CONFIG::cfgfile=MY_CONFIG_FILE
// vim_hi:cfg=MY_CONFIG::cfgfile=MY_CONFIG_FILE
```  

If you want to perform a highlight config auto load whenever a .log file is opened, add to your .vimrc:
```
augroup HiAutoConfig
     au BufRead *.log call hi#autoConfig#ApplyConfig("MyLogConfig", "MyConfigFile.cfg")
augroup END
```

Last version (2.0.7) allow to have both configuration and autoload line on the file you want to highlitght by defining cfgFile as %.
The configuration selected (ErrorHighlightConfig) will be searched on the first and last 150 lines of the current file.
e.g:
```  
[ErrorHighlightConfig]
Mark = r | CT | Error:
Mark = r | CT | Failure:
vim_hi:cfg=ErrorHighlightConfig::cfgFile=%
```

### 11) HIGHLIGHT GROUPS (NEW Version 2.0.2)

New tag '??' allows to filter several configurations at a time.

Example 1: filter all background highlighted patterns.
```
:Hif @??
```
  
Example 2: filter all underlined patterns.
```
:Hif _??
```
  
Example 3: filter all bold highlighted patterns.
```
:Hif !??
```
  
Example 4: filter all red highlighted patterns.
```
:Hif r*??
```
  
Example 5: filter all red backgraound highlighted patterns.
```
:Hif r*@??
```
  

### 13) command menu:

Use ":Hi" without arguments, to open a menu window displaying all commands.

Use ":Hi PATTERN1 PATTERN2", with arguments, to show the commands matching the selected patterns.

Then you can select on the menu window the command you want to launch..

For instance:
```vimscript
" To show all commands and descriptions matching "color".
:Hi color

" To show all commands and descriptions matching "filter".
:Hi filter

" To show all commands and descriptions matching "filter" and "synch".
:Hi filter sync

" Show all commands available.
":Hi
```
