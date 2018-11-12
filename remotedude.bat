@ECHO OFF
mode con: cols=80 lines=50
SET colorvar=1
SET MUSICON=0
color 0F
rem so we can be fancy later
SET compname=""
rem nothing before this point is repeated
:MENU
rem make sure the title does not get all fucky
IF %compname% == "" (
TITLE REMOTE DUDE
)
IF NOT %compname% == "" (
TITLE REMOTE DUDE - %compname%
)
:::		______ ________  ________ _____ _____ 
:::		| ___ \  ___|  \/  |  _  |_   _|  ___|
:::		| |_/ / |__ | .  . | | | | | | | |__  
:::		|    /|  __|| |\/| | | | | | | |  __| 
:::		| |\ \| |___| |  | \ \_/ / | | | |___ 
:::		\_| \_\____/\_|  |_/\___/  \_/ \____/ 
:::		                                      
:::		       ______ _   _______ _____       
:::		       |  _  \ | | |  _  \  ___|      
:::		       | | | | | | | | | | |__        
:::		       | | | | | | | | | |  __|    v1.5.2b
:::		       | |/ /| |_| | |/ /| |___    Remote Administrator
:::		       |___/  \___/|___/ \____/    github.com/albanqafa
:::		                                   
rem this line is so that the ascii art prints correctly because it has pipes in it
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
		echo.
		echo    	[1]	Install/update dependencies
		echo    	[2]	Select a Computer
		echo    	[3]	Remote Registry Service view/start/kill
		echo    	[4]	Check who's logged in
		echo    	[5]	Kill a process
		echo		[6]	View running processes
		echo		[7]	Computer Management/Admin Shares(wX)
		echo		[8]	View Info
		echo		[9]	Remote Desktop
		echo		[10]	(redacted)
		echo		[11]	Ping
		echo		[12]	Trace
		echo		[13]	Remote CMD prompt
		echo		[14]	Remote Explore C: drive
		echo		[15]	VIEW SCREEN--(ask for consent!)
		echo		[16]	View installed Software/local Admins
		echo		[17]	NIRSOFT TOOLS
		echo		[18]	Printer Stuff
		echo		[19]	Power information
		echo		[20]	Empty Recycle Bin
		echo		[1337]	Install Package Manager
		echo    	[0]	EXIT
		if %compname% == "" (
		echo							select a PC with option 2!
		)
		if not %compname% == "" (
		echo							selected PC: %compname%
		)
		echo.
	:BACK0
			SET M=""
			SET /P M=Type an option 1-X then press ENTER: 
			IF %M% == "" (
				echo.
				echo you must make a selection.
				echo.
				GOTO BACK0
			)
		echo.
		IF %M%==0 GOTO EXIT
		IF %M%==1 GOTO DUDEUPDATE
		IF %M%==2 GOTO COMPUTERNAME
		IF %M%==party GOTO PARTY
		IF %M%==invert GOTO INVERT
		IF %M%==music GOTO MUSIC
		IF %M%==quake GOTO QUAKE
	IF %compname% == "" (
		echo.
		echo 		! you need to select a PC to do that !
		echo.
		echo.
		pause
		GOTO CLEAR
		)
	IF NOT %compname% == "" (
		IF %M%==3 GOTO REGISTRYSERV
		IF %M%==4 GOTO LOGGEDIN
		IF %M%==5 GOTO KILLER
		IF %M%==6 GOTO VIEWER
		IF %M%==7 GOTO COMPMGMT
		IF %M%==8 GOTO SYSINFO
		IF %M%==9 GOTO REMOTE
		IF %M%==11 GOTO PINGIT
		IF %M%==12 GOTO TRACE
		IF %M%==13 GOTO CMDIN
		IF %M%==14 GOTO EXPLORE
		IF %M%==15 GOTO SCREENSHOT
		IF %M%==16 GOTO SOFTADMIN
		IF %M%==17 GOTO NIRSOFT
		IF %M%==18 GOTO PRINTER
		IF %M%==19 GOTO POWER
		IF %M%==20 GOTO RECYCLE
		IF %M%==1337 GOTO PKGMENu
		IF %M%==update GOTO UPDATE
	)
