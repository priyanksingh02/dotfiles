# dotfiles
OS: Arch Linux

## Git bare repository setup
```sh
git clone --bare git@github.com:priyanksingh02/dotfiles.git $HOME/.cfg
```
Create alias for config management
```sh
alias c='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
Restore Dotfiles
```sh
c checkout
```
If checkout operation fails
```sh
mkdir -p .config-backup
if [ $? = 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  c checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi
c checkout
```
Hide Untracked files from `c status`
```sh
c config status.showUntrackedFiles no
```

## Config Management

Installation scripts are provided in `.local/cfg`.
Copy the `Makefile` from `.local/cfg` into the `$HOME` directory for installation operations.
