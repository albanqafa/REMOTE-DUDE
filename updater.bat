@ECHO OFF
echo Updating 7zip via Chocolatey...
cup -y 7zip.commandline
echo.
echo Updating sysinternals via Chocolatey...
cup -y sysinternals
mklink %cd%\psexec.exe C:\ProgramData\chocolatey\lib\sysinternals\tools\psexec.exe
mklink %cd%\psinfo.exe C:\ProgramData\chocolatey\lib\sysinternals\tools\psinfo.exe
mklink %cd%\pskill.exe C:\ProgramData\chocolatey\lib\sysinternals\tools\pskill.exe
mklink %cd%\psloggedon.exe C:\ProgramData\chocolatey\lib\sysinternals\tools\psloggedon.exe
echo.
echo updating CSVfileView via Chocolatey...
cup -y CSVFileView
mklink %cd%\CSVFileView.exe C:\ProgramData\chocolatey\lib\csvfileview\tools\csvfileview.exe
echo.
echo updating irfanview via Chocolatey...
cup -y irfanview
mkdir %cd%\IrfanViewPortable
mklink %cd%\IrfanViewPortable\IrfanViewPortable.exe "C:\Program Files\IrfanView\i_view64.exe"
echo.
echo Updating remotedude...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/remotedude.bat', 'remotedude.bat')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/updater.bat', 'updater.bat')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/screenshot_script.ps1', 'screenshot_script.ps1')"
echo.
echo Updating ffmpeg...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-4.0.2-win64-static.zip', 'ffmpeg.zip')"
7z x ffmpeg.zip
del ffmpeg.zip
rem del ffmpeg\
rem mv ffmpeg* ffmpeg
mklink /H %cd%\ffmpeg.exe ffmpeg\bin\ffmpeg.exe
echo.
echo Updating MonaServer...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://newcontinuum.dl.sourceforge.net/project/monaserver/MonaServer_Win32.zip', 'MonaServer.zip')"
7z x monaserver.zip -o%cd%\MonaServer\
del monaserver.zip
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/albanqafa/REMOTE-DUDE/master/Monaserver/www/index.html', '%cd%\Monaserver\www\index.html')"
.echo
echo.
echo updating nirsoft utilities...
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.nirsoft.net/utils/nircmd.zip', '%cd%\nircmd.zip')"
7z x nircmd.zip
del nircmd.zip
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.nirsoft.net/utils/bluescreenview.zip', '%cd%\bluescreenview.zip')"
7z x bluescreenview.zip
del bluescreenview.zip
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.nirsoft.net/utils/turnedontimesview.zip', '%cd%\turnedontimesview.zip')"
7z x turnedontimesview.zip
del turnedontimesview.zip
pause
