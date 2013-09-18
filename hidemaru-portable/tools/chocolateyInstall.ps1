try {
  $packageName = 'hidemaru-portable'
  $version = "8.32"
  $currDir = Split-Path -parent $MyInvocation.MyCommand.Definition
  $command = Join-Path "$currDir" "InstallHidemaruPortable.ps1"
  $destination = Join-Path "$currDir" $packageName

  #Write-Debug "current location pwd: $(pwd), mylocation: $($MyInvocation.MyCommand.Path)"

  # invoke installation script
  & "$command" -destination `""$destination"`" -version "$version"

  Write-ChocolateySuccess $packageName

} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}
