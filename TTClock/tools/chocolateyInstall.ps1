$packageName = 'TTClock'
$installerType = 'exe'
$url = 'http://chihiro718.jpn.org/files/TTClock/TTClockSetup30.zip'
$url64 = 'http://chihiro718.jpn.org/files/TTClock/TTClockSetup64Free.zip'

# create temp dir
$tempDir = Join-Path $env:TEMP "chocolatey" | Join-Path -ChildPath "$packageName"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
$zipfile = Join-Path $tempDir "$($packageName)Install.zip"
$destination = Join-Path $Env:Temp $packageName

# download and unzip
Get-ChocolateyWebFile "$packageName" "$zipfile" "$url" "$url64"
Write-Host "going to unzip $zipfile into $destination  ..."
Get-ChocolateyUnzip -fileFullPath "$zipfile" -destination "$destination" -packageName "$packageName"
$target =  Get-ChildItem "${destination}\*.${installerType}" | select -First 1
Write-Host "target installer file path: $target"

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights
$silentArgs = ' /S'
$validExitCodes = @(0) 

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" $target -validExitCodes $validExitCodes
