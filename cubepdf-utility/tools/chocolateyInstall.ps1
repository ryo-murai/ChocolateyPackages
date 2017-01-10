#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'cubepdf-utility'
$installerType = 'exe'
$url = 'http://www.cube-soft.jp/cubepdfutility/dl.php?mode=x86'
$url64 = 'http://www.cube-soft.jp/cubepdfutility/dl.php?mode=x64'
$silentArgs = ' /silent'
$validExitCodes = @(0) 

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
