# demais programas para instalar
# instalar pamixer
# instalar xdotool
# instalar firefox
# instalar beep
# instalar yaourt
# instalar wget
# instalar feh
# instalar tcl
# instalar R
# instalar playerctl
# instalar qt
# instalar vlc
# instalar evince
# instalar jupyter
# instalar transmission-cli
# instalar acpi


# AUR
# instalar google-drive-ocamlfuse
# instalar otf-font-awesome-4

programs=$(cat ./* | grep instal | sort | uniq | cut -d" " -f 3)

for tool in $programs; do
	pacman -Ss $tool | grep "^[^[:space:]].*/$(echo $tool) " | grep -v installed
done

echo -e "\nInstall the following programs with yaourt (requisites for the tools to work):"

programs=$(cat ./* | grep instal | sort | uniq | cut -d" " -f 3)

for tool in $programs; do
	yaourt -Ss $tool | grep "^[^[:space:]].*/$(echo $tool) " | grep -v installed | grep aur
done

