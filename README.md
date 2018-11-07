# REMOTE-DUDE
A Windows Remote Administration Tool

REMOTE DUDE started as a simple .bat file to get things done quicker at work, over time it became bigger than i expected and may be of use to someone else out there.

It was written out of necessity to be a fast and lightwight administration tool for domain-joined Windows systems. Most remote administration tools for Windows do lots of things without your interaction (like pinging machines to see if theyre up), and are also heavily GUI based. I've found that the majority of similar tools are bloated and slow because of such design choices.

REMOTE DUDE runs in a command prompt and doesn't do anything unless you tell it to, therefore it's quite fast in the right environment. It makes heavy use of the SysInternals "psexec" tool, and uses common Windows components where availible. Most of its functionality depends on 2 things; being executed with a Windows domain account in the Administrators group, as well as having access to the "c$" share of target machines.

Dependencies:
I just recently added an updater script which also handles installing dependencies.
The only thing that must be set up first is Chocolately package manager, which can be installed from within Remote Dude by setting localhost as option 2, then navigating to the package manager menu.

![alt text](https://github.com/albanqafa/REMOTE-DUDE/blob/master/screenshot.PNG)
