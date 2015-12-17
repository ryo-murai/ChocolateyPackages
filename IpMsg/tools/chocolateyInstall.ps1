try {
  $packageName = 'IpMsg'
  $installerType = 'exe'
  $url = 'http://ipmsg.org/archive/ipmsg363_installer.exe'
  $url64 = 'http://ipmsg.org/archive/ipmsg363_installer64.exe'
  $silentArgs = '' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is alw
  $validExitCodes = @(0)

  Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
