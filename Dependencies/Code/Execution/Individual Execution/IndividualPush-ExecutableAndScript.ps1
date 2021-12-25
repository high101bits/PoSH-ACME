$CollectionName = "Executable and Script"
$ExecutionStartTime = Get-Date
$StatusListBox.Items.Clear()
$StatusListBox.Items.Add("Executing: $CollectionName")
$ResultsListBox.Items.Insert(1,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss'))  $CollectionName")
$PoShEasyWin.Refresh()

$script:ProgressBarEndpointsProgressBar.Value = 0

$TargetFolder                 = $script:ExeScriptDestinationDirectoryTextBox.text
$ExeScriptSelectDirOrFilePath = $script:ExeScriptSelectDirOrFilePath
$ExeScriptSelectScriptPath    = $script:ExeScriptSelectScriptPath

foreach ($TargetComputer in $script:ComputerList) {

    if ($ComputerListProvideCredentialsCheckBox.Checked) {
        if (!$script:Credential) { $script:Credential = Get-Credential }
    }

    Start-Job -ScriptBlock {
        param(
            $ComputerListProvideCredentialsCheckBox,
            $ExeScriptSelectScriptPath,
            $ExeScriptScriptOnlyCheckbox,
            $ExeScriptSelectDirRadioButton,
            $ExeScriptSelectFileRadioButton,
            $ExeScriptSelectDirOrFilePath,
            $TargetComputer,
            $TargetFolder,
            $script:Credential
        )

        if ($ComputerListProvideCredentialsCheckBox.Checked) {
            $Session = New-PSSession -ComputerName $TargetComputer -Credential $script:Credential
        }
        else {
            $Session = New-PSSession -ComputerName $TargetComputer
        }

        Copy-Item -Path $ExeScriptSelectDirOrFilePath -Destination $TargetFolder -ToSession $Session -Force -ErrorAction Stop

        Start-Sleep -Seconds 3

        if ($ExeScriptScriptOnlyCheckbox.checked -eq $false) {
            if ($ExeScriptSelectDirRadioButton.checked -eq $true) {
                Copy-Item -Path $ExeScriptSelectDirOrFilePath -Destination $TargetFolder -ToSession $Session -Recurse -Force -ErrorAction Stop
            }
            elseif ($ExeScriptSelectFileRadioButton.checked -eq $true) {
                Copy-Item -Path $ExeScriptSelectDirOrFilePath -Destination $TargetFolder -ToSession $Session -Force -ErrorAction Stop
            }
        }

        Invoke-Command -FilePath $ExeScriptSelectScriptPath -Session $Session

        $Session | Remove-PSSession
    } `
    -ArgumentList @($ComputerListProvideCredentialsCheckBox,$ExeScriptSelectScriptPath,$ExeScriptScriptOnlyCheckbox,$ExeScriptSelectDirRadioButton,$ExeScriptSelectFileRadioButton,$ExeScriptSelectDirOrFilePath,$TargetComputer,$TargetFolder,$script:Credential) `
    -Name "PoSh-EasyWin: $($CollectionName) -- $($TargetComputer)"
}

$EndpointString = ''
foreach ($item in $script:ComputerList) {$EndpointString += "$item`n"}

$InputValues = @"
===========================================================================
Collection Name:
===========================================================================
$CollectionName

===========================================================================
Execution Time:
===========================================================================
$ExecutionStartTime

===========================================================================
Credentials:
===========================================================================
$($script:Credential.UserName)

===========================================================================
Endpoints:
===========================================================================
$($EndpointString.trim())

===========================================================================
Target Folder:
===========================================================================
$TargetFolder

===========================================================================
Directory / File Path
===========================================================================
$ExeScriptSelectDirOrFilePath

===========================================================================
Script Path:
===========================================================================
$ExeScriptSelectScriptPath

"@

if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Monitor Jobs') {
    Monitor-Jobs -CollectionName $CollectionName -MonitorMode -ExecutableAndScriptSwitch -ExecutableAndScriptPath "$TargetFolder" -ComputerName $script:ComputerList -DisableReRun -InputValues $InputValues -NotExportFiles
}
elseif ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Individual Execution') {
    Monitor-Jobs -CollectionName $CollectionName
    Post-MonitorJobs -CollectionName $CollectionName -CollectionCommandStartTime $ExecutionStartTime
}


