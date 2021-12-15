$startuptype = (get-service -Name spooler).StartType
$status = (get-service -Name spooler).Status
if ($startuptype -ne "Automatic")
{
Set-Service -name Spooler -StartupType Automatic
Start-sleep 2
}
if ($status -ne "Running")
{
start-Service -name Spooler
}
$startuptype = (get-service -Name spooler).StartType
if ($startuptype -ne "Automatic")
{
Write-Error -Message "Could not start and Enable Spooler" -Category OperationStopped
}