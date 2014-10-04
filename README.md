# OSX
* Set of scripts to provision workstations, mostly for fun 
* Uses homebrew, homebrew-cask, pip, gems, etc., to install utilities and apps.
* cask.installs contains app installs
* brew.installs contains cli tools
* For all plugins to work the first time, set `Keychain Access.app` settings for github.com to allow all applications to access the item (temporarily at least)
* For git need xcode command-line/developer tools, with Xcode 5.1+, OSX 10.9+ this command launches installer:
    `xcode-select --install`

#windows
* chocolatey used to provision new windows installs
* every install listed in choco.installs

#linux
* work in progress

#limitations
* some licensed software is not yet possible with homebrew-cask on OSX or chocolatey in Win
    * `Matlab` 
    * `Adobe Creative Suite`
    * `Mathematica` 
    * `Microsoft Office` 

##todo - 09/2014
* make a better copy of my preferences to set by `defaults write ...` in osx_preferences.sh
* OSX: complete node, python, R environments
* Windows: complete install script
