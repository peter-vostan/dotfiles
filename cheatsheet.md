# cheatsheet

## general

⌘ t     New Tab                                 ⌘ w     Close tab

⌃ l     Clear terminal                          ⌃ d     Close shell
⌃ r     Search history with fzf                 ⌃ t     Find relative file path with fzf

⇥       Autocomplete                            /       Autocomplete continue
.       Autocomplete next group                 ,       Autocomplete previous group

## kitty

⌘ ,     Edit kitty.conf options                 ⌘ ⌃ ,   Reload kitty.conf options
⌘ ⌥ ,   Debug kitty.conf options

⌘ ⌥ t   Rename tab
⌘ →     Next Tab                                ⌘ ←     Previous Tab
⌘ ⌥ →   Move Tab Forward                        ⌘ ⌥ ←   Move Tab Backwards

⌘ ⏎     Split window                            ⌘ l     Cycle through layouts
⌘ ⇧ →   Next Split Pane                         ⌘ ⇧ ←   Previous Split Pane
⌘ ⇧ ⌥ → Move Split Pane Forward                 ⌘ ⇧ ⌥ ← Move Split Pane Backwards

⌘ f     Find - Load scrollback into bat         ⌘ ⇧ f   Find - Search scrollback with fzf

⌃ ⌥     Select columns of text with mouse

kitty +kitten themes
clone-in-kitty --type=tab

Run the following command if you are seeing messages like "WARNING: terminal is not fully functional" or "'xterm-kitty': unknown terminal type" on remote machines (this will install the xterm-kitty terminfo)
`$ ssh-kitty-terminfo user@remote`

## less pager

h       Help
/       Search forward                          ?       Search backward
n       Next search result                      ⇧ n     Previous search result

## reference

⌘ command   ⌥ option    ⌃ control   ⇧ shift
⏎ return    ⇥ tab       → right     ← left