echo oops, thats not an option . . .
echo.
pause
GOTO CLEAR
:DUDEUPDATE
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/updater.bat', 'updater.bat')"
call updater.bat
GOTO CLEAR
:COMPUTERNAME
rem this asks for the computername aka hostname to save as the variable compname
		echo what is the hostname of the PC you would like to work with?
		echo.
		set /p compname= xxxx-xx: 
		echo.
		echo 				%compname%
		echo					  OK!
		echo.
		pause
GOTO CLEAR
:REGISTRYSERV
rem uses windows service command to query about the service and optionally to start or stop it
		echo				REMOTE REGISTRY STATUS
		echo.
			sc \\%compname% query RemoteRegistry
		echo.
		echo note: useful for remote Comp Management, and many other options here require
		echo       remote registry also.
		echo.
		echo enter "s" to start, or "k" to kill RemoteRegistry on %compname%
		echo enter c to go back to main menu.
		echo.
			rem cleans the variable
	:BACK3
			SET stringask2=""
		set /p stringask2= (s/k/c): 
			rem check for sanity
			IF %stringask2% == "" (
				echo.
				echo you must make a selection.
				echo.
			GOTO BACK3
			)
		if %stringask2% == s (
			sc \\%compname% start RemoteRegistry
		)
		if %stringask2% == k (
			sc \\%compname% stop RemoteRegistry
		)
		if %stringask2% == c (
		GOTO CLEAR
		)
		pause
GOTO CLEAR
:LOGGEDIN
rem view which users are logged on with sysinternals tool
		echo if this crashes/complains about HKEY_USERS you need to (re)start the machines remote registry service
		echo.
		pause
		psloggedon.exe \\%compname%
		echo.
			SET stringask3=""
		set /p stringask3= M for more ENTER to close: 
		IF %stringask3%=="" GOTO CLEAR
		echo More info:
		echo.
		IF %stringask3%==m psexec.exe \\%compname% qwinsta & net session /list
		echo.
		pause
GOTO CLEAR
:KILLER
rem kill task remotely with sysinternals tool
		echo what is the name of the process you would like to kill on %compname%?
		echo.
		set /p taskname= task name: 
		echo.
		echo you chose to kill the task %taskname% on %compname%
		echo is this correct?
	:BACK5
		rem cleans the variable
		SET stringask3=""
		set /p stringask3= (y/n): 
			rem check for sanity
			IF %stringask3% == "" (
				echo.
				echo you must make a selection.
				echo.
				GOTO BACK5
			)
		if %stringask3% == y (
			pskill.exe \\%compname% %taskname%
		)
		pause
GOTO CLEAR
:VIEWER
rem query running processes on a machine with windows tasklist.exe, export in CSV format with
rem appended filename, open the CSV with csvfileview, pause and delete the file
		echo opening a remote task manager or similar is impossible
		echo and this is the best work around i could think of
		echo.
		echo just a moment . . .
			tasklist.exe /s \\%compname% /FO csv > %compname%_tasks.csv
		echo close CSVFileView when you are done . . .
			csvfileview.exe %compname%_tasks.csv
			del %compname%_tasks.csv
GOTO CLEAR
:COMPMGMT
rem i fucked this up
	echo.
	echo 1 for comp management
	echo 2 to enable remote admin shares/volume mgmt
	echo c to cancel
	echo.
	:BACK7
		SET stringask7=""
			rem cleans the variable
			echo.
		set /p stringask7= (1/2/c): 
			rem check for sanity
		IF %stringask7%=="" GOTO ERROR7
		IF %stringask7% ==1 GOTO 7option1
		IF %stringask7% ==2 GOTO 7option2
		IF %stringask7% ==c GOTO CLEAR
		:ERROR7
				echo.
				echo you must make a selection.
				echo.
		GOTO BACK7
		:7option1
				rem computer management for remote machine
				COMPMGMT.MSC /computer:\\%compname%
		GOTO CLEAR
		:7option2
				echo this SHOULD work
				pause
rem				psexec.exe  \\%compname% netsh firewall set service remoteadmin enable
rem				psexec.exe  \\%compname% netsh advfirewall firewall set rule group="Remote Volume Management" new enable=yes
				psexec.exe  \\%compname% netsh firewall set service remoteadmin enable & reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f & netsh advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable =yes
				pause
		GOTO CLEAR
