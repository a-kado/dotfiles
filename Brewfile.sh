#make sure using latest Homebrew
brew update

# Update already-installed formula
brew upgrade

# Add Repository
brew tap homebrew/binary || true
brew tap homebrew/cask-versions

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

# .dmg from brew-cask
brew install --cask atom
brew install --cask firefox
brew install --cask vagrant
brew install --cask alfred
brew install --cask iterm2
brew install --cask evernote
brew install --cask dropbox
brew install --cask skype
brew install --cask kindle
brew install --cask amazon-cloud-drive
brew install --cask adoptopenjdk8
brew install --cask java11
brew install --cask visual-studio-code
brew install --cask skitch
brew install --cask postman
brew install --cask krisp
brew install --cask google-backup-and-sync
brew install --cask google-japanese-ime
brew install --cask deepl

# Remove outdated versions
brew cleanup
