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

echo -e "\nbashrc"
ln -s -fi $HOME/linuxStuff/.bashrc $HOME/.bashrc

echo -e "\nxinitrc"
ln -s -fi $HOME/linuxStuff/.xinitrc $HOME/.xinitrc


echo "Install the following programs (requisites for the tools to work):"

programs=$(cat mytools/* | grep instal | sort | uniq | cut -d" " -f 3)

for tool in $programs; do
	pacman -Ss $tool | grep "^[^[:space:]].*/$(echo $tool) " | grep -v installed
done

echo -e "\nInstall the following programs with yaourt (requisites for the tools to work):"

programs=$(cat mytools/* | grep instal | sort | uniq | cut -d" " -f 3)

for tool in $programs; do
	yaourt -Ss $tool | grep "^[^[:space:]].*/$(echo $tool) " | grep -v installed
done