GOTO CLEAR
rem for future reference
rem netsh advfirewall firewall set rule group="Remote Administration" new enable=yes
rem netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes
rem netsh advfirewall firewall set rule group="Remote Service Management" new enable=yes
rem netsh advfirewall firewall set rule group="Performance Logs and Alerts" new enable=yes
rem Netsh advfirewall firewall set rule group="Remote Event Log Management" new enable=yes
rem Netsh advfirewall firewall set rule group="Remote Scheduled Tasks Management" new enable=yes
rem netsh advfirewall firewall set rule group="Remote Volume Management" new enable=yes
rem netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes
rem netsh advfirewall firewall set rule group="Windows Firewall Remote Management" new enable =yes
rem netsh advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable =yes

:SYSINFO
rem sysinternals psinfo OR windows systeminfo for remote machine 
		echo		--------View Short System Info or FULL System Info?--------
		echo.
		echo		note: short is quicker, and mostly usefull for only uptime.
		echo		      short needs remote registry running, full does not.
		echo.
		echo	s for short, f for full, c to cancel
	:BACK8
			rem cleans the variable
			SET stringask5=""
			echo.
		set /p stringask5= (s/f/c): 
			rem check for sanity
			IF %stringask5% == "" (
				echo.
				echo you must make a selection.
				echo.
				GOTO BACK8
			)
		if %stringask5% == s (
			echo just a minute . . .
			psinfo.exe \\%compname%
			pause
			GOTO CLEAR
		)
		if %stringask5% == f (
			echo just a minute . . .
			systeminfo /s %compname% > %compname%_systeminfo.txt
			echo close notepad to continue . . .
			notepad.exe %compname%_systeminfo.txt
			del %compname%_systeminfo.txt
			GOTO CLEAR
		)
		if %stringask5% == c (
			GOTO CLEAR
		)
GOTO CLEAR
:REMOTE
		echo		Remote Desktop Options:
		echo.
		echo	[r] for admin RDP connection to console "hopefully"
		echo	[a] for remote assistance	"asks a user before allowing control"
		echo	[e] to enable remote desktop with network level authentication
		echo	[c] to go back to main manu
		echo.
	:BACK9
			rem cleans the variable
			SET stringask9=""
		set /p stringask9= (r/a/e/c): 
			rem check for sanity
			IF %stringask9% == "" (
				echo.
				echo you must make a selection.
				echo.
				GOTO BACK9
			)
		if %stringask9% == r (
			rem RDP connect
			mstsc /v:%compname% /admin
			GOTO CLEAR
		)
			if %stringask9% == a (
			echo.
			echo remember to click "request control" to gain mouse and keyboard access
			echo close remote assistance when done. . .
rem				PsExec.exe -i -s \\%compname% msra /saveasfile c:/windows/
				msra /offerra %compname%
			GOTO CLEAR
		)
			if %stringask9% == e (
			psexec.exe  \\%compname% reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
			psexec.exe  \\%compname% reg add "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
			echo.
			pause
			GOTO CLEAR
		)
			if %stringask9% == c (
			GOTO CLEAR
		)
GOTO CLEAR
:PINGIT
		ping %compname%
		pause
GOTO CLEAR
:TRACE
		tracert %compname%
		pause
GOTO CLEAR
:CMDIN
rem uses sysinternals psexec to remotely execute cmd.exe from remote machine within the remotedude window
		echo		  note: your current user may stay logged into this PC remotely until
		echo			its rebooted, this is not much of a problem usually, but
		echo			keep this in mind.
		echo.
		echo Are you sure you want to launch a remote CMD prompt?
	:BACK13
			rem cleans the variable
			SET stringask13=""
			echo.
		set /p stringask13= (y/n): 
			rem check for sanity
			IF %stringask13% == "" (
				echo.
				echo you must make a selection.
				echo.
				GOTO BACK13
			)
		if %stringask13% == y (
			echo.
			echo you are now logged in %compname% as %username%
			echo.
			PsExec.exe \\%compname% cmd.exe
			echo.
			echo it always errors out for now.
			pause
			GOTO CLEAR
		)
		pause
GOTO CLEAR
:EXPLORE
		EXPLORER.EXE \\%compname%\c$
		GOTO CLEAR
