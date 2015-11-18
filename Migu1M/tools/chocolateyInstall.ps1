# https://github.com/Iristyle/ChocolateyPackages/blob/master/SourceCodePro/tools/chocolateyInstall.ps1
# http://stackoverflow.com/questions/16023238/installing-system-font-with-powershell
#

try {
  $packageName = 'Migu1M'
  $fontUrl = 'http://osdn.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F63545%2Fmigu-1m-20150712.zip'
  $destination = Join-Path $Env:Temp $packageName

  $tempDir = Join-Path $env:TEMP "chocolatey" | Join-Path -ChildPath "$packageName"
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
  $file = Join-Path $tempDir "$($packageName)Install.zip"

  Get-ChocolateyWebFile $packageName $file $fontUrl
  Get-ChocolateyUnzip "$file" $destination $specificFolder $packageName

  $FONTS = 0x14  # magic number
  $shell = New-Object -ComObject Shell.Application
  $fontsFolder = $shell.Namespace($FONTS)

  $fontFiles = Get-ChildItem $destination -Recurse -Filter *.ttf | % { $_.FullName }

  foreach($fontFile in $fontFiles) {
    Write-Debug "installing $($fontFile) to $($fontsFolder)"
    $fontsFolder.CopyHere($fontFile)
  }

  Remove-Item $destination -Recurse

  Write-ChocolateySuccess $packageName
} catch {
  throw $_.Exception
}
