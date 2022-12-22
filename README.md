# CLI Script to simplify routine banning, unbanning and checking if an IP address is banned.
## Principles
This program is designed to be used easily with both a normal CLI approach **OR** using other automation software.

**NO WARRANTY EXPRESSED OR IMPLIED**

For this reason, I went through extra steps to ensure that this program could be safely used by less technical personel.

Of course, the end use bares the ultimate responsibility for running this program is a safe fashion.

To promote easy development, I bundled each part of this program into a function.
- If you don't want to sanity check the IP address, remove references to that function after the `#main` comment on line ~74
- If you don't want to restrict the targetting of internal addresses, remove that nested if statement.
- If you want to add additional switches, create functions for them, modify the help text and modify the case statements after the `#main` comment!

## TODO
Certainly this program isn't perfect.

I would like to explore shorter regex expressions to solve the IP testing issue.

I would like to add another case to allow the user to pass a file that gets looped.

###### Designed by Justin Powell using Manjaro, Emacs.
###### Tested on Manjaro and Ubuntu.
###### Free to use! Please share changes so I can improve my code!
###### SUPPORT FREE AND OPEN SOFTWARE ***(Not Mine, Others)***!
