<#
.DESCRIPTION
Restart three services to allow the agent to be ready again

.NOTES
Filename : Restart_Windows_Azure_Guest_Agent.ps1
Author   : Luke Aldred
Version  : 1.0
Date     : 12/04/2022
Updated  : 

.LINK

 
#>

Restart-Service RdAgent -Force
Restart-Service WindowsAzureGuestAgent -Force
Restart-Service HealthService -Force