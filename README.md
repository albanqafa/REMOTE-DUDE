# REMOTE-DUDE
A Windows Remote Administration Tool

REMOTE DUDE started as a simple .bat file to get things done quicker at work, over time it became bigger than i expected and may be of use to someone else out there.

It was written out of necessity to be a fast and lightwight administration tool for domain-joined Windows systems. Most remote administration tools for Windows do lots of things without your interaction (like pinging machines to see if theyre up), and are also heavily GUI based. I've found that the majority of similar tools are bloated and slow because of such design choices.

REMOTE DUDE runs in a command prompt and doesn't do anything unless you tell it to, therefore it's quite fast in the right environment. It makes heavy use of the SysInternals "psexec" tool, and uses common Windows components where availible. Most of its functionality depends on 2 things; being executed with a Windows domain account in the Administrators group, as well as having access to the "c$" share of target machines.

EDIT:

Finally uploaded the current version to github!

- its absolutely disgusting in its current state and needs LOTS of cleaning up

If you want to mess around with it, youll need/want the following in the same folder as remotedude.bat:

- MonaServer (Directory) *needed for rtmp/http server*
- - lua51.dll
- - MonaServer.exe
- - MonaServer.ini
- - WWW (directory)
- - - dist (directory) *clappr dist files*
- - - index.html *for clappr, you need to make this yourself if you want to use it, for now*
- BlueScreenView.exe
- CsvFileView.exe
- ffmpeg.exe
- listadmin.bat (contains: "net localgroup administrators")
- PsExec.exe
- PsInfo.exe
- pskill.exe
- PsLoggedon.exe
- screenshot_script.ps1
- TurnedOnTimesView.exe

![alt text](https://github.com/albanqafa/REMOTE-DUDE/blob/master/screenshot.PNG)
