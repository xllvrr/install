#!usr/bin/env sh

# This document is a script meant to aid with installation of my particular workflow

# Installing Software
yay -S --sudoloop reflector
# Installing Packages
yay -S --needed --sudoloop --nouseask --nocleanmenu --nodiffmenu --removemake --noprovides - < pkglist.txt # Install all listed packages
pacman -Rns $(pacman -Qtdq) # Remove orphans

# Cloning Needed Git Repos
# Dmenu
CURRENT_DIR="$PWD"
git clone https://github.com/LukeSmithxyz/dmenu.git ~/repos/dmenu
cd ~/repos/dmenu || exit
make && sudo make install
cd "$CURRENT_DIR" || exit
# Tabbed
git clone https://git.suckless.org/tabbed ~/repos/tabbed
cd ~/repos/tabbed || exit
make && sudo make install
cd "$CURRENT_DIR" || exit
# Scripts
git clone https://github.com/xllvrr/scripts.git ~/repos/scripts

# Change Default Shell to Zsh
chsh -s /usr/bin/zsh

# Install Python Stuff
pip3 install --user pynvim flake8 autopep8 pylint mysql-connector

# Restore R setup
Rscript Rinstall.R

# Setting Up Fcitx
echo "export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx" >> sudo /etc/profile

# Optimizing Swappiness
echo "Swappiness before patch: $(cat /proc/sys/vm/swappiness)"
echo "vm.swappiness = 10" >> sudo /etc/sysctl.conf
echo "Reboot in order to take effect"

# Enabling Services
sudo ln -fs .profile .zprofile

# Restoring Configurations
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/xllvrr/dotfiles.git $HOME/.dotfiles
cd ~

mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

config checkout
config config --local status.showUntrackedFiles no

# Install VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install zsh plugins
yay zsh-autosuggestions \
zsh-syntax-highlighting \
zsh-you-should-use

# Install TeXLive
yay texlive-installer
/opt/texlive-installer/install-tl

# Reminders
echo "Setup Insync, Joplin, Rambox, Thunderbird, Texlive, Discord, Firefox, Steam, Stacer, Gufw, Deja Dup & Timeshift"
echo "Key in Code for Reaper"
