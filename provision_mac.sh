#!/bin/sh
# need xcode command-line/developer tools 
# Xcode 5.1+, OSX 10.9+ xcode-select --install

# Colorize+format output
function better_echo () {
    NORMAL=$(tput sgr0)
    GREEN=$(tput setaf 40)
    printf "\n%b\n" "${GREEN}$1${NORMAL}"
}

# Remove temporary sudoers change 
function restore_sudoers_timeout () {
    better_echo "Restoring /etc/sudoers. Backup at /etc/sudoers.bkp"
    sudo sed -i.bkp '/Defaults timestamp_timeout=-1/d ' /etc/sudoers
}

better_echo "******************************************************"
better_echo "Starting mac provisioning script!"
better_echo "******************************************************"
better_echo "If this script does not terminate, may need to remove the last line from /etc/sudoers"
echo "Defaults timestamp_timeout=-1" | sudo tee -a /etc/sudoers || exit 2

# Update osx software, not perfect but works 
better_echo "Upgrading OSX Software"
softwareupdate --install --all
sudo xcodebuild -license

# Set zsh as SHELL
if grep -qE 'zsh' "$SHELL"; then
    better_echo "User SHELL already set to zsh."
else
    better_echo "Setting user SHELL to zsh."
    chsh -s $(which zsh) 
fi 

# Install homebrew
if hash brew &> /dev/null; then
    better_echo "Homebrew found, skipping installation, but see brew doctor output:"
else
    better_echo "Installing homebrew."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update / clean before installs
better_echo "Updating and upgrading homebrew."
brew update && brew upgrade && brew cleanup

# Add taps to brew before install
better_echo "Adding taps to homebrew."
taplist=$(brew tap);
# cask required for app installs!
if [[ ! $taplist =~ 'caskroom/cask' ]]; then
    brew tap caskroom/cask
fi
# very useful science utils
if [[ ! $taplist =~ 'homebrew/science' ]]; then
    brew tap homebrew/science
fi
# backup for pip
if [[ ! $taplist =~ 'homebrew/python' ]]; then
    brew tap homebrew/python
fi
brew tap --repair

