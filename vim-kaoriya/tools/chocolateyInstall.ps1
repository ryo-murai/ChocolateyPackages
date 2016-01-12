$packageName = 'vim-kaoriya'

# 
$url =   "http://files.kaoriya.net/goto/vim74w32"
$url64 = "http://files.kaoriya.net/goto/vim74w64"

Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" "$url64"

iex "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\create-symlink.ps1"
