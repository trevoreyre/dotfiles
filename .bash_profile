if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi
if [ -f $HOME/.volta ]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
fi
