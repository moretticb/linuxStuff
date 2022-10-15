#
# REBOOTING FROM WINDOWS TO LINUX OR ANY OTHER BOOTLOADER. Instructions:
#
# 1. On Windows: press WINDOW+R, type %HOMEPATH% and hit ENTER. Place this file there.
#
# 2. Right click inside folder > New > Shortcut
# 2.1. Paste the following as location: %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File %HOMEDRIVE%%HOMEPATH%\reboot_to.ps1
# 2.2. Click Next, name it as reboot_to and press Finish
# 2.3. Right click the shortcut icon > Properties > Advanced > Check "Run as administrator" option > OK > OK
#
# 3. To use this tool, press WINDOW+R > type reboot_to > Enter
#
# PS: for rebooting from Linux to Windows use reboot_to_windows tool (check .bashrc file on Linux)
#
 
bcdedit /enum firmware | findstr description | Foreach {":$(($_ -split '\s+',4)[1])"} | findstr -n ":"
 
$opt = Read-Host -Prompt 'Reboot to which?'
 
$uuid = bcdedit /enum firmware | findstr identifier | findstr /V fwbootmgr | Foreach {":$(($_ -split '\s+',4)[1])"} | findstr -n ":" | findstr /B "$opt::" | Foreach {"$(($_ -split ':+',4)[1])"}
 
bcdedit /set "{fwbootmgr}" bootsequence "$uuid" /addfirst
shutdown /f /r /t 0
