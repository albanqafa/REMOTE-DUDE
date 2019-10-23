@ECHO OFF
echo Checking for chocolatey...
WHERE choco.exe
IF %ERRORLEVEL% NEQ 1 goto skipchoco
::: Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A>installchoco.ps1
powershell (start-process -filepath powershell -argument %cd%\installchoco.ps1 -verb runas -Wait)
:skipchoco
echo OK
echo.
echo Updating 7zip via Chocolatey...
powershell (start-process -filepath cup.exe -argumentlist @('-y','7zip.commandline') -verb runas -Wait)
echo.
echo Updating sysinternals via Chocolatey...
powershell (start-process -filepath cup.exe -argumentlist @('-y','sysinternals') -verb runas -Wait)
if exist %cd%\psexec.exe (goto skippsexec)
	mklink %cd%\psexec.exe %ProgramData%\chocolatey\lib\sysinternals\tools\psexec.exe
	mklink %cd%\psinfo.exe %ProgramData%\chocolatey\lib\sysinternals\tools\psinfo.exe
	mklink %cd%\pskill.exe %ProgramData%\chocolatey\lib\sysinternals\tools\pskill.exe
	mklink %cd%\psloggedon.exe %ProgramData%\chocolatey\lib\sysinternals\tools\psloggedon.exe
:skippsexec
echo.
echo Updating CSVfileView via Chocolatey...
powershell (start-process -filepath cup.exe -argumentlist @('-y','CSVFileView') -verb runas -Wait)
if exist %cd%\CSVFileView.exe (goto skipcsvfileview)
	mklink %cd%\CSVFileView.exe C:\ProgramData\chocolatey\lib\csvfileview\tools\csvfileview.exe
:skipcsvfileview
echo.
echo Updating irfanview via Chocolatey...
powershell (start-process -filepath cup.exe -argumentlist @('-y','irfanview') -verb runas -Wait)
if exist %cd%\IrfanViewPortable (goto skipirfanview)
	mkdir %cd%\IrfanViewPortable
	mklink %cd%\IrfanViewPortable\IrfanViewPortable.exe "C:\Program Files\IrfanView\i_view64.exe"
:skipirfanview
echo.
echo Updating ffmpeg...
if exist %cd%\ffmpeg.exe (goto skipffmpeg)
:updateffmpeg
del ffmpeg.exe
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-4.0.2-win64-static.zip', 'ffmpeg.zip')"
		7z e ffmpeg.zip -o%cd%\ffmpeg\bin\ -r ffmpeg-*\bin* -y
		del /Q ffmpeg.zip
	mklink /H %cd%\ffmpeg.exe ffmpeg\bin\ffmpeg.exe
:skipffmpeg
echo Checking hash...
set _ffmpeg_wanted=65824F7C3FA12E7181CC75E29DA4D6C9C3FD103D53F835A0884BB4BE65274EF2
for /f "tokens=3" %%a in ('@powershell -command "(get-filehash ffmpeg.exe | format-list -property hash | out-string)"') do set _ffmpeg_current=%%a
if not %_ffmpeg_current% == %_ffmpeg_wanted% (
	echo hash mismatch... updating
	goto updateffmpeg
)
echo Hashes match
echo.
echo Updating MonaServer...
if exist %cd%\Monaserver\MonaServer.exe (goto skipmona)
:updatemona
del %cd%\Monaserver\MonaServer.exe
	powershell -Command "(New-Object Net.WebClient).DownloadFile('https://newcontinuum.dl.sourceforge.net/project/monaserver/MonaServer_Win32.zip', 'MonaServer.zip')"
	7z x monaserver.zip -o%cd%\MonaServer\ -y
	del /Q monaserver.zip
rem	powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/Monaserver/www/index.html', '%cd%\Monaserver\www\index.html')"
:skipmona
echo Checking hash...
set _mona_wanted=1B8B7CCDC2CA665EDBDC467755DAE92E0523EA676A7251D5388EEA46704AB0E6
for /f "tokens=3" %%a in ('@powershell -command "(get-filehash %cd%\Monaserver\MonaServer.exe | format-list -property hash | out-string)"') do set _mona_current=%%a
if not %_mona_current% == %_mona_wanted% (
	echo hash mismatch... updating
	goto updatemona
)
echo Hashes match
echo.
echo Updating nirsoft utilities via chocolatey...
powershell (start-process -filepath cup.exe -argumentlist @('-y','nircmd') -verb runas -Wait)
powershell (start-process -filepath cup.exe -argumentlist @('-y','bluescreenview') -verb runas -Wait)
if not exist %cd%\nircmd.exe (mklink /H %cd%\nircmd.exe %ProgramData%\chocolatey\bin\nircmd.exe)
if not exist %cd%\bluescreenview.exe (mklink /H %cd%\bluescreenview.exe "%PROGRAMFILES(X86)%\Nirsoft\BlueScreenView\BlueScreenView.exe")
if exist %cd%\TurnedOnTimesView.exe (goto skipnirsoft)
rem :skipnirsoft
rem	powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.nirsoft.net/utils/nircmd.zip', '%cd%\nircmd.zip')"
rem	7z x nircmd.zip -aoa -y
rem del /Q nircmd.zip
rem 	powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.nirsoft.net/utils/bluescreenview.zip', '%cd%\bluescreenview.zip')"
rem 	7z x bluescreenview.zip -aoa -y
rem del /Q bluescreenview.zip
 	powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.nirsoft.net/utils/turnedontimesview.zip', '%cd%\turnedontimesview.zip')"
 	7z x turnedontimesview.zip -aoa -y
del /Q turnedontimesview.zip
:skipnirsoft
echo.
echo Updating remotedude...
	powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/remotedude.bat', 'remotedude.bat')"
rem 	powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/screenshot_script.ps1', 'screenshot_script.ps1')"
echo.
echo Updating profilemig...
	powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/profilemig.bat', 'profilemig.bat')"
pause
