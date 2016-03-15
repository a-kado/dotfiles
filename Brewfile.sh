#make sure using latest Homebrew
brew update

# Update already-installed formula
brew upgrade

# Add Repository
brew tap homebrew/binary || true

# Packages for development
brew install zsh
brew install git
brew install vim
brew install gcc
brew install mysql
brew install peco
brew install ag
brew install libpng --universal
brew install libjpeg --universal
brew install memcached
brew install tree
brew install ctags
brew install maven
brew install node
brew install npm
brew install homebrew/versions/tomcat6

# Packages for brew-cask
brew install brew-cask

# .dmg from brew-cask
brew cask install atom
brew cask install firefox
brew cask install vagrant
brew cask install alfred
brew cask install iterm2
brew cask install flash-player
brew cask install sourcetree
brew cask install evernote
brew cask install dropbox
brew cask install karabiner
brew cask install bee

# Remove outdated versions
brew cleanup
