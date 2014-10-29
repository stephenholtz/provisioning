rem Download this script and run as adminstrator 
rem
rem For ephys workstation:
rem Not Installed: Matlab, FlyCap2, Office 2013 Pro Plus, Nidaq tools

rem install chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
@powershell -NoProfile -ExecutionPolicy unrestricted SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
rem packages:
rem choco install package-name == cinst package-name

rem reqd
cinst java
cinst javaruntime

rem languages
cinst python

rem version control
cinst git.install
cinst git.commandline
cinst svn
cinst hg

rem utilities
cinst cygwin
cinst cyg-get
cinst autohotkey
cinst Ghostscript
cinst putty.portable
cinst autohotkey.portable
cinst 7zip.commandline
cinst 7zip.install
cinst imagemagick
cinst dropbox

rem applications
cinst VirtualCloneDrive
cinst GoogleChrome
cinst vlc
cinst greenshot -Version 1.1.9.13
cinst MicrosoftSecurityEssentials
cinst flashplayeractivex
cinst notepadplusplus
cinst teamviewer
cinst speccy
cinst windirstat
cinst lastpass
cinst synergy
