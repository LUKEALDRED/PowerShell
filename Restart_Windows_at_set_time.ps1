################################
#                              #
# Reboot Windows at a set time #
# Luke Aldred                  #
# v1.0.0                       #
# 15/12/2021                   #
#                              #
################################

# Prompt the user for a reboot date/time
$whenToRebootString = Read-Host -Prompt "Enter reboot date and time (dd/mm/yyyy hh:mm)"

# Convert that response to a date/time format that PowerShell can work with
$whenToRebootTime = Get-Date $whenToRebootString

# Get the date/time for right now
$now = Get-Date

# Calculate the difference between the provided reboot time and now
$difference = $whenToRebootTime - $now

# Grab the amount of seconds between then and now
$secondsTilReboot = $seconds = [math]::Round($difference.TotalSeconds) + 1

# Set the computer to restart in that many seconds
.\shutdown.exe /r /t $secondsTilReboot