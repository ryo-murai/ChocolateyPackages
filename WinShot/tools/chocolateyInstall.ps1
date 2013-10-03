#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'WinShot'
$installerType = 'exe'
$url = 'http://www.woodybells.com/softs/ws153a.exe'
$url64 = $url 
$silentArgs = ' /silent'
$validExitCodes = @(0) 

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
