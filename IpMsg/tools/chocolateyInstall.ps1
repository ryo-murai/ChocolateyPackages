$packageName = 'IpMsg'
$installerType = 'exe'
$url = 'http://ipmsg.org/archive/ipmsg342r2_installer.exe'
$url64 = 'http://ipmsg.org/archive/ipmsg342r2_installer64.exe'
$silentArgs = '' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is alw
$validExitCodes = @(0)

# download and unpack a zip file
#Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" "$url64"
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"
