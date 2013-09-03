$packageName = 'teraterm' 
$url = 'http://sourceforge.jp/frs/redir.php?m=iij&f=/ttssh2/59442/teraterm-4.79.zip'
$validExitCodes = @(0)

# download and unpack a zip file
Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" "$url64"
