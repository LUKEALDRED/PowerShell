<#
.DESCRIPTION
Quick and dirty set of commands that looks for AMIs and EBS Snapshots that contain an instance ID in the name/description. AWS Backup and 3rd party tools such as CPM will include the instance ID in the name/description. This will help find and remove old recovery points, images and snapshots for decommisioned instances.

Requires AWS Tools for PowerShell (https://aws.amazon.com/powershell/) with the AWS.Tools.EC2 and AWS.Tools.Backup modules:

Install-AWSToolsModule AWS.Tools.EC2,AWS.Tools.Backup -CleanUp

.NOTES
Filename : Remove_RecoveryPoints_Images_Snapshots.ps1
Author   : Luke Aldred
Version  : 1.0
Date     : 21/10/2022
Updated  : 

.LINK
 
#>

# Grab all AMIs that contain a specific instance ID
$ec2InstanceImages = Get-EC2Image -Filter @{ Name="name"; Values="*i-a0b1c2d3e4f5g6h7i*"; }

# For each AMI build the recovery point ARN and then then remove the recovery point, some of them might be just AMIs and not recovery points some some might fail to delete
$ec2InstanceImages | ForEach-Object { $recoveryPointARN = "arn:aws:ec2:eu-west-1::image/" + $_.ImageId; Remove-BAKRecoveryPoint -BackupVaultName "Default" -RecoveryPointArn $recoveryPointARN -Confirm }

# Give it 5 seconds for everything to catch up
Start-Sleep -Seconds 5

# Grab all AMIs that contain a specific instance ID again to see what's left
$ec2InstanceImages = Get-EC2Image -Filter @{ Name="name"; Values="*i-a0b1c2d3e4f5g6h7i*"; }

# For each AMI run the unregister command
$ec2InstanceImages | ForEach-Object { Unregister-EC2Image -ImageId $_.ImageId -Confirm }

# Grab all Snapshots that contain a specific instance ID
$ec2InstanceSnapshots = Get-EC2Snapshot -Filter @{ Name="description"; Values="*i-a0b1c2d3e4f5g6h7i*"; }

# For each snapshot run the remove command
$ec2InstanceSnapshots | ForEach-Object { Remove-EC2Snapshot -SnapshotId $_.SnapshotId }