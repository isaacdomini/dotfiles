When logging onto a new server do the following.
```
curl -u isaacdomini https://raw.githubusercontent.com/isaacdomini/dotfiles/master/setup.sh > setup.sh && bash setup.sh [config params]
```
## List of Programs Installed
Depending on the OS, the following core programs and tools may be installed:
* Git, OpenSSH, Vim, Tmux, Zsh
* Xcode command line tools (Mac)
* Powerlevel10k Zsh Theme
* GitHub CLI (gh)
* Node.js, Ruby (via RVM), Rails, Docker, Google Chrome, VirtualBox (via OS-specific fullsetup scripts)

## Config Autoinstall
The autoinstall process is initiated via the one-liner `curl` command.
1. It downloads `setup.sh` and executes it.
2. `setup.sh` automatically detects your operating system (`ubuntu`, `mac`, `arch`).
3. It installs initial dependencies, generates SSH keys, and clones this dotfiles repository.
4. If successful, it asks to run the OS-specific `fullsetup.sh` script to install the rest of the essential programs and configurations.

## Arch Packages
The setup script uses `pacman` to install the following Arch packages initially:
* `git`
* `openssh`
* `openssh-server`
