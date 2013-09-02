# https://github.com/Iristyle/ChocolateyPackages/blob/master/SourceCodePro/tools/chocolateyInstall.ps1
# http://stackoverflow.com/questions/16023238/installing-system-font-with-powershell
#

try {
  $package = 'Migu1M'
  $fontUrl = 'http://sourceforge.jp/projects/mix-mplus-ipa/downloads/59021/migmix-1m-20130617.zip/'
  $destination = Join-Path $Env:Temp $package

  Install-ChocolateyZipPackage -url $fontUrl -unzipLocation $destination

  $FONTS = 0x14  # magic number
  $shell = New-Object -ComObject Shell.Application
  $fontsFolder = $shell.Namespace($FONTS)

  $fontFiles = Get-ChildItem $destination -Recurse -Filter *.ttf

  foreach($fontFile in $fontFiles) {
    $fontsFolder.CopyHere($fontFile)
  }

  Remove-Item $destination -Recurse

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}