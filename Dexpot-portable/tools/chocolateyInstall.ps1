# see download page below to get the url for Dexpot Portable
#  http://dexpot.de/?id=download
$packageName = 'Dexpot-portable'
$url = 'http://dexpot.de/download/dexpot_1614_portable_r2439.zip'

# download and unpack a zip file
Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
