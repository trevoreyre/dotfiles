# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# History size
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and resize if necessary
shopt -s checkwinsize

# Set up NVM, if installed. Otherwise, set up global npm/yarn install paths.
NVM_DIR="$HOME/.nvm"
NPM_DIR="$HOME/.npm-global"
if [ -d $NVM_DIR ]; then
    export NVM_DIR=$NVM_DIR
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion
else
    export PREFIX=$NPM_DIR
    export PATH="$NPM_DIR/bin:$NPM_DIR:$PATH"
fi

# Aliases
alias ll='ls -AlG'
alias la='ls -AG'
alias l='ls -CG'
# Enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Docker aliases
alias dps='docker ps'
alias dstop='docker container stop'
alias dup='docker-compose up'
alias ddown='docker-compose down'
alias dbuild='docker-compose build'
dbash() { docker exec -i -t "$1" bash; }
dsh() { docker exec -i -t "$1" sh; }

# For commiting dotfiles to git repo
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Color variables
GREEN='\[\033[01;32m\]'
BLUE='\[\033[01;34m\]'
ENDCOLOR='\[\033[00m\]'

# Get git branch if in git repository
get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

# Set a fancy prompt
case "$TERM" in
    xterm-color) COLOR=yes;;
esac

# Detect color support
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    COLOR=yes
else
    COLOR=
fi

# Set prompt. Ex: /working/directory [git-branch] >
if [ "$COLOR" = yes ]; then
    PS1="$BLUE\w$GREEN\$(get_git_branch)$BLUE > $ENDCOLOR"
else
    PS1="\w\$(get_git_branch) > "
fi

# Add completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Delete variables needed for configuration
unset NVM_DIR
unset NPM_DIR
unset GREEN
unset BLUE
unset ENDCOLOR
unset COLOR
