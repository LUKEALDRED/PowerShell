if ((Get-Service -Name Spooler).Status -eq "Running") {
    Stop-Service -Name Spooler -Force
    Set-Service -Name Spooler -StartupType Disabled
}