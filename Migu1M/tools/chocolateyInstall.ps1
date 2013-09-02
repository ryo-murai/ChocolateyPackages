#function Get-CurrentDirectory
#{
#  $thisName = $MyInvocation.MyCommand.Name
#  [IO.Path]::GetDirectoryName((Get-Content function:$thisName).File)
#}

try {

#  $fontHelpersPath = (Join-Path (Get-CurrentDirectory) 'FontHelpers.ps1')
#   . $fontHelpersPath

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