# https://github.com/Iristyle/ChocolateyPackages/blob/master/SourceCodePro/tools/chocolateyInstall.ps1
# http://stackoverflow.com/questions/16023238/installing-system-font-with-powershell
#

try {
  $packageName = 'Migu1M'
  $fontUrl = 'http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F59021%2Fmigmix-1m-20130617.zip'
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
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw
}