#!/bin/bash

echo -e "\nCreating directory for i3blocks config file"
mkdir -p $HOME/.config/i3blocks

echo "Linking i3blocks config file"
ln -s -fi $HOME/linuxStuff/.config/i3blocks/config $HOME/.config/i3blocks/config


echo -e "\nCreating directory for i3 config file"
mkdir -p $HOME/.config/i3

echo "Linking i3 config file"
ln -s -fi $HOME/linuxStuff/.config/i3/config $HOME/.config/i3/config

echo -e "\nLinking USPNet vpn connection script"
sudo ln -s -fi $HOME/linuxStuff/mytools/vpn.sh /bin/vpn

echo -e "\nLinking bandeco tool"
sudo ln -s -fi $HOME/linuxStuff/mytools/bandeco.sh /bin/bandeco

echo -e "\nLinking currency tool"
sudo ln -s -fi $HOME/linuxStuff/mytools/currency.sh /bin/currency

echo -e "\nLinking btdevices tool"
sudo ln -s -fi $HOME/linuxStuff/mytools/btdevices.sh /bin/btdevices

echo -e "\nLinking troubleshooting tool"
sudo ln -s -fi $HOME/linuxStuff/mytools/troubleshooting.sh /bin/troubleshooting

echo -e "\nLinking weather tool"
sudo ln -s -fi $HOME/linuxStuff/mytools/weather.sh /bin/weather



echo -e "\nCreating folder for mounting Google Drive"
mkdir -p $HOME/gd

#criar pasta screenshots
echo -e "\nCreating screenshots folder"
mkdir -p $HOME/.screenshots


echo -e "\nLinking config files"

echo -e "\ngitconfig"
ln -s -fi $HOME/linuxStuff/.gitconfig $HOME/.gitconfig

echo -e "\nvimrc"
ln -s -fi $HOME/linuxStuff/.vimrc $HOME/.vimrc

echo -e "\npythonrc"
ln -s -fi $HOME/linuxStuff/.pythonrc $HOME/.pythonrc

echo -e "\nbashrc"
ln -s -fi $HOME/linuxStuff/.bashrc $HOME/.bashrc

echo -e "\nxinitrc"
ln -s -fi $HOME/linuxStuff/.xinitrc $HOME/.xinitrc


$HOME/linuxStuff/mytools/install_check.sh
