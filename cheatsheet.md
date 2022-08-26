# cheatsheet

f1      Open cheatsheet

⌘ ,     Edit kitty.conf options                 ⌘ ⌃ ,   Reload kitty.conf options
⌘ ⌥ ,   Debug kitty.conf options

⌘ t     New Tab                                 ⌘ w     Close tab
⌘ ⌥ t   Rename tab                              ⌘ ↑     Detach Tab
⌘ →     Next Tab                                ⌘ ←     Previous Tab
⌘ ⌥ →   Move Tab Forward                        ⌘ ⌥ ←   Move Tab Backwards

⌘ ⏎     Split Window                            ⌘ l     Cycle through layouts
⌘ ⇧ ⏎   Split Window with CWD
⌘ ⇧ d   Close Split Window                      ⌘ ⇧ ↑   Detach Split Window
⌘ ⇧ →   Next Split Window                       ⌘ ⇧ ←   Previous Split Window
⌘ ⇧ ⌥ → Move Split Window Forward               ⌘ ⇧ ⌥ ← Move Split Window Backwards

⌘ k     Clear terminal
⌘ f     Find - Load scrollback into bat         ⌘ ⇧ f   Find - Search scrollback with fzf

⌃ d     Close shell                             ⌃ ⌥     Select columns of text with mouse
⌃ r     Search history with fzf                 ⌃ t     Find relative file path with fzf

⇥       Autocomplete                            /       Autocomplete continue
.       Autocomplete next group                 ,       Autocomplete previous group

kitty +kitten themes
clone-in-kitty --type=tab

Run the following command if you are seeing messages like "WARNING: terminal is not fully functional" or "'xterm-kitty': unknown terminal type" on remote machines (this will install the xterm-kitty terminfo)
`$ ssh-kitty-terminfo user@remote`

## less pager

h       Help
/       Search forward                          ?       Search backward
n       Next search result                      ⇧ n     Previous search result

## nano

⌃ 6     Set Mark (ie. start selection) / Unset Mark (ie. cancel selection)
⌃ k     Cut (selection or entire line)          ⌃ u     UnCut Text (ie. paste)

## reference

⌘ command   ⌥ option    ⌃ control   ⇧ shift
⏎ return    ⇥ tab       → right     ← left
