$packageName = 'Dexpot-portable'
$url = 'http://dexpot.de/download/dexpot_1611_portable_r2394.zip'

# download and unpack a zip file
Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
