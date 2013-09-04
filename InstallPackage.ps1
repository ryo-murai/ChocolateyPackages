param(
  [string] $packageName,
  [switch] $clean
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

Push-Location $targetPkgPath

cpack

cinst $packageName -source %cd%

Pop-Location