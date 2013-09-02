$packageName = 'Proxomitron'
$url = 'http://www.proxomitron.info/files/download/ProxN45j.zip'
$url64 = $url
$validExitCodes = @(0)

# download and unpack a zip file
Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" "$url64"
