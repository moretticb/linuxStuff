# instalar zenity
# validar first run caso nao haja arquivo em /tmp guardando wireless interface name
# listar perfis em /etc/netctl com dmenu
#	opcao para abrir o wifi-menu numa nova janela com o termite

ssid=$(ls /etc/netctl | grep -v _temp$ | sed -E "s/^[^-]*$/OPEN WiFi MENU/g" | sed -E "s/[a-zA-Z0-9]+-(.*)/\1/g" | uniq | dmenu -p "WiFi" -i)

if [ "$?" = "1" ]; then
	exit 1;
fi

if [ "$ssid" = "OPEN WiFi MENU" ]; then
	termite --exec="sudo wifi-menu"
	exit 0
fi

sudopass=$(zenity --password --title="Sudo password")
interf=$(iwconfig 2>/dev/null | grep ^w | cut -d" " -f 1)
echo "Interface name: $interf"

pfile="$interf-$ssid"
lines=$(echo $sudopass | sudo -S cat "/etc/netctl/$pfile" | grep "FIELD_" | wc -l)

echo $sudopass | sudo -S netctl stop-all

if [ $lines -gt 0 ]; then
	netauth=$(zenity --username --password --title="Authentication for $ssid")
	if [ "$?" = 1 ]; then
		exit 1;
	fi

	echo $sudopass | sudo -S cat "/etc/netctl/$pfile" | sed "s/<FIELD_USERNAME>/$(echo $netauth | cut -d"|" -f 1)/g" | sed "s/<FIELD_PASS>/$(echo $netauth | cut -d"|" -f 2)/g" > "/tmp/$(echo $pfile)_temp"

	echo $sudopass | sudo -S mv "/tmp/$(echo $pfile)_temp" /etc/netctl/
	echo $sudopass | sudo -S netctl switch-to "$(echo $pfile)_temp"
	echo $sudopass | sudo -S rm /etc/netctl/"$(echo $pfile)_temp"
	echo $sudopass | sudo -S touch /etc/netctl/"$(echo $pfile)_temp"
else
	echo $sudopass | sudo -S netctl switch-to "$pfile"
fi

pkill -RTMIN+14 i3blocks
pkill -RTMIN+15 i3blocks