$ResultsListBox.Items.RemoveAt(1)
$ResultsListBox.Items.Insert(1,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss'))  [$(New-TimeSpan -Start $ExecutionStartTime -End (Get-Date))]  $CollectionName")
$PoShEasyWin.Refresh()

$script:ProgressBarQueriesProgressBar.Value += 1
$PoShEasyWin.Refresh()
Start-Sleep -match 500

Update-EndpointNotes


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUBte3jop7nT0A3ow8tnkMBAtj
# 3xqgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
# AQUFADAzMTEwLwYDVQQDDChQb1NoLUVhc3lXaW4gQnkgRGFuIEtvbW5pY2sgKGhp
# Z2gxMDFicm8pMB4XDTIxMTIxNDA1MDIwMFoXDTMxMTIxNDA1MTIwMFowMzExMC8G
# A1UEAwwoUG9TaC1FYXN5V2luIEJ5IERhbiBLb21uaWNrIChoaWdoMTAxYnJvKTCC
# ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALvIxUDFEVGB/G0FXPryoNlF
# dA65j5jPEFM2R4468rjlTVsNYUOR+XvhjmhpggSQa6SzvXtklUJIJ6LgVUpt/0C1
# zlr1pRwTvsd3svI7FHTbJahijICjCv8u+bFcAR2hH3oHFZTqvzWD1yG9FGCw2pq3
# h4ahxtYBd1+/n+jOtPUoMzcKIOXCUe4Cay+xP8k0/OLIVvKYRlMY4B9hvTW2CK7N
# fPnvFpNFeGgZKPRLESlaWncbtEBkexmnWuferJsRtjqC75uNYuTimLDSXvNps3dJ
# wkIvKS1NcxfTqQArX3Sg5qKX+ZR21uugKXLUyMqXmVo2VEyYJLAAAITEBDM8ngUC
# AwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0G
# A1UdDgQWBBSDJIlo6BcZ7KJAW5hoB/aaTLxFzTANBgkqhkiG9w0BAQUFAAOCAQEA
# ouCzal7zPn9vc/C9uq7IDNb1oNbWbVlGJELLQQYdfBE9NWmXi7RfYNd8mdCLt9kF
# CBP/ZjHKianHeZiYay1Tj+4H541iUN9bPZ/EaEIup8nTzPbJcmDbaAGaFt2PFG4U
# 3YwiiFgxFlyGzrp//sVnOdtEtiOsS7uK9NexZ3eEQfb/Cd9HRikeUG8ZR5VoQ/kH
# 2t2+tYoCP4HsyOkEeSQbnxlO9s1jlSNvqv4aygv0L6l7zufiKcuG7q4xv/5OvZ+d
# TcY0W3MVlrrNp1T2wxzl3Q6DgI+zuaaA1w4ZGHyxP8PLr6lMi6hIugI1BSYVfk8h
# 7KAaul5m+zUTDBUyNd91ojGCAegwggHkAgEBMEcwMzExMC8GA1UEAwwoUG9TaC1F
# YXN5V2luIEJ5IERhbiBLb21uaWNrIChoaWdoMTAxYnJvKQIQeugH5LewQKBKT6dP
# XhQ7sDAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkq
# hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGC
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUmQXDoQsD5nL20OECeEcKMh97XQIwDQYJKoZI
# hvcNAQEBBQAEggEACXsXjD9V/LkkOVFQY0rN7qnaGOqC1H4zIVFWGPpqvo1MGyga
# ztT8S+aZ18N3Z3qFywcAoCgbpq6HyyVTaQKPNsWdvHZpeBklrRPBRBYkSL4qvwyN
# fkUqqxT7RJSUDgGmLrUH1zDXJ5JC7DZDvcUomTE97n2dIMQ+l5zCOy86GBSTQLSb
# MlZpCZqsTqpZ1V5CICtWhdYovJKzlMXl6CegE2IrnCdw/qngH2YnFx4hFQM6Ml6T
# bQbyYHckiq8IZ7ea4sF31pdXXmHdhh8DkBINdV2HUT+8aNqgcqGx7y9SxWD88yUv
# Ig1QKbw7hnj9U5WdYfRA8cG7W8jBFyet9VKSEA==
# SIG # End signature block
