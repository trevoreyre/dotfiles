# Don't put duplicate lines or lines starting with space in the history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# History size
HISTSIZE=1000
SAVEHIST=2000

# Append to the history file, don't overwrite it
# setopt APPEND_HISTORY

# Set up the correct Node version manager.
VOLTA_HOME="$HOME/.volta"
NVM_DIR="$HOME/.nvm"
NPM_DIR="$HOME/.npm-global"

if [ -d $VOLTA_HOME ]; then
    # Volta
    echo "Loading volta"
    export VOLTA_HOME=$VOLTA_HOME
    export PATH="$VOLTA_HOME/bin:$PATH"
elif command -v fnm >/dev/null 2>&1; then
    # Fast Node Manager (fnm)
    echo "Loading fnm"
    eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"
    # Load fnm zsh completions
    if [ ! -e $HOME/.fnm-zsh-completions ]; then
        fnm completions --shell zsh > $HOME/.fnm-zsh-completions
    fi
    source $HOME/.fnm-zsh-completions
elif [ -d $NVM_DIR ]; then
    # Node Version Manager (nvm)
    echo "Loading nvm"
    export NVM_DIR=$NVM_DIR
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # Load nvm
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # Load nvm completions
else
    # Vanilla npm
    echo "Setting up global npm"
    export PREFIX=$NPM_DIR
    export PATH="$NPM_DIR/bin:$NPM_DIR:$PATH"
fi

# Aliases
alias ls='ls -AG'
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
    alias ls='ls --color=auto -AG'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Docker aliases
docker() {
    if [[ $1 == "ls" ]]; then
        command docker ps "${@:2}"
    elif [[ $1 == "bash" ]]; then
        command docker exec -i -t "$2" bash;
    elif [[ $1 == "sh" ]]; then
        command docker exec -i -t "$2" sh
    else
        command docker "$@"
    fi
}
dc() {
    if [[ $1 == "rebuild" ]]; then
        command docker compose build --pull
    else
        command docker compose "$@"
    fi
}
alias dls='docker ps'

# For committing dotfiles to git repo
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Get git branch if in git repository
get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Enable prompt substitution
setopt PROMPT_SUBST

# Set prompt. Ex: /working/directory git-branch
if [ "$PLATFORM" = docker ]; then
    PROMPT="%B%F{magenta}%~%F{green}\$(get_git_branch) %f%b"
else
    PROMPT="%B%F{blue}%~%F{green}\$(get_git_branch) %f%b"
fi

# Add completions
autoload -Uz compinit && compinit
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Add environment files
[[ -r "$HOME/.zsh_env" ]] && . "$HOME/.zsh_env"

# Delete variables needed for configuration
unset NVM_DIR
unset NPM_DIR