:SCREENSHOT
		echo 	--------------------MAKE-SURE-TO-ASK--------------------
		ECHO.
		echo		Screenshot works perfectly MOST OF THE TIME.
		echo		Video has about 10s of delay and a fixed res of 1366x768
		echo.
		echo [s] for screenshot, [v] for video (BETA), [c] to cancel
		echo.
		echo or type "clean" to clean up any lingering binaries/processes/screenshots
	:BACK15
		rem cleans the variable
		SET stringask10=""
		echo.
		set /p stringask10= (s/v/c/clean): 
		rem check for sanity
		IF %stringask10% == "" (
			echo.
			echo you must make a selection.
			echo.
		GOTO BACK15
		)
		if %stringask10% == s (
			echo copying screenshot.ps1 to remote PC . . .
					COPY screenshot_script.ps1 \\%compname%\C$\WINDOWS\screenshot.ps1
			echo.
			echo attempting to create screenshot at \\%compname%\C$\WINDOWS\screen.png . . .
				PsExec.exe -i -s \\%compname% powershell.exe -windowstyle hidden -file "c:\WINDOWS\screenshot.ps1"
					ren \\%compname%\C$\WINDOWS\screen.png %compname%_screen.png
			echo.
			echo created screenshot and renamed it \\%compname%\C$\WINDOWS\%compname%_screen.png
					del \\%compname%\C$\WINDOWS\screenshot.ps1
			echo deleted \\%compname%\C$\WINDOWS\screenshot.ps1 cause we no longer need it
			echo.
			echo close IrfanView when done . . .
				IrfanViewPortable\IrfanViewPortable.exe \\%compname%\C$\WINDOWS\%compname%_screen.png
					del \\%compname%\C$\WINDOWS\%compname%_screen.png
			echo deleted \\%compname%\C$\WINDOWS\%compname%_screen.png
			echo.
			pause
		GOTO CLEAR
		)
		if %stringask10% == v (
			echo copying server and capture binaries to remote PC . . .
					XCOPY /E /Y monaserver \\%compname%\C$\WINDOWS\monaserver\
					XCOPY /E /Y nircmd* \\%compname%\C$\WINDOWS\
					COPY ffmpeg.exe \\%compname%\C$\WINDOWS\ffmpeglive.exe
rem PsExec.exe -i -s -d \\%compname% powershell -Command "(gc C:WINDOWS\monaserver\www\inedx.html) -replace 'compname', '%compname%' | Out-File C:WINDOWS\monaserver\www\inedx.html"
			echo.
			echo attempting to run monaserver and ffmpeg  . . .
				PsExec.exe -s -d \\%compname% c:\windows\monaserver\monaserver.exe
rem				PsExec.exe -i -s -d \\%compname% c:\windows\ffmpeg.exe -loglevel debug -y -f gdigrab -draw_mouse 1 -offset_x 0 -offset_y 0 -video_size 1280x1024 -i desktop -f flv "rtmp://localhost conn=S:test conn=S:test2"
rem				PsExec.exe -i -s -d \\%compname% c:\windows\ffmpeg.exe -y -f mpegts -i desktop -re -vcodec libx264 -maxrate 700k -r 25 -s 640x360 -deinterlace -acodec libfaac -ab 64k -ac 1 -ar 44100 -f flv "rtmp://localhost conn=S:test conn=S:test2"
rem				PsExec.exe -i -s -d \\%compname% c:\windows\ffmpeg.exe -loglevel debug -y -f gdigrab -draw_mouse 1 -offset_x 0 -offset_y 0 -video_size 1366x768 -framerate 20 -i desktop -vcodec libx264 -preset veryfast -maxrate 700k -bufsize 1400k -r 25 -deinterlace -acodec libfaac -ab 64k -ac 1 -ar 44100 -f flv "rtmp://localhost conn=S:test conn=S:test2"
rem				PsExec.exe -i -s -d \\%compname% c:\windows\ffmpeg.exe -y -f gdigrab -draw_mouse 1 -offset_x 0 -offset_y 0 -video_size 1280x1024 -i desktop -framerate 25 -ac 1 -ar 44100 -f flv "rtmp://localhost"
rem live HLS
PsExec.exe -i -s -d \\%compname% c:\windows\ffmpeglive.exe -threads 1 -y -f gdigrab -draw_mouse 0 -i desktop -framerate 25 -c:v h264 -preset:v ultrafast -flags +cgop -g 20 -hls_time 1 c:\windows\monaserver\www\out.m3u8
				PsExec.exe -i -s -d \\%compname% nircmd win hide class consolewindowclass
			echo.
			echo					-------all done-------
			echo 
			echo go to http://%compname%/index.html"
			pause
rem				VLCPortable\vlcportable.exe rtmp://%compname%
rem					pskill.exe \\%compname% monaserver.exe
rem					pskill.exe \\%compname% ffmpeg.exe
rem					pskill.exe \\%compname% nircmd.exe
rem					rmdir /Q /S \\%compname%\C$\WINDOWS\monaserver\
rem					del /Q \\%compname%\C$\WINDOWS\ffmpeg.exe
rem					del /Q \\%compname%\C$\WINDOWS\nircmd*
		GOTO CLEAR
		)
		if %stringask10% == clean (
			echo cleaning any lingering binaries/processes/screenshots
				pskill.exe \\%compname% monaserver.exe
				pskill.exe \\%compname% ffmpeglive.exe
					rmdir /Q /S \\%compname%\C$\WINDOWS\monaserver\
					del /Q \\%compname%\C$\WINDOWS\nircmd*
					del /Q \\%compname%\C$\WINDOWS\ffmpeg.exe
					del \\%compname%\C$\WINDOWS\screenshot.ps1
					del \\%compname%\C$\WINDOWS\screen.png
					del \\%compname%\C$\WINDOWS\%compname%_screen.png
		GOTO CLEAR
		)
		if %stringask10% == c (
		GOTO CLEAR
		)
		pause
