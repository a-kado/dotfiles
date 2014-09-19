# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin/:"/usr/local/Cellar/android-sdk":$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

: << '#COMMENT_OUT'

# percolの関数たち
function percol-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        percol --match-method migemo --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N percol-select-history
bindkey '^r' percol-select-history

function percol-search-document() {
    if [ $# -ge 1 ]; then
        DOCUMENT_DIR=$*
    else
        DOCUMENT_DIR=($HOME/Dropbox)
        if [ -d $HOME/Documents ]; then
            DOCUMENT_DIR=($HOME/Documents $DOCUMENT_DIR)
        fi
    fi
    SELECTED_FILE=$(echo $DOCUMENT_DIR | \
        xargs find | \
        grep -E "\.(txt|md|pdf|java|h|m|mm|cpp|html|xml|log)$" | \
        percol --match-method migemo)
    if [ $? -eq 0 ]; then
        echo $SELECTED_FILE | sed 's/ /\\ /g'
    fi
}
alias pd='percol-search-document'

function percol-search-locate() {
    if [ $# -ge 1 ]; then
        SELECTED_FILE=$(locate $* | percol --match-method migemo)
        if [ $? -eq 0 ]; then
            echo $SELECTED_FILE | sed 's/ /\\ /g'
        fi
    else
        bultin locate
    fi
}
alias ps='percol-search-locate'

# パイプ
alias -g E="| xargs emacsclient -n"
alias -g O="| xargs open"
alias -g P="| percol --match-method migemo"
alias -g C="| pbcopy"
alias -g L="| less"
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g S="| sed"

alias -g OS="| xargs subl"
alias -g OV="| xargs vim"

#COMMENT_OUT

#**env系の設定
export PATH="$HOME/.anyenv/bin:$HOME/.plenv/bin:$HOME/.rbenv/bin:$HOME/.pyenv/bin:$HOME/.phpenv/bin:$HOME/.goenv/bin:$PATH"
eval "$(anyenv init -)"
eval "$(plenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(goenv init -)"

#cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# peco
function exists { which $1 &> /dev/null }

function peco-snippets() {

    local SNIPPETS=$(grep -v "^#" ~/.snippets | peco --query "$LBUFFER" | pbcopy)
    zle clear-screen
}

zle -N peco-snippets
bindkey '^x^s' peco-snippets

if exists peco; then

    function peco-select-history() {
        local tac
        if which tac > /dev/null; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(fc -l -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
    }
    zle -N peco-select-history
    bindkey '^r' peco-select-history

    alias killco="ps ax | peco | awk '{ print $1 }' | xargs kill"
    alias psp="ps ax | peco "

    if exists cdr; then
        function peco-cdr () {
            local selected_dir=$(cdr -l | awk '{ print $2 }' | peco --query "$LBUFFER")
            if [ -n "$selected_dir" ]; then
                BUFFER="cd ${selected_dir}"
                zle accept-line
            fi
            zle clear-screen
        }
        zle -N peco-cdr
        bindkey '^z' peco-cdr
    fi

    function search-document-by-peco(){
        if [ $# -ge 1 ]; then
            DOCUMENT_DIR=$*
        else
            if [ -d $HOME/Documents ]; then
                DOCUMENT_DIR=($HOME/Documents $DOCUMENT_DIR)
            fi
        fi 
        SELECTED_FILE=$(echo $DOCUMENT_DIR | xargs find | \
            ag -w "\.(txt|md|pdf|java|h|m|mm|c|cs|cpp|html|vb|xml|log|plist|swift|rb|pm|css|pl|tt|js|coffee|vm)$" | peco)
        if [ $? -eq 0 ]; then
#            vi $SELECTED_FILE
            echo $SELECTED_FILE | sed 's/ /\\ /g'
        fi
    }
    alias pecos='search-document-by-peco'
    alias -g OS="| xargs subl"
    alias -g OV="| xargs vim"

fi

export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home'
#export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home'
export PATH=$JAVA_HOME/bin:$PATH
export CATALINA_HOME='/usr/local/Cellar/tomcat6/6.0.41/libexec'

export ROO_HOME='/usr/local/Cellar/spring-roo/1.2.5'
export PATH=$ROO_HOME/bin:$PATH
export JETTY_HOME=/usr/local/Cellar/jetty/9.2.2/libexec

