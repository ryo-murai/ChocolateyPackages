param(
  [string] $packageName,
  [switch] $clean,
  [switch] $force
)


$currentPath = Split-Path $((Get-Variable MyInvocation).Value).MyCommand.Path
$targetPkgPath = Join-Path $currentPath $packageName

if(!(Test-Path $targetPkgPath)) {
    echo "no such package:$($packageName)"
    exit 1
}

if($clean) {
  cuninst $packageName
}

if($force) {
  $cinstOpts = "-Force"
}

Push-Location $targetPkgPath

cpack

cinst $packageName "$cinstOpts" -source %cd%

Pop-Location
