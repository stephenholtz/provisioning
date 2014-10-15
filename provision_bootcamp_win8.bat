rem Download this script and run as adminstrator 
rem
rem For ephys workstation:
rem Not Installed: Matlab, Office 2013 Pro Plus, Inventor Professional 2015, Zemax 

rem install chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
@powershell -NoProfile -ExecutionPolicy unrestricted SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
rem packages:
rem choco install package-name == cinst package-name

rem reqd
cinst javaruntime

rem languages
cinst python

rem version control
cinst git.install
cinst git.commandline
cinst svn
cinst hg

rem utilities
cinst Ghostscript
cinst putty.portable
cinst autohotkey.portable
cinst 7zip.commandline
cinst 7zip.install
cinst imagemagick
cinst dropbox

rem applications
cinst GoogleChrome
cinst vlc
cinst greenshot -Version 1.1.9.13
cinst MicrosoftSecurityEssentials
cinst flashplayeractivex
cinst notepadplusplus
cinst teamviewer
cinst windirstat
cinst lastpass
cinst synergy