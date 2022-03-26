#!/bin/bash

echo -e "\nCreating directory for i3blocks config file"
mkdir -p $HOME/.config/i3blocks

echo "Linking i3blocks config file"
ln -s -f $HOME/linuxStuff/.config/i3blocks/config $HOME/.config/i3blocks/config


echo -e "\nCreating directory for i3 config file"
mkdir -p $HOME/.config/i3

echo "Linking i3 config file"
ln -s -f $HOME/linuxStuff/.config/i3/config $HOME/.config/i3/config

echo -e "\nCreating directory for alacritty config file"
mkdir -p $HOME/.config/alacritty

echo "Linking alacritty config file"
ln -s -f $HOME/linuxStuff/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

echo -e "\nLinking USPNet vpn connection script"
sudo ln -s -f $HOME/linuxStuff/mytools/vpn.sh /bin/vpn

echo -e "\nLinking btdevices tool"
sudo ln -s -f $HOME/linuxStuff/mytools/btdevices.sh /bin/btdevices

echo -e "\nLinking troubleshooting tool"
sudo ln -s -f $HOME/linuxStuff/mytools/troubleshooting.sh /bin/troubleshooting

echo -e "\nLinking weather tool"
sudo ln -s -f $HOME/linuxStuff/mytools/weather.sh /bin/weather



#criar pasta screenshots
echo -e "\nCreating screenshots folder"
mkdir -p $HOME/.screenshots


echo -e "\nLinking config files"

echo -e "\ngitconfig"
ln -s -f $HOME/linuxStuff/.gitconfig $HOME/.gitconfig

echo -e "\nvimrc"
ln -s -f $HOME/linuxStuff/.vimrc $HOME/.vimrc

echo -e "\npythonrc"
ln -s -f $HOME/linuxStuff/.pythonrc $HOME/.pythonrc

echo -e "\nbashrc"
ln -s -f $HOME/linuxStuff/.bashrc $HOME/.bashrc

echo -e "\nbash_profile"
ln -s -f $HOME/linuxStuff/.bash_profile $HOME/.bash_profile

echo -e "\nxinitrc"
ln -s -f $HOME/linuxStuff/.xinitrc $HOME/.xinitrc

echo -e "\nXmodmap"
ln -s -f $HOME/linuxStuff/.Xmodmap $HOME/.Xmodmap

