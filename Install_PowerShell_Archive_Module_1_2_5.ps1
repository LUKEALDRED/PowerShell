#Create directory microsoft.powershell.archive
New-Item -Path "C:\Program Files\WindowsPowerShell\Modules\microsoft.powershell.archive" -ItemType Directory

#Change directory into microsoft.powershell.archive
Set-Location "C:\Program Files\WindowsPowerShell\Modules\microsoft.powershell.archive"

#Download files into this directory
Invoke-WebRequest -Uri https://s3.eu-west-1.amazonaws.com/microsoft.powershell.archive/microsoft.powershell.archive/Microsoft.PowerShell.Archive.cat -OutFile Microsoft.PowerShell.Archive.cat
Invoke-WebRequest -Uri https://s3.eu-west-1.amazonaws.com/microsoft.powershell.archive/microsoft.powershell.archive/Microsoft.PowerShell.Archive.psd1 -OutFile Microsoft.PowerShell.Archive.psd1
Invoke-WebRequest -Uri https://s3.eu-west-1.amazonaws.com/microsoft.powershell.archive/microsoft.powershell.archive/Microsoft.PowerShell.Archive.psm1 -OutFile Microsoft.PowerShell.Archive.psm1

#Create en-US directory
New-Item -Path ".\en-US" -ItemType Directory

#Change directory into microsoft.powershell.archive
Set-Location "en-US"

#Download files into this directory
Invoke-WebRequest -Uri https://s3.eu-west-1.amazonaws.com/microsoft.powershell.archive/microsoft.powershell.archive/en-US/ArchiveResources.psd1 -OutFile ArchiveResources.psd1
