# REMOTE-DUDE
Windows Remote Administration Tool

REMOTE DUDE started as a simple bat file to get things done quicker at work, over time it became bigger than i expected and may be of use to someone else out there.

It was written out of necessity to be a fast and lightwight administration tool for domain-joined windows systems. As most remote administration tools for windows do lots of stuff without your interaction (like pinging machines to see if theyre up), and are also heavily GUI based. As such i consider the majority of similar tools to be bloated and slow.

REMOTE DUDE runs in a command prompt and dosent do anything unless you tell it to, therefore it's quite fast in the right environment. It makes heavy use of the sysinternals "psexec" tool, and uses common Windows components where availible. Most of its functionality depends on 2 things; being executed with a Windows domain account in the Administrators group, as well as having access to the "c$" share of target machines.

It currently needs a bit of cleaning up before posting here to github, as well as being made more portable. But, it will pop up here sometime soon.

Future goals after release to github include possibly adding a credential manager, as well as porting it to linux.
