# Query-EventLog -CollectionName $Query.Name -Filter $Query.Filter

$ExecutionStartTime = Get-Date

$StatusListBox.Items.Clear()
$StatusListBox.Items.Add("Executing: Event ID Quick Selection")

$script:ProgressBarEndpointsProgressBar.Value = 0

$EventLogsMaximumCollectionTextBoxText = $script:EventLogsMaximumCollectionTextBox.Text
$EventLogsStartTimePickerChecked       = $script:EventLogsStartTimePicker.Checked
$EventLogsStopTimePickerChecked        = $script:EventLogsStopTimePicker.Checked
$EventLogsStartTimePickerValue         = $script:EventLogsStartTimePicker.Value
$EventLogsStopTimePickerValue          = $script:EventLogsStopTimePicker.Value

function IndividualQuery-EventIdQuickSelection {
    param(
        $Filter,
        $EventLogsMaximumCollectionTextBoxText,
        $EventLogsStartTimePickerChecked,
        $EventLogsStopTimePickerChecked,
        $EventLogsStartTimePickerValue,
        $EventLogsStopTimePickerValue
    )
    # Builds the Event Log Query Command
    $EventLogQueryCommand  = "Get-WmiObject -Class Win32_NTLogEvent"
    if ($EventLogsMaximumCollectionTextBoxText -eq $null -or $EventLogsMaximumCollectionTextBoxText -eq '' -or $EventLogsMaximumCollectionTextBoxText -eq 0) { $EventLogQueryMax = $null}
    else { $EventLogQueryMax = "-First $($EventLogsMaximumCollectionTextBoxText)" }

    if ( $EventLogsStartTimePickerChecked -and $EventLogsStopTimePickerChecked ) {
        $EventLogQueryFilter = @"
-Filter "($Filter and (TimeGenerated>='$([System.Management.ManagementDateTimeConverter]::ToDmtfDateTime(($EventLogsStartTimePickerValue)))') and (TimeGenerated<='$([System.Management.ManagementDateTimeConverter]::ToDmtfDateTime(($EventLogsStopTimePickerValue)))'))"
"@
    }
    else { $EventLogQueryFilter = "-Filter `"$Filter`""}

    $EventLogQueryPipe = @"
| Select-Object PSComputerName, LogFile, EventIdentifier, CategoryString, @{Name='TimeGenerated';Expression={[Management.ManagementDateTimeConverter]::ToDateTime(`$_.TimeGenerated)}}, Message, Type $EventLogQueryMax
"@
    $EventLogQueryBuild = "$EventLogQueryCommand $EventLogQueryFilter $EventLogQueryPipe"
    Invoke-Expression $EventLogQueryBuild
}




function String-InputValues {
    param($InputValue)
    $EndpointString = ''
    foreach ($item in $script:ComputerList) {$EndpointString += "$item`n"}

    $script:InputValues = @"
===========================================================================
Collection Name:
===========================================================================
Event ID Quick Selection

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
Start Time:  [$EventLogsStartTimePickerChecked]
===========================================================================
$EventLogsStartTimePickerValue

===========================================================================
End Time:  [$EventLogsStopTimePickerChecked]
===========================================================================
$EventLogsStopTimePickerValue

===========================================================================
Maximum Logs
===========================================================================
$EventLogsMaximumCollectionTextBoxText

===========================================================================
Event Logs:
===========================================================================
$InputValue

"@
}



