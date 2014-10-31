rem Download this script and run as adminstrator 
rem
rem For ephys workstation:
rem Not Installed: Matlab, Office 2013 Pro Plus, Inventor Professional 2015, Zemax 

rem install chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
@powershell -NoProfile -ExecutionPolicy unrestricted SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
rem packages:
rem choco install package-name == cinst package-name

rem rem -force comand usually fixes install problems (included for problematic packages)

rem reqd
cinst javaruntime
cinst jdk8 -force

rem languages
cinst python

rem version control
cinst git
cinst git.install
cinst git.commandline
cinst hg

rem utilities
cinst Ghostscript -force
cinst putty.portable
cinst autohotkey.portable
cinst 7zip.commandline
cinst 7zip.install
cinst imagemagick
cinst dropbox

rem applications
cinst adobereader -force
cinst GoogleChrome -force
cinst vlc -force
cinst greenshot -Version 1.1.9.13
cinst MicrosoftSecurityEssentials -force
cinst flashplayeractivex -force
cinst notepadplusplus -force
cinst teamviewer -force
cinst windirstat -force
cinst synergy -force
