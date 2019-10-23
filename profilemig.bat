@ECHO OFF
@setlocal enableextensions
@cd /d "%~dp0"
mode con: cols=137 lines=40
color 0F
rem so we can be fancy later
SET compname=""
SET _profile=""
SET _target_profile=""
rem nothing before this point is repeated
:MENU
rem make sure the title does not get all fucky
IF %compname% == "" (
TITLE Profile Migrator
)
IF NOT %compname% == "" (
TITLE Profile Migrator - %compname%
)
:::       ....      ..                                           .          ..                ...     ..      ..        .                
:::     +^""888h. ~"888h                               oec :    @88>  x .d88"               x*8888x.:*8888: -"888:     @88>              
:::    8X.  ?8888X  8888f     .u    .          u.     @88888    %8P    5888R               X   48888X `8888H  8888     %8P               
:::   '888x  8888X  8888~   .d88B :@8c   ...ue888b    8"*88%     .     '888R        .u    X8x.  8888X  8888X  !888>     .         uL     
:::   '88888 8888X   "88x: ="8888f8888r  888R Y888r   8b.      .@88u    888R     ud8888.  X8888 X8888  88888   "*8%-  .@88u   .ue888Nc.. 
:::    `8888 8888X  X88x.    4888>'88"   888R I888>  u888888> ''888E`   888R   :888'8888. '*888!X8888> X8888  xH8>   ''888E` d88E`"888E` 
:::      `*` 8888X '88888X   4888> '     888R I888>   8888R     888E    888R   d888 '88%"   `?8 `8888  X888X X888>     888E  888E  888E  
:::     ~`...8888X  "88888   4888>       888R I888>   8888P     888E    888R   8888.+"      -^  '888"  X888  8888>     888E  888E  888E  
:::      x8888888X.   `%8"  .d888L .+   u8888cJ888    *888>     888E    888R   8888L         dx '88~x. !88~  8888>     888E  888E  888E  
:::     '%"*8888888h.   "   ^"8888*"     "*888*P"     4888      888&   .888B . '8888c. .+  .8888Xf.888x:!    X888X.:   888&  888& .888E  
:::     ~    888888888!`       "Y"         'Y"        '888      R888"  ^*888%   "88888%   :""888":~"888"     `888*"    R888" *888" 888&  
:::          X888^"""                                  88R       ""      "%       "YP'        "~'    "~        ""       ""    `"   "888E 
:::          `88f                                      88>                                                                   .dWi   `88E 
:::           88                                       48                                                                    4888~  J8%  
:::           ""                                       '8                                                                     ^"===*"`   
:::                                                                                        Written by Alban Qafa
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
echo.
		if %compname% == "" (
			echo												Source PC:	none
		)
		if not %compname% == "" (
			echo												Source PC:	%compname%
		)
		if %_profile% == "" (
			echo												Source Profile:	none
		)
		if not %_profile% == "" (
			echo												Source Profile:	%_profile%
		)
		if %_target_profile% == "" (
			echo												Dest. Profile:	none
		)
		if not %_target_profile% == "" (
			echo												Dest. Profile:	%_target_profile%
		)
echo		Options are:
echo.
echo				comp	- change computer
echo				user	- select/change remote profile (source)
echo				target	- Select different target profile (optional)
echo				migrate	- duh
echo.
echo.
SET M=""
SET /P M=Type an option 1-X then press ENTER: 
IF %M% == "" (
	echo.
	echo you must make a selection.
	pause
	cls
	GOTO MENU)
echo.
	IF %M%==comp GOTO comp
	IF %M%==user GOTO user
	IF %M%==target GOTO target rem lol
	IF %M%==migrate GOTO migrate
echo.
echo You must select a computer first.
pause
cls
GOTO MENU
:comp
set /P compname=host/ip: 
echo OK!
pause
cls
GOTO MENU
:user
IF %compname%=="" (
	echo You need to select a computer to do that.
	pause
	cls
	GOTO MENU
)
echo Which profile do you want to migrate?
echo.
dir \\%compname%\c$\users /W /B
echo.
set /P _profile=profile: 
SET _target_profile=%_profile%
echo OK!
pause
cls
GOTO MENU
:target
rem target is actually a pretty good supermarket, dude.
rem its been a while, maybe ill go to target sometime soon.
rem wait we are already here bad joke
IF %compname%=="" (
	echo You need to select a computer to do that
	pause
	cls
	GOTO MENU
)
echo Current target is %_target_profile%
echo.
echo Here is a list of availible target folders on the %compname%:
dir C:\users /W /B
echo.
set /P _target_profile=alternate target: 
echo OK!
pause
cls
GOTO MENU
:migrate
IF %compname%=="" (
	echo You need to select a computer to do that.
	pause
	cls
	GOTO MENU
)
echo You picked the profile %_profile% from %compname%
IF NOT %_profile% == %_target_profile% (echo AND the optional alternate target of %_target_profile% on %computername%)
echo.
echo Are you sure you want to copy user data and browser profiles from the %_profile% profile 
echo on %compname% to the %_target_profile% profile on %computername% ?
echo.
echo.
SET confirm_migrate=""
:BACK_migrate
set /P confirm_migrate=(y/n): 
	rem check for sanity
	IF %confirm_migrate% == "" (
		echo.
		echo you must make a selection.
		echo.
		GOTO BACK_migrate
	)
	IF %confirm_migrate% == n (
		cls
		GOTO MENU
	)
	IF %confirm_migrate% == y (
		rem dostuff
		robocopy \\%compname%\c$\users\%_profile%\Desktop\ C:\users\%_target_profile%\Desktop /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
		robocopy \\%compname%\c$\users\%_profile%\Documents\ C:\users\%_target_profile%\Documents /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
		robocopy \\%compname%\c$\users\%_profile%\Pictures\ C:\users\%_target_profile%\Pictures /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
		robocopy \\%compname%\c$\users\%_profile%\Music\ C:\users\%_target_profile%\Music /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
		robocopy \\%compname%\c$\users\%_profile%\AppData\local\Google\ C:\users\%_target_profile%\Appdata\local\Google /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
		robocopy \\%compname%\c$\users\%_profile%\AppData\local\Mozilla\ C:\users\%_target_profile%\Appdata\local\Mozilla /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
		robocopy \\%compname%\c$\users\%_profile%\AppData\LocalLow\Mozilla\ C:\users\%_target_profile%\AppData\LocalLow\Mozilla /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
		robocopy \\%compname%\c$\users\%_profile%\AppData\Roaming\Mozilla\ C:\users\%_target_profile%\AppData\Roaming\Mozilla /E /ZB /MT:24 /LOG+:C:\users\%_target_profile%\ProfileMig_log.log /COPY:DATSO
	)
echo oops something went wrong here...
pause
cls
GOTO MENU
