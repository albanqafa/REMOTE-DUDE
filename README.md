# REMOTE-DUDE
A Windows Remote Administration Tool

REMOTE DUDE started as a simple .bat file to get things done quicker at work, over time it became bigger than i expected and may be of use to someone else out there.

It was written out of necessity to be a fast and lightwight administration tool for domain-joined Windows systems. Most remote administration tools for Windows do lots of things without your interaction (like pinging machines to see if theyre up), and are also heavily GUI based. I've found that the majority of similar tools are bloated and slow because of such design choices.

REMOTE DUDE runs in a command prompt and doesn't do anything unless you tell it to, therefore it's quite fast in the right environment. It makes heavy use of the SysInternals "psexec" tool, and uses common Windows components where availible. Most of its functionality depends on 2 things; being executed with a Windows domain account in the Administrators group, as well as having access to the "c$" share of target machines.

Requirements:
- Powershell version 4 or higher
- Access to a user in Administrators group (or Domain Administrators group)

How to install:
- Download as zip and extract it, or git pull the repo
- run remotedude.bat and select option 1 to install dependencies
  - You will need to right click remotedude.bat and 'run as admin' to install/update dependencies if you are using a standard account, or use the 'user' option to run as a different user with admin rights
  
![alt text](https://github.com/albanqafa/REMOTE-DUDE/blob/master/screenshot.PNG)
