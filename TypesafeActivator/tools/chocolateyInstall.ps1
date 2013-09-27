$packageName = 'TypesafeActivator'
$version = "1.0.0"
$url = "http://downloads.typesafe.com/typesafe-activator/$version/typesafe-activator-$version.zip"

# download and unpack a zip file
Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
