# dotfiles

Keep configuration files in sync.

Reference: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

## Installing dotfiles onto a new system

You can use [this dotfiles-install.sh script](https://gist.github.com/trevoreyre/c4170c6023e94f86cac1d8025aa3176d) which I stored in a GitHub gist.

```bash
# From your $HOME directory
curl -Lks https://gist.githubusercontent.com/trevoreyre/c4170c6023e94f86cac1d8025aa3176d/raw | /bin/bash
```

## Updating dotfiles

Update as you would normally, using `dotfiles` in place of `git`

```bash
dotfiles status
dotfiles add .bashrc
dotfiles commit -m "Updated .bashrc"
dotfiles push origin master
```
