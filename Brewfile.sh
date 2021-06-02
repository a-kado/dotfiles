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
brew install ag
brew install libpng --universal
brew install libjpeg --universal
brew install memcached
brew install tree
brew install ctags
brew install maven
brew install node
brew install npm
brew install tomcat@8
brew install jetty
brew install redis
brew install jq
brew install python
brew install gradle
brew install nginx
brew install openssl
brew install docker

# Packages for brew-cask
brew install brew-cask

# .dmg from brew-cask
brew cask install atom
brew cask install firefox
brew cask install vagrant
brew cask install alfred
brew cask install iterm2
brew cask install evernote
brew cask install dropbox
brew cask install skype
brew cask install kindle
brew cask install amazon-cloud-drive
brew cask install java8
brew cask install java11
brew cask install visual-studio-code
brew cask install skitch
brew cask install postman
brew cask install krisp
brew cask install google-backup-and-sync
brew cask install google-japanese-ime
brew cask install deepl

# Remove outdated versions
brew cleanup
