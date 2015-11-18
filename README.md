ChocolateyPackages 
================== 

This repository contains Chocolatey Install Packages for personal use -- namely オレオレリポジトリ

## install packages
```
git clone https://github.com/ryo-murai/ChocolateyPackages
cd <package>
cpack
cinst <package> -source "$PWD"
```

## to create a new package
* see https://github.com/chocolatey/chocolatey/wiki/CreatePackages
* about warmup https://github.com/chocolatey/chocolatey/wiki/CreatePackages#is-there-a-simpler-way-of-creating-packages
