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
# shopt -s histappend

# Check the window size after each command and resize if necessary
# shopt -s checkwinsize

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
ls() {
    if [[ $@ == "node_modules" ]]; then
        echo "finding all node_modules"
        command find . -name "node_modules" -type d -prune -print | xargs du -chs
    else
        command ls -AG "$@"
    fi
}
rm() {
    if [[ $@ == "node_modules" ]]; then
        echo "removing all node_modules"
        command find . -name "node_modules" -type d -prune -print -exec rm -rf '{}' \;
    else
        command rm "$@"
    fi
}
# Enable color support of grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Docker aliases
docker() {
    if [[ $1 == "ls" ]]; then
        command docker ps "${@: 2}"
    elif [[ $1 == "bash" ]]; then
        command docker exec -i -t "$2" bash;
    elif [[ $1 == "sh" ]]; then
        command docker exec -i -t "$2" sh
    else
        command docker "$@"
    fi
}
alias dc='docker-compose'
alias dls='docker ps'

# For commiting dotfiles to git repo
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Color variables
GREEN='\[\033[01;32m\]'
BLUE='\[\033[01;34m\]'
ENDCOLOR='\[\033[00m\]'

# Get git branch if in git repository
get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
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

# Set prompt. Ex: /working/directory git-branch
if [ "$COLOR" = yes ]; then
    PS1="$BLUE\w$GREEN\$(get_git_branch) $ENDCOLOR"
else
    PS1="\w\$(get_git_branch) "
fi

# Add completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Add environment files
[[ -r "$HOME/.bash_env" ]] && . "$HOME/.bash_env"

# Delete variables needed for configuration
unset NVM_DIR
unset NPM_DIR
unset GREEN
unset BLUE
unset ENDCOLOR
unset COLOR
