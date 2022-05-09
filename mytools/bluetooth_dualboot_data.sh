#!/bin/sh

# install chntpw package to use reged tool
# get SYSTEM file at C:\Windows\System32\config\SYSTEM (by mounting windows partition or though livecd)
#
# run:
#    $ sudo bluetooth_dualboot_data.sh SYSTEM
#

# if the path below does not work, try replacing ControlSet001 with CurrentControlSet
reged -x $1 HKEY_LOCAL_MACHINE\\SYSTEM ControlSet001\\Services\\BTHPORT\\Parameters\\Keys /tmp/reg_temp.reg

#to ensure to run as sudo
chmod 777 /tmp/reg_temp.reg

if [ "$?" != "0" ]; then
	exit 1;
fi

sed -i "s/,//g" /tmp/reg_temp.reg

#sed -i -E "s/hex:([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2}),([0-9a-f]{2})/\U\1\U\2\U\3\U\4\U\5\U\6\U\7\U\8\U\9\U\10\U\11\U\12\U\13\U\14\U\15\U\16/g" /tmp/reg_temp.reg
sed -i -E "s/([^=]+)=hex:([0-9a-f]+)/\1=\U\2/g" /tmp/reg_temp.reg

sed -i -E "s/hex\(b\):([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})/\U\8\7\6\5\4\3\2\1/g" /tmp/reg_temp.reg

sed -i -r 's#"ERand"=([0-9A-F]+).*#echo  "\\"ERand\\"=$(echo "ibase=16; \1" | bc -l)"#e' /tmp/reg_temp.reg

sed -i -r 's#([^=]+)=dword:([0-9a-f]+).*#echo  "\\"\1\\"=$(echo "ibase=16; \U\2\L" | bc)"#e' /tmp/reg_temp.reg

cat /tmp/reg_temp.reg



echo "--------------------------------- INSTRUCTIONS ------------------------------------"
echo ""
echo " Go to /var/lib/bluetooth/[base_addr]/[device_addr]/info as sudo"
echo " If the [device_addr] is different on windows, rename the folder here"
echo ""
echo "   Some devices will require only to replace the contents of parameter Key (under"
echo " LinkKey section) with the respective hex key in [DEVICE_ADDR]=[HEX_KEY] format"
echo " shown above. Take notes about the device you are dealing with so it can be found"
echo " here."
echo ""
echo "   Other devices will need more specific data in the same file, as follows:"
echo ""
echo " - Under IdentityResolvingKey section, for Key, use IRK"
echo " - Under LocalSignatureKey section, for Key, use CSRK"
echo " - Under LongTermKey section:"
echo "   - For Key, use LTK"
echo "   - For EDiv, use EDIV"
echo "   - For Rand, use ERand"
echo ""
echo "--------------------------------------------------------------------i---------------"
