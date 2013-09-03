try {
  $version = "3.0.386"
  $packageName = 'Clover'
  $installerUrl = 'http://ejie.me/uploads/Clover_Setup_' + $version + '.zip'
  $installerUrl64 = $installerUrl

  $silentArgs = '/S'
  $validExitCodes = @(0)

  $destination = Join-Path $Env:Temp $packageName
  #Install-ChocolateyZipPackage -url $installerUrl -unzipLocation $destination

  $tempDir = Join-Path $env:TEMP "chocolatey" | Join-Path -ChildPath "$packageName"
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
  $file = Join-Path $tempDir "$($packageName)Install.zip"

  Get-ChocolateyWebFile $packageName $file $installerUrl $installerUrl64
  Get-ChocolateyUnzip "$file" $destination $specificFolder $packageName

  $installer = Get-ChildItem $destination -Recurse -Filter *.exe | Select-Object -First 1 | % { $_.FullName }

  Write-Debug "executing installer exe:$($installer)"

  Start-ChocolateyProcessAsAdmin -statements $silentArgs -exeToRun $installer -minimized -validExitCodes $validExitCodes

  Remove-Item $destination -Recurse
  
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw
}
