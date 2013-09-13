$packageName = 'ScalaIDE'

# http://scala-ide.org/download/sdk.html
$url =   "http://downloads.typesafe.com/scalaide-pack/3.0.1.vfinal-210-20130718/scala-SDK-3.0.1-vfinal-2.10-win32.win32.x86.zip"
$url64 = "http://downloads.typesafe.com/scalaide-pack/3.0.1.vfinal-210-20130718/scala-SDK-3.0.1-vfinal-2.10-win32.win32.x86_64.zip"

Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" "$url64"
