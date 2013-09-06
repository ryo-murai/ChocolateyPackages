try {
  $packageName = 'jdk.privatejre'
  $verLabel = '1.7.0_25'
  $installDir = "$env:homedrive$env:homepath\dev\java\jdk"

  # target url
  $url32 =   'http://download.oracle.com/otn-pub/java/jdk/7u25-b17/jdk-7u25-windows-i586.exe'
  $url64 = 'http://download.oracle.com/otn-pub/java/jdk/7u25-b17/jdk-7u25-windows-x64.exe'

  $IsSytem32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
    ($Env:PROCESSOR_ARCHITEW6432 -eq $null))

  #$url = if(Get-ProcessorBits 64) { $url64 } else { $url32 }
  $url = if($IsSytem32Bit) { $url32 } else { $url64 }

  # temporary dir to save the installer locally
  $tempDir = Join-Path $env:TEMP "chocolatey" | Join-Path -ChildPath "$packageName"
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
  $file = Join-Path $tempDir "$($packageName)-install.exe"

  # cookie
  $cookie = "gpw_e24=http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html"

  $client = New-Object Net.WebClient
  $client.Headers.Add('Cookie', $cookie)
  $client.DownloadFile($url, $file)

  Write-Debug "downloaded the installer from $url"

  # http://docs.oracle.com/javase/7/docs/webnotes/install/windows/jre-installer-options.html
  # http://docs.oracle.com/javase/7/docs/webnotes/install/windows/jdk-installation-windows.html#Check
  $instOpt = "/s ADDLOCAL=`"ToolsFeature,SourceFeature`" /INSTALLDIR=`"$installDir\jdk$verLabel`""

  Install-ChocolateyInstallPackage $packageName 'exe' $instOpt $file
  
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}