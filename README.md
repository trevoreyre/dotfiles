# config
Just a place to keep configuration files in sync.

Reference: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

## Installing config files onto a new system

```bash
# Clone repo into a bare repository at ~/.cfg
git clone --bare https://github.com/TrevorEyre/config.git $HOME/.cfg

# Setup config alias to git repo in ~/.cfg
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Checkout the actual content to your home directory
config checkout
# (or config pull origin master)

# If step above fails, remove existing config files (make a backup first) and try again
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

# Set the flag showUntrackedFiles to no on this repo
config config --local status.showUntrackedFiles no
```

## Updating config files

Update as you would normally, using `config` in place of `git`

```bash
config status
config add .bashrc
config commit -m "Updated .bashrc"
config push origin master
```
