$rgs = Get-AzResourceGroup

$rgs | ForEach-Object -Parallel {

    #Get all Azure VMs which are in running state and are running Windows
    $myAzureVMs = Get-AzVM -ResourceGroupName $_.ResourceGroupName -Status | Where-Object {$_.PowerState -eq "VM running" -and $_.StorageProfile.OSDisk.OSType -eq "Windows"}

    #Run the scirpt again all VMs in parallel
    $myAzureVMs | ForEach-Object -Parallel {
        $out = Invoke-AzVMRunCommand `
            -ResourceGroupName $_.ResourceGroupName `
            -Name $_.Name  `
            -CommandId 'RunPowerShellScript' `
            -ScriptPath .\CheckOSVersion.ps1 
        #Formating the Output with the VM name
        $output = $_.Name + " " + $out.Value[0].Message
        $output   
    }
}