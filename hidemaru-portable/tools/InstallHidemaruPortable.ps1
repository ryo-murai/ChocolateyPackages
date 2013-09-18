# require the powershell 3.0, pscx

param(
  [parameter(Position=0)]
  [string]$destination,
  $version
)

try {

  Write-Host "InstallHidemaruPortable.ps1: invoked argument with destination: $destination, version: $version"

  $packageName = 'hidemaru'
  $installDir = if($destination) { $destination } else {Join-Path $env:USERPROFILE "tools\hidemaru"}
  $hmtakeoutVer = "206"

  if (![System.IO.Directory]::Exists($installDir)) { [System.IO.Directory]::CreateDirectory($installDir) }

  # retrieve the latest version of Hidemaru
  # hidemaru.ver contains a string like "2013/09/03 8.32"
  $version = if(! $version) {
    # default is the latest
    (-split (irm "http://www2.maruo.co.jp/_software/hidemaru.ver"))[1]
  }
  $shortver = $version.replace('.', '')
  $url32 = "http://hide.maruo.co.jp/software/bin2/hm$($shortver)_signed.exe"
  $url64 = "http://hide.maruo.co.jp/software/bin/hm$($shortver)_x64_signed.exe"

  $IsSytem32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
    ($Env:PROCESSOR_ARCHITEW6432 -eq $null))

  $url = if($IsSytem32Bit) { $url32 } else { $url64 }

  # temporary dir to save the installer locally
  $tempDir = Join-Path $env:TEMP "chocolatey" | Join-Path -ChildPath "$packageName"
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
  $installerPath = Join-Path $tempDir "$($packageName)-install.exe"
  $takeoutInstPath = Join-Path $tempDir "$($packageName)takeout-install.exe"

  irm $url -outfile $installerPath
  Expand-Archive -Path $installerPath -OutputPath $installDir -ShowProgress

  irm "http://hide.maruo.co.jp/software/bin3/hmtakeout$($hmtakeoutVer)_signed.exe" -outfile $takeoutInstPath
  Expand-Archive -Path $takeoutInstPath -OutputPath $installDir -ShowProgress

} catch {
  Write-Host "InstallHidemaruPortable.ps1" "$($_.Exception.Message)" -ForegroundColor Red
  throw
}