GOTO CLEAR
:NIRSOFT
	echo 	SELECT AN OPTION:
	echo.
	echo [1] BSoD viewer
	echo [2] to view power on/off history
	echo [c] to cancel
		SET stringask17=""
	:BACK17
		echo.
		set /p stringask17= (1-x/c): 
		rem check for sanity
		IF %stringask17%=="" GOTO ERROR17
		IF %stringask17% ==1 GOTO NIRSOFT_BSOD
		IF %stringask17% ==2 GOTO NIRSOFT_TURNEDON
		IF %stringask17% ==c GOTO CLEAR
	:ERROR17
			echo you must make a selection
			pause
	GOTO BACK17
	:NIRSOFT_BSOD
		echo be patient sometimes this takes a minute or two. . .
		BlueScreenView.exe \\%compname%\c$\windows\minidump
	GOTO CLEAR
	:NIRSOFT_TURNEDON
		TurnedOnTimesView.exe /Source 2 /RemoteComputer \\%compname%
	GOTO CLEAR
:SOFTADMIN
	echo.
	echo 	SELECT AN OPTION:
	echo.
	echo [s] for a list of %compname%s installed software
	echo [a] to show local admins on %compname%
	echo [c] to cancel
		SET stringask16=""
	:BACK16
		echo.
		set /p stringask16= (s/a/c): 
		IF %stringask16%=="" GOTO ERROR16
		IF %stringask16% ==s GOTO SOFTWARE
		IF %stringask16% ==a GOTO ADMIN
		IF %stringask16% ==c GOTO CLEAR
	:ERROR16
			echo you must make a selection
			pause
	GOTO BACK16
		:admin
			COPY listadmin.bat \\%compname%\C$\WINDOWS\listadmin.bat
			psexec.exe -s \\%compname% c:\WINDOWS\listadmin.bat
			del \\%compname%\C$\WINDOWS\listadmin.bat
			echo _______________________________________________________________________________
			echo.
			echo Would you like to remove a user from the Administrator group on %compname%?
			echo.
			SET yesno16=""
			:BACK16a
			set /p yesno16= (y/n): 
				IF %yesno16% == "" GOTO ERROR16a
				IF %yesno16% == y GOTO BACK16b
				IF %yesno16% == n GOTO CLEAR
			:ERROR16a
				echo.
				echo you must make a selection
				pause
				GOTO BACK16a
				:BACK16b
					set user16=""
					set /p user16= user to demote on %compname%: 
						IF %user16% == "" GOTO ERROR16b
						IF  NOT %user16% == "" GOTO ADMINKILL
					:ERROR16b
						echo.
						echo you must select a user
						pause
						GOTO BACK16b
				:ADMINKILL
					echo net localgroup administrators %user16% /DELETE > remadmin.bat
					COPY remadmin.bat \\%compname%\C$\WINDOWS\remadmin.bat
					psexec.exe -s \\%compname%  c:\WINDOWS\remadmin.bat
					del \\%compname%\C$\WINDOWS\remadmin.bat
					del remadmin.bat
					echo.
					GOTO ADMIN
		GOTO CLEAR
	:software
			echo.
			echo		hit enter in a few seconds
			psexec.exe -s \\%compname% powershell.exe -command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize | Out-File -FilePath c:\windows\%compname%_software.txt -width 1000" 
			echo.
			echo close notepad when done
			notepad \\%compname%\c$\windows\%compname%_software.txt
			del \\%compname%\C$\WINDOWS\%compname%_software.txt
