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
cinst javaruntime -force
cinst jdk8 -force

rem languages
cinst python

rem version control
cinst git
cinst git.install
cinst git.commandline
cinst hg

rem utilities
cinst cygwin
cinst cyg-get
cinst autohotkey
cinst Ghostscript
cinst putty.portable -force
cinst autohotkey.portable 
cinst 7zip.commandline
cinst 7zip.install
cinst imagemagick
cinst dropbox

rem applications
cinst adobereader -force
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
cinst synergy

rem change UAC to disable prompts
rem this allows synergy to work seamlessly
C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
