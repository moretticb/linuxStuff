#
# REBOOTING FROM WINDOWS TO LINUX OR ANY OTHER BOOTLOADER. Instructions:
#
# 1. Press WINDOW+R, type %HOMEPATH% and hit ENTER. Place this file there.
#
# 2. Right click inside folder > New > Shortcut
# 2.1. Paste the following as location: %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle hidden -ExecutionPolicy Bypass -File %HOMEDRIVE%%HOMEPATH%\reboot_to.ps1
# 2.2. Click Next, name it as reboot_to and press Finish
# 2.3. Right click the shortcut icon > Properties > Advanced > Check "Run as administrator" option > OK > OK
#
# 3. To use this tool, press WINDOW+R > type reboot_to > Enter
#
# PS: for rebooting from Linux to Windows use reboot_to_windows tool
#
 
bcdedit /enum firmware | findstr description | Foreach {":$(($_ -split '\s+',4)[1])"} | findstr -n ":"
 
# $opt = Read-Host -Prompt 'Reboot to which?'
 
# $uuid = bcdedit /enum firmware | findstr identifier | findstr /V fwbootmgr | Foreach {":$(($_ -split '\s+',4)[1])"} | findstr -n ":" | findstr /B "$opt::" | Foreach {"$(($_ -split ':+',4)[1])"}
 
 
Add-Type -AssemblyName System.Windows.Forms
$formADNewUserScriptSetUs = New-Object 'System.Windows.Forms.Form'
$formADNewUserScriptSetUs.Text = 'Reboot to which?'
$formADNewUserScriptSetUs.ClientSize = New-Object System.Drawing.Size(310, 60)
 
$combobox1 = New-Object 'System.Windows.Forms.ComboBox'
$combobox1.add_KeyPress({
    if($_.KeyChar -eq 13){ # ENTER
        $buttonOK.PerformClick()
    } elseif($_.KeyChar -eq 27){ # ESC
        $formADNewUserScriptSetUs.Close()
    }
   
})
 
bcdedit /enum firmware | findstr description | Foreach {":$(($_ -split '\s+',4)[1])"} | findstr -n ":" | %{[void]$combobox1.Items.Add("$_")}
 
$combobox1.Location = New-Object System.Drawing.Point(20, 20)
$combobox1.Size = New-Object System.Drawing.Size(200, 21)
 
$buttonOK = New-Object 'System.Windows.Forms.Button'
$buttonOK.Location = New-Object System.Drawing.Point(240, 20)
$buttonOK.Size = New-Object System.Drawing.Size(50, 20)
$buttonOK.Text = 'OK'
 
$buttonOK.add_Click({
    $opt = $combobox1.selectedIndex + [int]1
    $uuid = bcdedit /enum firmware | findstr identifier | findstr /V fwbootmgr | Foreach {":$(($_ -split '\s+',4)[1])"} | findstr -n ":" | findstr /B "$opt::" | Foreach {"$(($_ -split ':+',4)[1])"}    
 
    if ( $opt -ge 1 )
    {
        Write-Host "$opt selected with UUID $uuid"
        $formADNewUserScriptSetUs.Close()
 
        bcdedit /set "{fwbootmgr}" bootsequence "$uuid" /addfirst
        shutdown /f /r /t 0
    } else {
        Write-Host "invalid option"
    }
   
})
 
$formADNewUserScriptSetUs.Controls.Add($combobox1)
$formADNewUserScriptSetUs.Controls.Add($buttonOK)
 
 
$formADNewUserScriptSetUs.ShowDialog()
