#!usr/bin/env sh

# This document is a script meant to aid with installation of my particular workflow

# Installing Software
yay -S --no-confirm reflector git
# Installing Packages
yay -S --needed --noconfirm --nouseask --nocleanmenu --nodiffmenu --removemake - < pkglist.txt # Install all listed packages
pacman -Rns $(pacman -Qtdq) # Remove orphans

# Restoring Configurations
alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
echo ".config" >> .gitignore
git clone --bare https://github.com/xllvrr/dotfiles.git $HOME/.config
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config --local status.showUntrackedFiles no

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

# Setting Up Fcitx
sudo echo "export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx" >>  /etc/profile

# Optimizing Swappiness
echo "Swappiness before patch: $(cat /proc/sys/vm/swappiness)"
echo "vm.swappiness = 10" >>/etc/sysctl.conf
echo "Reboot in order to take effect"

ln -fs .profile .zprofile

# Reminders
echo "Setup Insync, Joplin, Rambox, Thunderbird, Texlive, Discord, Firefox, Steam, Stacer, Gufw, Deja Dup & Timeshift"
echo "Key in Code for Reaper"
