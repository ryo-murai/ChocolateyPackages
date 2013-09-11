$packageName = 'RapidEE'
$installerType = 'exe'

$ver = '904'
$url = "http://www.rapidee.com/download/archive/$ver/RapidEE_setup.exe"
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
