$packageName = 'Dexpot-portable'
$url = 'http://www.dexpot.de/download/dexpot_1610_portable_r2373.zip'

# download and unpack a zip file
Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