# install utilities with brew
better_echo "Installing homebrew recipes from brew.installs."
brewlist=$(brew list)
while read -r line; do
    if [[ $line != \#* ]]; then 
        if [[ ! $brewlist =~ $line ]]; then
            better_echo "Installing $line"
            brew install $line
        else
            better_echo "$line already found in brew list"
        fi
    fi
done < brew.installs
PATH="usr/local/sbin:$PATH"
PATH="usr/local/bin:$PATH"
export PATH

# install free/freemium apps with brew-cask 
better_echo "Installing apps with homebrew-cask from cask.installs."
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom"
if brewlist | grep -q 'brew-cask'; then
    better_echo "Found brew-cask."
else
    better_echo "Did not find brew-cask, installing now."
    brew install brew-cask
fi 
brew cask cleanup

casklist=$(brew cask list)
while read -r line; do
    if [[ $line != \#* ]]; then 
        if [[ ! $casklist =~ $line ]]; then
            better_echo "Installing $line"
            brew cask install $line
        else
            better_echo "$line already found in brew list"
        fi
    fi
done < cask.installs 

PATH="usr/local/sbin:$PATH"
PATH="usr/local/bin:$PATH"
export PATH

# make sure alfred app can get to caskroom directory
better_echo "Attempting to link Alfred"
# first need to open alfred TODO: make this open command work
open $(brew cask list alfred | grep -E -o -m1 '/opt/homebrew-cask/Caskroom/alfred.*app')
brew cask alfred status
if [ $? -ne 0 ]; then 
    brew cask alfred link
fi

better_echo "Tidying and linking homebrew"
brew cleanup
brew cask cleanup
brew linkapps

# gems configuration -- use rbenv ruby-build
# insert shims in the path to not muck with shipped
# ruby requires rbenv, rbenv-build, rbenv-gem-rehash
better_echo "Configuring ruby environment"
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
rbenv install 2.1.2
rbenv global 2.1.2
rbenv install bundler
rbenv rehash
gem update --system
gem install foreman rails thin
gem install tmuxinator json json_pure vimgolf

# other python tools
better_echo "Configuring pip install packanges outside of Anaconda"
if [ which pip -ne /usr/local/bin/pip ]; then
    sudo easy_install pip
    PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi
# install to user owned directories with --user flag (no sudo!)
pip install git+git://github.com/Lokaltog/powerline --user
pip install psutil --user
pip install virtualenvwrapper awscli setuptools termdown --user

# python -- use Anaconda for data analysis
better_echo "Configuring Anaconda installation"
if [ ! -d $HOME/anaconda ]; then
    EX_DIR=$(pwd)
    mkdir "$HOME/Downloads/Provisioning"
    cd "$HOME/Downloads/Provisioning"
    ANACONDA_VER='2.0.1'
    ANACONDA_MD5='85d261fd4e651f891ca5d0df69441e00'
    better_echo "Downloading Anaconda installer to  $HOME/Downloads/Provisioning/"
    curl -O --progress-bar http://repo.continuum.io/archive/Anaconda-$ANACONDA_VER-MacOSX-x86_64.sh
    if [[ ! $(md5 -q Anaconda-$ANACONDA_VER-MacOSX-x86_64.sh) =~ $ANACONDA_MD5 ]]; then
        better_echo 'Anaconda download failed md5.'
    else
        better_echo "Installing Anaconda $ANACONDA_VER"
        bash Anaconda-$ANACONDA_VER-MacOSX-x86_64.sh
    fi
    rm -f Anaconda-$ANACONDA_VER-MacOSX-x86_64.sh &> /dev/null
    cd $EX_DIR
else
    better_echo "Anaconda already installed"
fi
better_echo "Updating Anaconda packages"
export PATH="$PATH:$HOME/anaconda/bin"

if hash conda &> /dev/null; then
    eval $(which conda)update conda
    eval $(which conda) update anaconda
else
    better_echo "   conda command not found, potential path problem"
    echo "Problem using conda command" >> ${HOME}/provisioning.log 
fi

# R TODO: add config
#better_echo "Configuring R environment" 

# node configuration (mostly for d3)
better_echo "Configuring node environment"
if ! hash npm &> /dev/null; then
    brew update
    brew install node
else
    if hash npm &> /dev/null; then
        eval $(which npm) install -g d3 angular
    else
        better_echo "   Node not found, potential path problem"
        echo "Problem installing node" >> ${HOME}/provisioning.log 
    fi
fi

# Now set up osx preferences
better_echo "Configuring OSX Preferences. Log out and in for some effects."
bash osx_preferences.sh
dockutil --add '~/Downloads' --view grid --display automatic

# Clone/build code repositories
better_echo "Configuring code repositories"
# Git global config (.gitconfig in dotfiles)
git config --global user.name Stephen Holtz 
git config --global user.email git@holtz.email 
# git-credential-osxkeychain default installs with brew install git
git config --global credential.helper osxkeychain
# line ending preferences
git config --global core.autocrlf input
git config --global core.safecrlf true

# dotfile setup
# includes ./antigen for zsh plugins
# includes ./.vim/bundle/vundle for vim plugins
if [ ! -d "$HOME/dotfiles" ]; then
    git clone --recursive https://github.com/stephenholtz/dotfiles.git $HOME/dotfiles
fi
# run sym-linking script from dotfiles required for vundle + antigen
sh $HOME/dotfiles/linkall.sh

better_echo "Installing zsh Plugins"
# try to set up antigen
source $HOME/.zshrc

better_echo "Installing vim Plugins"
# Install all vim bundles
vim +PluginInstall! +qall

if [ ! -d "$HOME/code" ]; then
    mkdir -v $HOME/code
fi
if [ ! -d "$HOME/code/grad" ]; then
    mkdir -v $HOME/code/grad/
    git clone --recursive https://github.com/stephenholtz/matlab-utils.git $HOME/code/grad/matlab-utils
    git clone https://github.com/stephenholtz/matlab-tiff-utils.git $HOME/code/grad/matlab-tiff-utils
fi
if [ ! -d "$HOME/code/personal" ]; then
    mkdir -v $HOME/code/personal/
fi
if [ ! -d "$HOME/code/janelia" ]; then
    mkdir -v $HOME/code/janelia/
fi

better_echo "Setting iTerm2.app preferences from dotfiles :) "
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1
defaults write com.googlecode.iterm2 PrefsCustomFolder ${HOME}/dotfiles/iterm2/

better_echo "Restoring /etc/sudoers file."
restore_sudoers_timeout 

better_echo "Script finished. Log out to finish changes."
