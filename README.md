##provisioning
* Set of scripts to provision workstations, mostly for fun 
* Uses homebrew, homebrew-cask, pip, gems, etc., to install utilities and apps.
* For all plugins to work the first time, set `Keychain Access.app` settings for github.com to allow all applications to access the item (temporarily at least)
* For git need xcode command-line/developer tools, with Xcode 5.1+, OSX 10.9+ this command launches installer:
    `xcode-select --install`

##limitations
* some licensed software is not yet possible:
    * `Matlab` 
    * `Adobe Creative Suite`
    * `Mathematica` 
    * `Microsoft Office` 
* setting up bootcamp without the gui is a nightmare

##todo - 09/2014
* make a better copy of my preferences to set by `defaults write ...` in osx_preferences.sh
* complete node, python, R environments