if ($EventLogWinRMRadioButton.Checked) {
    foreach ($Query in $script:EventLogQueries) {
        if ($EventLogsQuickPickSelectionCheckedlistbox.CheckedItems -match $Query.Name) {
            $CollectionName = "Event Logs - $($Query.Name)"

            $ResultsListBox.Items.Insert(0,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss'))  $CollectionName")

            Conduct-PreCommandCheck -CollectedDataTimeStampDirectory $script:CollectedDataTimeStampDirectory `
                                    -IndividualHostResults "$script:IndividualHostResults" -CollectionName $CollectionName `
                                    -TargetComputer $TargetComputer
            Create-LogEntry -TargetComputer $TargetComputer  -LogFile $LogFile -Message $CollectionName


            function MonitorJobScriptBlock {
                param(
                    $script:ComputerList,
                    $script:Credential,
                    $ExecutionStartTime,
                    $CollectionName,
                    $EventLogsMaximumCollectionTextBoxText,
                    $EventLogsStartTimePickerChecked,
                    $EventLogsStopTimePickerChecked,
                    $EventLogsStartTimePickerValue,
                    $EventLogsStopTimePickerValue
                )
                foreach ($TargetComputer in $script:ComputerList) {
                    $InvokeCommandSplat = @{
                        ScriptBlock  = ${function:IndividualQuery-EventIdQuickSelection}
                        ArgumentList = @($Query.Filter,$EventLogsMaximumCollectionTextBoxText,$EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue)
                        ComputerName = $TargetComputer
                        AsJob        = $true
                        JobName      = "PoSh-EasyWin: $($CollectionName) -- $($TargetComputer)"
                    }

                    if ($script:ComputerListProvideCredentialsCheckBox.Checked) {
                        if (!$script:Credential) { Set-NewCredential }
                        $InvokeCommandSplat += @{Credential = $script:Credential}
                    }

                    Invoke-Command @InvokeCommandSplat
                }
            }

            $InvokeCommandSplat = @{
                ScriptBlock  = ${function:MonitorJobScriptBlock}
                ArgumentList = @($script:ComputerList,$script:Credential,$ExecutionStartTime,$CollectionName,$EventLogsMaximumCollectionTextBoxText,$EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue)
            }
            Invoke-Command @InvokeCommandSplat


            String-InputValues -InputValue "$($Query.Name)"

            if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Monitor Jobs') {
                Monitor-Jobs -CollectionName $CollectionName -MonitorMode -SMITH -SmithScript ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$script:Credential,$ExecutionStartTime,$CollectionName,$EventLogsMaximumCollectionTextBoxText,$EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue) -DisableReRun -InputValues $script:InputValues
            }
            elseif ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Individual Execution') {
                Monitor-Jobs -CollectionName $CollectionName
                Post-MonitorJobs -CollectionName $CollectionName -CollectionCommandStartTime $ExecutionStartTime
            }
            Update-EndpointNotes
        }
    }
}
else {
    if ( $script:ComputerListProvideCredentialsCheckBox.Checked ) {
        if (!$script:Credential) { Set-NewCredential }

        foreach ($Query in $script:EventLogQueries) {
            if ($EventLogsQuickPickSelectionCheckedlistbox.CheckedItems -match $Query.Name) {
                $CollectionName = "Event Logs - $($Query.Name)"

                $ResultsListBox.Items.Insert(0,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss'))  $CollectionName")

                Conduct-PreCommandCheck -CollectedDataTimeStampDirectory $script:CollectedDataTimeStampDirectory `
                                        -IndividualHostResults "$script:IndividualHostResults" -CollectionName $CollectionName `
                                        -TargetComputer $TargetComputer
                Create-LogEntry -TargetComputer $TargetComputer  -LogFile $LogFile -Message $CollectionName

                function MonitorJobScriptBlock {
                    param(
                        $script:ComputerList,
                        $script:Credential,
                        $ExecutionStartTime,
                        $CollectionName,
                        $EventLogsMaximumCollectionTextBoxText,
                        $EventLogsStartTimePickerChecked,
                        $EventLogsStopTimePickerChecked,
                        $EventLogsStartTimePickerValue,
                        $EventLogsStopTimePickerValue
                    )
                    foreach ($TargetComputer in $script:ComputerList) {
                        Start-Job -ScriptBlock {
                            param(
                                $Filter,
                                $EventLogsMaximumCollectionTextBoxText,
                                $EventLogsStartTimePickerChecked,
                                $EventLogsStopTimePickerChecked,
                                $EventLogsStartTimePickerValue,
                                $EventLogsStopTimePickerValue,
                                $TargetComputer,
                                $script:Credential
                            )
                            # Builds the Event Log Query Command
                            $EventLogQueryCommand  = "Get-WmiObject -Class Win32_NTLogEvent"

                            if ($EventLogsMaximumCollectionTextBoxText -eq $null -or $EventLogsMaximumCollectionTextBoxText -eq '' -or $EventLogsMaximumCollectionTextBoxText -eq 0) { $EventLogQueryMax = $null}
                            else { $EventLogQueryMax = "-First $($EventLogsMaximumCollectionTextBoxText)" }

                            if ( $EventLogsStartTimePickerChecked -and $EventLogsStopTimePickerChecked ) {
                                $EventLogQueryFilter = @"
-Filter "($Filter and (TimeGenerated>='$([System.Management.ManagementDateTimeConverter]::ToDmtfDateTime(($EventLogsStartTimePickerValue)))') and (TimeGenerated<='$([System.Management.ManagementDateTimeConverter]::ToDmtfDateTime(($EventLogsStopTimePickerValue)))'))"
"@
                            }
                            else { $EventLogQueryFilter = "-Filter `"$Filter`""}

                            $EventLogQueryPipe = @"
| Select-Object PSComputerName, LogFile, EventIdentifier, CategoryString, @{Name='TimeGenerated';Expression={[Management.ManagementDateTimeConverter]::ToDateTime(`$_.TimeGenerated)}}, Message, Type $EventLogQueryMax
"@

                            Invoke-Expression -Command "$EventLogQueryCommand -ComputerName $TargetComputer -Credential `$Script:Credential $EventLogQueryFilter $EventLogQueryPipe"
                        } `
                        -Name "PoSh-EasyWin: $($CollectionName) -- $($TargetComputer)" `
                        -ArgumentList $Query.Filter, $EventLogsMaximumCollectionTextBoxText, $EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue,$TargetComputer,$script:Credential
                    }
                }
                Invoke-Command -ScriptBlock ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$script:Credential,$ExecutionStartTime,$CollectionName,$EventLogsMaximumCollectionTextBoxText,$EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue)

                String-InputValues -InputValue "$($Query.Name)"

                if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Monitor Jobs') {
                    Monitor-Jobs -CollectionName $CollectionName -MonitorMode -SMITH -SmithScript ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$script:Credential,$ExecutionStartTime,$CollectionName,$EventLogsMaximumCollectionTextBoxText,$EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue) -InputValues $script:InputValues -DisableReRun
                }
                elseif ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Individual Execution') {
                    Monitor-Jobs -CollectionName $CollectionName
                    Post-MonitorJobs -CollectionName $CollectionName -CollectionCommandStartTime $ExecutionStartTime
                }
                Update-EndpointNotes
            }
        }
    }
    else {
        foreach ($Query in $script:EventLogQueries) {
            if ($EventLogsQuickPickSelectionCheckedlistbox.CheckedItems -match $Query.Name) {
                $CollectionName = "Event Logs - $($Query.Name)"

                $ResultsListBox.Items.Insert(0,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss'))  $CollectionName")

                Conduct-PreCommandCheck -CollectedDataTimeStampDirectory $script:CollectedDataTimeStampDirectory `
                                        -IndividualHostResults "$script:IndividualHostResults" -CollectionName $CollectionName `
                                        -TargetComputer $TargetComputer
                Create-LogEntry -TargetComputer $TargetComputer  -LogFile $LogFile -Message $CollectionName

                function MonitorJobScriptBlock {
                    param(
                        $script:ComputerList,
                        $script:Credential,
                        $ExecutionStartTime,
                        $CollectionName,
                        $EventLogsMaximumCollectionTextBoxText,
                        $EventLogsStartTimePickerChecked,
                        $EventLogsStopTimePickerChecked,
                        $EventLogsStartTimePickerValue,
                        $EventLogsStopTimePickerValue
                    )
                    foreach ($TargetComputer in $script:ComputerList) {
                        Start-Job -ScriptBlock {
                            param(
                                $Filter,
                                $EventLogsMaximumCollectionTextBoxText,
                                $EventLogsStartTimePickerChecked,
                                $EventLogsStopTimePickerChecked,
                                $EventLogsStartTimePickerValue,
                                $EventLogsStopTimePickerValue,
                                $TargetComputer
                            )
                            # Builds the Event Log Query Command
                            $EventLogQueryCommand  = "Get-WmiObject -Class Win32_NTLogEvent"

                            if ($EventLogsMaximumCollectionTextBoxText -eq $null -or $EventLogsMaximumCollectionTextBoxText -eq '' -or $EventLogsMaximumCollectionTextBoxText -eq 0) { $EventLogQueryMax = $null}
                            else { $EventLogQueryMax = "-First $($EventLogsMaximumCollectionTextBoxText)" }

                            if ( $EventLogsStartTimePickerChecked -and $EventLogsStopTimePickerChecked ) {
                                $EventLogQueryFilter = @"
-Filter "($Filter and (TimeGenerated>='$([System.Management.ManagementDateTimeConverter]::ToDmtfDateTime(($EventLogsStartTimePickerValue)))') and (TimeGenerated<='$([System.Management.ManagementDateTimeConverter]::ToDmtfDateTime(($EventLogsStopTimePickerValue)))'))"
"@
                            }
                            else { $EventLogQueryFilter = "-Filter `"$Filter`""}

                            $EventLogQueryPipe = @"
| Select-Object PSComputerName, LogFile, EventIdentifier, CategoryString, @{Name='TimeGenerated';Expression={[Management.ManagementDateTimeConverter]::ToDateTime(`$_.TimeGenerated)}}, Message, Type $EventLogQueryMax
"@

                            Invoke-Expression -Command "$EventLogQueryCommand -ComputerName $TargetComputer $EventLogQueryFilter $EventLogQueryPipe"
                        } `
                        -Name "PoSh-EasyWin: $($CollectionName) -- $($TargetComputer)" `
                        -ArgumentList $Query.Filter, $EventLogsMaximumCollectionTextBoxText, $EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue,$TargetComputer
                    }
                }
                Invoke-Command -ScriptBlock ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$script:Credential,$ExecutionStartTime,$CollectionName,$EventLogsMaximumCollectionTextBoxText,$EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue)

                String-InputValues -InputValue "$($Query.Name)"

                if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Monitor Jobs') {
                    Monitor-Jobs -CollectionName $CollectionName -MonitorMode -SMITH -SmithScript ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$script:Credential,$ExecutionStartTime,$CollectionName,$EventLogsMaximumCollectionTextBoxText,$EventLogsStartTimePickerChecked,$EventLogsStopTimePickerChecked,$EventLogsStartTimePickerValue,$EventLogsStopTimePickerValue) -DisableReRun -InputValues $script:InputValues
                }
                elseif ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Individual Execution') {
                    Monitor-Jobs -CollectionName $CollectionName
                    Post-MonitorJobs -CollectionName $CollectionName -CollectionCommandStartTime $ExecutionStartTime
                }
                Update-EndpointNotes
            }
        }
    }
}
# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUEPG9fgald3S1kYWk6wzGkPjK
# 3CCgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUmVkILRdG8KUVkvVtuZB9vxyc8X4wDQYJKoZI
# hvcNAQEBBQAEggEAbbfJAxgKzcBPqoq839JCXlM16evKNNQeQjD/MQEx9/TsrZs1
# 5+htTzUByCehmlFTopnhuweTJQOEwvxqy8dYZd+VgvP3O4rYN87R5Vkp7pjHB5Q8
# Ek2DAj7HWXZkGRAt2cdBmlx1RdEtnubB7/YGkb17+vpMKyWx5FxwerhIkEfp1eNz
# d+JkMzMW2fmVdfGaiSimIy9LuilUGJYqmmm7j2a7ob+61x+wqrPYjXLDYrkVtgUt
# 5amzP8IpfykGUhZmvmRJ7QNaP+8k4VGWXIolvif/zROvly2UAw9GHeZhWqtRbwmY
# 2+vPRME9UvkXppoMu+09ikDWBppl5MT8rudgWA==
# SIG # End signature block
