# config

Just a place to keep configuration files in sync.

Reference: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

## Installing config files onto a new system

You can use [this simple config-install.sh script](https://gist.github.com/TrevorEyre/c4170c6023e94f86cac1d8025aa3176d) which I stored in a GitHub gist.

```bash
# From your $HOME directory
curl -Lks https://gist.githubusercontent.com/TrevorEyre/c4170c6023e94f86cac1d8025aa3176d/raw | /bin/bash
```

## Updating config files

Update as you would normally, using `config` in place of `git`

```bash
config status
config add .bashrc
config commit -m "Updated .bashrc"
config push origin master
```
