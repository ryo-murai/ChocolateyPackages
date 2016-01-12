$target = $(ls "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" -Directory)

if(-not $target) {
  echo "kaoriya-vim is not installed ... do nothing"
  exit
}

echo "we will create a link to $target"

# New-Symlink [-LiteralPath] <String> [-TargetPath] <String> [<CommonParameters>]
New-Symlink ~/tools/vim $target.fullname