GOTO CLEAR
:CLEAR
cls
GOTO MENU
:PKGMENU
		echo.
		echo			PACKAGE MANAGER MENU
		echo.
		echo    	[c]	Install Chocolatey Package Manager
		echo    	[s]	Remove Signature Checking for Chocolatey
		echo		[e]	Exit this menu and return to default
	:PKG0
		echo.
		SET secretoption=""
		set /p secretoption= choose wisely: 
			rem check for sanity
		IF %secretoption% == "" (
			echo.
			echo you must make a selection.
			echo.
		GOTO PKG0
		)
		if %secretoption%==c GOTO PKGCHOCO
		if %secretoption%==s GOTO PKGSIGCHK
		if %secretoption%==e GOTO CLEAR
:PKGCHOCO
		echo are you sure you want to inject Chocolatey on %compname%?
	:PKG1
		rem cleans the variable
		SET secretask1=""
		set /p secretask1= (y/n): 
		rem check for sanity
		IF %secretask1% == "" (
			echo.
			echo you must make a selection.
			echo.
		GOTO PKG1
		)
		if %secretask1% == y (
			echo.
			echo			  HIT ENTER TWICE
			echo 		THEN TYPE EXIT WHEN ITS DONE
			echo.
				PsExec.exe \\%compname% powershell.exe -command "Set-ExecutionPolicy RemoteSigned"
				PsExec.exe \\%compname% powershell.exe -command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
			echo.
			echo it always errors out for now.
			pause
		GOTO PKGMENU
		)
		if %secretask1% == n (
			cls
		GOTO PKGMENU
		)
:PKGSIGCHK
		echo are you sure you want to remove signature checking for Chocolatey on %compname%?
	:PKG2
		rem cleans the variable
		SET secretask2=""
		set /p secretask2= (y/n): 
		rem check for sanity
		IF %secretask2% == "" (
			echo.
			echo you must make a selection.
			echo.
		GOTO PKG2
		)
		if %secretask2% == y (
				PsExec.exe \\%compname% cmd.exe /k "choco feature enable -n allowEmptyChecksums"
			echo done
			pause
		GOTO PKGMENU
		)
		if %secretask1% == n (
			cls
		GOTO PKGMENU
		)
GOTO CLEAR
:PRINTER
		SET printserver=""
	:PRINTERMENU
	echo.
	echo	-----------------------PRINT MENU-----------------------
	echo.
	echo 	SELECT AN OPTION:
	echo.
	echo		[1] select a print server
	echo		[2] remove a printer 
	echo		[3] add a printer
	echo		[v] to view connected printers on %compname%
	echo		[c] to cancel
		if %printserver% == "" (
		echo							select a print server!
		)
		if not %printserver% == "" (
		echo							printserver: %printserver%
		)
		echo.
		SET stringask17=""
	:BACK18
		echo.
		set /p stringask18= (1-3/c): 
		rem check for sanity
		IF %stringask18%=="" GOTO ERROR18
		IF %stringask18% ==1 GOTO PRINTER_SELECT
		IF %stringask18% ==2 GOTO PRINTER_REMOVE
		IF %stringask18% ==3 GOTO PRINTER_ADD
		IF %stringask18% ==v GOTO PRINTER_VIEW
		IF %stringask18% ==c GOTO CLEAR
	:ERROR18
			echo you must make a selection
			pause
	GOTO BACK18
	:PRINTER_SELECT
		set /p printserver= printserver: 
	GOTO PRINTCLEAR
	:PRINTER_REMOVE
		SET printername=""
		echo enter the name of the printer
		set /p printername= printername: 
				if %printername% == "" (
				GOTO PRINTER_REMOVE
				)
		psexec.exe \\%compname% printui.exe /dn /n \\%printserver%\%printername%
		echo.
		pause
	GOTO PRINTCLEAR
	:PRINTER_ADD
		SET printername=""
		echo enter the name of the printer
		set /p printername= printername: 
				if %printername% == "" (
				GOTO PRINTER_ADD
				)
		psexec.exe \\%compname% printui.exe /in /n \\%printserver%\%printername%
		echo.
		pause
	GOTO PRINTCLEAR
	:PRINTER_VIEW
		psexec.exe \\%compname% powershell.exe -command "get-WmiObject -class Win32_printer | ft name, systemName, shareName"
		pause
	GOTO PRINTCLEAR
	:PRINTCLEAR
		cls
		GOTO PRINTERMENU
