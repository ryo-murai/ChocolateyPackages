# require the powershell 3.0, pscx

param(
  [parameter(Position=0)]
  [ValidateSet("All", "Hidemaru", "HidemaruTakeout", "SendTo", "AssocFiles")]
  [string]$target,

  [parameter(Position=1)]
  [string]$installDir = (Get-Location).Path,

  [string]
  $version,

  [string]
  $hmtakeoutVer = "206"
)

$packageName = 'hidemaru'
Write-Host "InstallHidemaruPortable.ps1: invoked argument with target: $target, installDir: $installDir, version: $version, porttoolVer: $hmtakeoutVer"

function Solve-HidemaruVersion
{
  # retrieve the latest version of Hidemaru
  # hidemaru.ver contains a string like "2013/09/03 8.32"
  $version = if(! $version) {
   # default is the latest
   (-split (irm "http://hide.maruo.co.jp/software/hidemaru.ver"))[1]
  }
  $version
}

function Get-TemporaryDir
{
  $tempDir = Join-Path $env:TEMP "chocolatey" | Join-Path -ChildPath "$packageName"
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
  $tempDir
}

function Download-Hidemaru
{
  param([parameter(Position=0)][string]$hmVersion)

  $shortver = $hmVersion.replace('.', '')
  $url32 = "http://hide.maruo.co.jp/software/bin/hm$($shortver)_signed.exe"
  $url64 = "http://hide.maruo.co.jp/software/bin/hm$($shortver)_x64_signed.exe"
  
  $IsSytem32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
    ($Env:PROCESSOR_ARCHITEW6432 -eq $null))
  
  $url = if($IsSytem32Bit) { $url32 } else { $url64 }
  
  # temporary dir to save the installer locally
  $tempDir = Get-TemporaryDir
  $installerPath = Join-Path $tempDir "$($packageName)-install.exe"
  
  irm $url -outfile $installerPath
  $installerPath
}

function Download-HidemaruTakeout
{
  param([parameter(Position=0)][string]$htoVersion)

  $tempDir = Get-TemporaryDir
  $takeoutInstPath = Join-Path $tempDir "$($packageName)takeout-install.exe"
  irm "http://hide.maruo.co.jp/software/bin3/hmtakeout$($htoVersion)_signed.exe" -outfile $takeoutInstPath
  $takeoutInstPath
}

function Add-SendToHidemaru
{
  param(
   [parameter(Position=0)]
   [string]$instDir
  )

  $sendToDir = [Environment]::GetFolderPath('SendTo')
  $exePath = Get-ChildItem $instDir -filter "Hidemaru.exe" | select -first 1 | % {$_.FullName}

  $shell = New-Object -COM WScript.Shell
  #$sendToDir = $shell.SpecialFolders.Item("sendto")
  #$shortcutPath = Join-Path -Path $sendToDir -ChildPath "HidemaruOkuru.lnk"
  $shortcut = $shell.CreateShortcut("$sendToDir\秀丸へ送る.lnk")
  #$shortcut = $shell.CreateShortcut($shortcutPath)
  $shortcut.TargetPath = $exePath
  $shortcut.WorkingDirectory = "$instDir"
  $shortcut.Description = "秀丸エディタ"
  $shortcut.IconLocation = "$exePath, 0"
  $shortcut.WindowStyle = 1
  $shortcut.Save()
}

function AssocTxtFilesToHidemaru
{
  param(
   [parameter(Position=0)]
   [string]$instDir
  )

  $exePath = Get-ChildItem $instDir -filter "Hidemaru.exe" | select -first 1 | % {$_.FullName}

  $ext = ".txt", ".log", ".ini", ".lst"

  #& cmd /c 'ftype hidemarup=\`"$exePath\`" \`"%1\`" \`"%*\`"'
  & cmd /c "ftype hidemarup='$exePath' '%1' '%*'"

  $ext | % { & cmd /c assoc $_=hidemarup }
}

if (![System.IO.Directory]::Exists($installDir)) {
  [System.IO.Directory]::CreateDirectory($installDir) 
}

switch ($target)
{
  "All" {
    $version = Solve-HidemaruVersion
    $installer = Download-Hidemaru($version)
    Expand-Archive -Path $installer -OutputPath $installDir -ShowProgress -Force

    $installer = Download-HidemaruTakeout($hmtakeoutVer)
    Expand-Archive -Path $installer -OutputPath $installDir -ShowProgress -Force

    Add-SendToHidemaru "$installDir"
    AssocTxtFilesToHidemaru "$installDir"
  }

  "Hidemaru" {
    $version = Solve-HidemaruVersion
    $installer = Download-Hidemaru($version)
    Expand-Archive -Path $installer -OutputPath $installDir -ShowProgress -Force
  }

  "HidemaruTakeout" {
    $installer = Download-HidemaruTakeout($hmtakeoutVer)
    Expand-Archive -Path $installer -OutputPath $installDir -ShowProgress -Force
  }

  "SendTo" {
    Add-SendToHidemaru "$installDir"
  }

  "AssocFiles" {
    AssocTxtFilesToHidemaru "$installDir"
  }
}