GOTO CLEAR
:POWER
	echo.
	echo	-----------------------POWER MENU-----------------------
	echo.
	echo 	SELECT AN OPTION:
	echo.
	echo		[1] view battery charge
	echo		[2] view detailed power info
	echo		[c] to cancel
	echo.
	set /p stringask19= (1-3/c): 
		IF %stringask19%=="" GOTO ERROR19
		IF %stringask19% ==1 GOTO POWER_BATTERY
		IF %stringask19% ==2 GOTO POWER_DETAILED
		IF %stringask19% ==c GOTO CLEAR
	:ERROR19
			echo you must make a selection
			pause
	:POWER_BATTERY
		psexec.exe \\%compname% wmic path win32_Battery
		pause
		echo.
		echo.
		GOTO :POWER
	:POWER_DETAILED
		psexec.exe \\%compname% powercfg -energy /output C:\windows\%compname%_power_report.html
		\\%compname%\c$\windows\%compname%_power_report.html
		del \\%compname%\c$\windows\%compname%_power_report.html
	echo.
	GOTO :POWER
GOTO CLEAR
:RECYCLE
	psexec.exe \\%compname% rmdir /s %systemdrive%\$Recycle.bin
	echo Recycle Bin on %compname% 
GOTO CLEAR
:EXIT
rem what the hell do you think this does?
		exit
:MUSIC
IF %MUSICON% == 0 (
	SET MUSICON=1
	nircmd.exe exec hide wv_player.exe format.mp3
GOTO CLEAR
)
IF %MUSICON% == 1 (
	SET MUSICON=0
	pskill.exe wv_player.exe
GOTO CLEAR
)
GOTO CLEAR
:UPDATE
	echo.
	echo	----------------------UPDATE MENU-----------------------
	echo.
	echo 	SELECT AN OPTION:
	echo.
	echo		[w] send windows update commands
	echo		[k] update kaspersky definitions
	echo		[c] to cancel
	echo.							this menu is experimental
		SET stringaskupdate=""
:BACKUPDATE1
	set /p stringaskupdate= (1-3/c): 
		IF %stringaskupdate%=="" GOTO ERRORupdate
		IF %stringaskupdate% ==w GOTO updateoption1
		IF %stringaskupdate% ==k GOTO updateoption2
		:ERRORupdate
				echo.
				echo you typed that wrong.
				echo.
		GOTO backupdate1
	:updateoption1
		echo sending windows update command. . .
rem	wmic /node:%compname% process call create "wuauclt.exe /detectnow /updatenow"
	psexec.exe \\%compname% wuauclt.exe /detectnow /updatenow
		echo ok.
	GOTO CLEAR
	:updateoption2
rem	wmic /node:%compname% process call create "avp update"
	psexec.exe \\%compname% avp update
	GOTO CLEAR


GOTO CLEAR
:QUAKE
psexec.exe quake/glass.exe
autohotkey quake/quake.ahk
autohotkey quake/titlebar.ahk
GOTO CLEAR
:PARTY
echo.
echo.
echo.
echo.			PARTY MODE, DUDE.
set NUM=0 1 2 3 4 5 6 7 8 9 A B C D E F
for %%x in (%NUM%) do ( 
    for %%y in (%NUM%) do (
        color %%x%%y
        timeout 0 >nul
    )
)
GOTO INVERT
:INVERT
if %colorvar% == 0 (
	color 0F
	set colorvar=1
GOTO CLEAR
)
if %colorvar% == 1 (
	color F0
set colorvar=0
GOTO CLEAR
)
GOTO CLEAR
