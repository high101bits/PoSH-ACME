Foreach ($Command in $script:CommandsCheckedBoxesSelected) {
    $ExecutionStartTime = Get-Date
    $StatusListBox.Items.Clear()
    $StatusListBox.Items.Add("Query: $($Command.Name)")
    $ResultsListBox.Items.Insert(0,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss')) $($Command.Name)")

    $CollectionName = $Command.ExportFileName
    $script:IndividualHostResults = "$script:CollectedDataTimeStampDirectory\Results By Endpoints"
    New-Item -ItemType Directory -Path "$script:IndividualHostResults\$CollectionName" -Force

    # if the SaveDirectory parameter is provided, it will be used to identify where to save the results to
    if ($SaveDirectory) {
        $CollectionSavedDirectory = $SaveDirectory
    }
    else {
        $CollectionSavedDirectory = "$script:IndividualHostResults\$CollectionName"
    }

    $script:ProgressBarEndpointsProgressBar.Maximum = $script:ComputerList.count


    function MonitorJobScriptBlock {
        param(
            $script:ComputerList,
            $ExecutionStartTime,
            $CollectionName,
            $CollectionSavedDirectory
        )
            # Each command to each target host is executed on it's own process thread, which utilizes more memory overhead on the localhost [running PoSh-EasyWin] and produces many more network connections to targets [noisier on the network].
        Foreach ($TargetComputer in $script:ComputerList) {
            # Checks for the type of command selected and assembles the command to be executed
            $OutputFileFileType = ""
            if ($ComputerListProvideCredentialsCheckBox.Checked) {
                if (!$script:Credential) { Create-NewCredentials }
                Create-LogEntry -LogFile $LogFile -NoTargetComputer -Message "Credentials Used: $($script:Credential.UserName)"




                if ($Command.Type -eq "(WinRM) Script") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -Credential `$script:Credential -ErrorAction Stop"
                    $OutputFileFileType = "csv"
                }
                elseif ($Command.Type -eq "(WinRM) PoSh") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -Credential `$script:Credential -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "csv"
                }
                elseif ($Command.Type -eq "(WinRM) WMI") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -Credential `$script:Credential -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "csv"
                }
                #elseif ($Command.Type -eq "(WinRM) CMD") {
                #    $script:commandstring = $Command.Command
                #    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -Credential `$script:Credential -ErrorAction Stop"
                #    $OutputFileFileType = "txt"
                #}
                #elseif ($Command.Type -eq "(RPC) PoSh") {
                #    $script:commandstring = $Command.Command
                #    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -Credential `$script:Credential -ErrorAction Stop | Select-Object -Property @{n='PSComputerName';e={`$TargetComputer}}, $($Command.Properties)"
                #    $OutputFileFileType = "csv"
                #}
                elseif (($Command.Type -eq "(RPC) WMI") -and ($Command.Command -match "Get-WmiObject")) {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -Credential `$script:Credential -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "csv"
                }
                #elseif (($Command.Type -eq "(RPC) CMD") -and ($Command.Command -match "Invoke-WmiMethod")) {
                #    $script:commandstring = $Command.Command
                #    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -Credential `$script:Credential -ErrorAction Stop"
                #    $OutputFileFileType = "txt"
                #}
                elseif ($Command.Type -eq "(SMB) PoSh") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "txt"

                    $Username = $script:Credential.UserName
                    $Password = $script:Credential.GetNetworkCredential().Password
                    $UseCredential = "-u '$Username' -p '$Password'"
                }
                elseif ($Command.Type -eq "(SMB) WMI") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "txt"

                    $Username = $script:Credential.UserName
                    $Password = $script:Credential.GetNetworkCredential().Password
                    $UseCredential = "-u '$Username' -p '$Password'"
                }
                elseif ($Command.Type -eq "(SMB) CMD") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command)" # NO -ErrorAction Stop, these are cmd native commands
                    $OutputFileFileType = "txt"

                    $Username = $script:Credential.UserName
                    $Password = $script:Credential.GetNetworkCredential().Password
                    $UseCredential = "-u '$Username' -p '$Password'"
                }
                elseif ($Command.Type -eq "(SSH) Linux") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command)"
                    $OutputFileFileType = "txt"

                    $Username = $script:Credential.UserName
                    $Password = $script:Credential.GetNetworkCredential().Password
                }
            }
            # No credentials provided
            else {
                if ($Command.Type -eq "(WinRM) Script") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -ErrorAction Stop"
                    $OutputFileFileType = "csv"
                }
                elseif ($Command.Type -eq "(WinRM) PoSh") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "csv"
                }
                elseif ($Command.Type -eq "(WinRM) WMI") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "csv"
                }
                #elseif ($Command.Type -eq "(WinRM) CMD") {
                #    $script:commandstring = $Command.Command
                #    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -ErrorAction Stop"
                #    $OutputFileFileType = "txt"
                #}
                #elseif ($Command.Type -eq "(RPC) PoSh") {
                #    $script:commandstring = $Command.Command
                #    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -ErrorAction Stop | Select-Object -Property @{n='PSComputerName';e={`$TargetComputer}}, $($Command.Properties)"
                #    $OutputFileFileType = "csv"
                #}
                elseif (($Command.Type -eq "(RPC) WMI") -and ($Command.Command -match "Get-WmiObject")) {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "csv"
                }
                #elseif (($Command.Type -eq "(RPC) CMD") -and ($Command.Command -match "Invoke-WmiMethod")) {
                #    $script:commandstring = $Command.Command
                #    $CommandString = "$($Command.Command) -ComputerName $TargetComputer -ErrorAction Stop"
                #    $OutputFileFileType = "txt"
                #}
                elseif ($Command.Type -eq "(SMB) PoSh") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "txt"
                }
                elseif ($Command.Type -eq "(SMB) WMI") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command) -ErrorAction Stop | Select-Object -Property $($Command.Properties)"
                    $OutputFileFileType = "txt"
                }
                elseif ($Command.Type -eq "(SMB) CMD") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command)" # NO  -ErrorAction Stop, as these are native cmds
                    $OutputFileFileType = "txt"
                }
                elseif ($Command.Type -eq "(SSH) Linux") {
                    $script:commandstring = $Command.Command
                    $CommandString = "$($Command.Command)"
                    $OutputFileFileType = "txt"
                }
            }
            $CommandName = $Command.Name
            $script:CommandType = $Command.Type
            # Sends each query separetly to each computers, which produces a lot of network connections
            # This section is purposefull not using Invoke-Command -AsJob becuase some commands use  RPC/DCOM

                # Checks for the file output type, removes previous results with a file, then executes the commands
                if ( $OutputFileFileType -eq "csv" ) {
                    ## Now saving with Monitor-Jobs with the command Receive-Job
                    ## $OutputFilePath = "$CollectionSavedDirectory\$((($CommandName) -split ' -- ')[1]) - $script:CommandType - $($TargetComputer).csv"
                    ## Remove-Item -Path $OutputFilePath -Force -ErrorAction SilentlyContinue

                    $script:JobsStarted = $true
                    $CompileResults     = $true

                    Start-Job -Name "PoSh-EasyWin: $((($CommandName) -split ' -- ')[1]) - $script:CommandType - $($TargetComputer)" -ScriptBlock {
                        param($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $Credential, $UseCredential, $ComputerListPivotExecutionCheckboxChecked, $ComputerListPivotExecutionTextBoxText)
                        # Available priority values: Low, BelowNormal, Normal, AboveNormal, High, RealTime
                        [System.Threading.Thread]::CurrentThread.Priority = 'High'
                        ([System.Diagnostics.Process]::GetCurrentProcess()).PriorityClass = 'High'

                        if ($ComputerListPivotExecutionCheckboxChecked) {
                            Invoke-Command -ComputerName $ComputerListPivotExecutionTextBoxText -Credential $script:Credential -ScriptBlock { param($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential, $ComputerListPivotExecutionCheckboxChecked) ; Invoke-Expression -Command $CommandString } -ArgumentList @($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential, $ComputerListPivotExecutionCheckboxChecked, $ComputerListPivotExecutionTextBoxText)
                        }
                        else {
                            Invoke-Expression -Command $CommandString
                        }

                    } -InitializationScript $null -ArgumentList @($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential, $script:ComputerListPivotExecutionCheckbox.checked,$script:ComputerListPivotExecutionTextBox.Text)
                }               
                elseif ( $OutputFileFileType -eq "txt" ) {
                    $OutputFilePath = "$CollectionSavedDirectory\$((($CommandName) -split ' -- ')[1]) - $script:CommandType - $($TargetComputer).txt"
                    Remove-Item -Path $OutputFilePath -Force -ErrorAction SilentlyContinue


                    #if ($script:CommandType -eq "(WinRM) CMD") {
                    #    $script:JobsStarted    = $true
                    #    $CompileResults = $true
                    #    Start-Job -Name "PoSh-EasyWin: $((($CommandName) -split ' -- ')[1]) - $script:CommandType - $($TargetComputer)" -ScriptBlock {
                    #        param($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential)
                    #        # Available priority values: Low, BelowNormal, Normal, AboveNormal, High, RealTime
                    #        [System.Threading.Thread]::CurrentThread.Priority = 'High'
                    #        ([System.Diagnostics.Process]::GetCurrentProcess()).PriorityClass = 'High'
                    #
                    #        # This is to catch Invoke-WmiMethod commands because these commands will drop files on the target that we want to retrieve then remove
                    #        Invoke-Expression -Command $CommandString
                    #        Start-Sleep -Seconds 1
                    #        Move-Item   "\\$TargetComputer\c$\results.txt" "$OutputFilePath"
                    #            #Copy-Item   "\\$TargetComputer\c$\results.txt" "$OutputFilePath"
                    #            #Remove-Item "\\$TargetComputer\c$\results.txt"
                    #    } -InitializationScript $null -ArgumentList @($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential)
                    #}
                    if (($script:CommandType -eq "(RPC) WMI") -and ($CommandString -match "Invoke-WmiMethod") ) {
                        $script:JobsStarted    = $true
                        $CompileResults = $true
                        Start-Job -Name "PoSh-EasyWin: $((($CommandName) -split ' -- ')[1]) - $script:CommandType - $($TargetComputer)" -ScriptBlock {
                            param($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential)
                            # Available priority values: Low, BelowNormal, Normal, AboveNormal, High, RealTime
                            [System.Threading.Thread]::CurrentThread.Priority = 'High'
                            ([System.Diagnostics.Process]::GetCurrentProcess()).PriorityClass = 'High'

                            # This is to catch Invoke-WmiMethod commands because these commands will drop files on the target that we want to retrieve then remove
                            Invoke-Expression -Command $CommandString
                            Start-Sleep -Seconds 1
                            Move-Item   "\\$TargetComputer\c$\results.txt" "$OutputFilePath"
                                #Copy-Item   "\\$TargetComputer\c$\results.txt" "$OutputFilePath"
                                #Remove-Item "\\$TargetComputer\c$\results.txt"
                        } -InitializationScript $null -ArgumentList @($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential)
                    }
                    elseif ($script:CommandType -eq "(SMB) PoSh"){
                        $InformationTabControl.SelectedTab = $Section3ResultsTab
                        $PoShEasyWin.Refresh()

                        $script:JobsStarted = $true
                        $CompileResults     = $true

                        $Username = $script:Credential.UserName
                        $Password = $script:Credential.GetNetworkCredential().Password
                        if ($Username -like '*@*'){
                            $User     = $Username.split('@')[0]
                            $Domain   = $Username.split('@')[1]
                            $Username = "$($Domain)\$($User)"
                        }

                        & $PsExecPath "\\$TargetComputer" -AcceptEULA -NoBanner -u $UserName -p $Password powershell "$($Command.Command) | Select-Object * | ConvertTo-Csv -NoType" | ConvertFrom-Csv | Select-Object @{n='ComputerName';e={"$TargetComputer"}},* -ErrorAction SilentlyContinue | Export-CSV "$($script:IndividualHostResults)\$CollectionName\$CollectionName - $($Command.Type) - $TargetComputer.csv" -NoTypeInformation

                        #if ($LASTEXITCODE -eq 0) {Write-Host -f Green "Execution Successful"}
                        #else {Write-Host -f Red "Execution Error"}
                        #note: $($Error[0] | Select-Object -ExpandProperty Exception) does not provide the error from PSExec, rather that of another from within the PowerShell Session

                        # Used later below to log the action
                        $CommandString = "$PsExecPath `"\\$TargetComputer`" -AcceptEULA -NoBanner -u `$UserName -p `$Password powershell `"$($Command.Command) | Select-Object * | ConvertTo-Csv -NoType`""

                        $script:ProgressBarEndpointsProgressBar.Value += 1
                    }
                    elseif ($script:CommandType -eq "(SMB) WMI"){
                        $InformationTabControl.SelectedTab = $Section3ResultsTab
                        $PoShEasyWin.Refresh()

                        $script:JobsStarted = $true
                        $CompileResults     = $true

                        $Username = $script:Credential.UserName
                        $Password = $script:Credential.GetNetworkCredential().Password
                        if ($Username -like '*@*'){
                            $User     = $Username.split('@')[0]
                            $Domain   = $Username.split('@')[1]
                            $Username = "$($Domain)\$($User)"
                        }

                        & $PsExecPath "\\$TargetComputer" -AcceptEULA -NoBanner -u $UserName -p $Password powershell "$($Command.Command) | ConvertTo-Csv -NoType" | ConvertFrom-Csv | Select-Object @{n='ComputerName';e={"$TargetComputer"}},* -ErrorAction SilentlyContinue | Export-CSV "$($script:IndividualHostResults)\$CollectionName\$CollectionName - $($Command.Type) - $TargetComputer.csv" -NoTypeInformation
                        if ($LASTEXITCODE -eq 0) {Write-Host -f Green "Execution Successful"}
                        else {Write-Host -f Red "Execution Error"}
                        #note: $($Error[0] | Select-Object -ExpandProperty Exception) does not provide the error from PSExec, rather that of another from within the PowerShell Session

                        # Used later below to log the action
                        $CommandString = "$PsExecPath `"\\$TargetComputer`" -AcceptEULA -NoBanner -u `$UserName -p `$Password powershell `"$($Command.Command) | Select-Object * | ConvertTo-Csv -NoType`""

                        $script:ProgressBarEndpointsProgressBar.Value += 1
                    }
                    elseif ($script:CommandType -eq "(SMB) CMD"){
                        $InformationTabControl.SelectedTab = $Section3ResultsTab
                        $PoShEasyWin.Refresh()

                        $script:JobsStarted = $true
                        $CompileResults     = $false

                        $Username = $script:Credential.UserName
                        $Password = $script:Credential.GetNetworkCredential().Password
                        if ($Username -like '*@*'){
                            $User     = $Username.split('@')[0]
                            $Domain   = $Username.split('@')[1]
                            $Username = "$($Domain)\$($User)"
                        }
                        "Results not compiled.`n`nResults are stored individually by endpoint in the 'Results By Endpoints' directory." | Out-File "$script:CollectedDataTimeStampDirectory\$CollectionName (View Results By Endpoints).txt"

                        & $PsExecPath "\\$TargetComputer" -AcceptEULA -NoBanner -u $UserName -p $Password cmd /c "$($Command.Command)" | Out-File "$($script:IndividualHostResults)\$CollectionName\$CollectionName - $($Command.Type) - $TargetComputer.txt"
                        if ($LASTEXITCODE -eq 0) {Write-Host -f Green "Execution Successful"}
                        else {Write-Host -f Red "Execution Error"}
                        #note: $($Error[0] | Select-Object -ExpandProperty Exception) does not provide the error from PSExec, rather that of another from within the PowerShell Session

                        # Used later below to log the action
                        $CommandString = "$PsExecPath `"\\$TargetComputer`" -AcceptEULA -NoBanner -u `$UserName -p `$Password cmd /c `"$($Command.Command)"

                        $script:ProgressBarEndpointsProgressBar.Value += 1
                        # This executes native windows cmds with PSExec
                        #Start-Process PowerShell -WindowStyle Hidden -ArgumentList "Start-Process '$PsExecPath' -ArgumentList '-AcceptEULA -NoBanner \\$script:ComputerTreeViewSelected $UseCredential tasklist'" > c:\ressults.txt
                    }
                    elseif ($script:CommandType -eq "(SSH) Linux") {
                        $InformationTabControl.SelectedTab = $Section3ResultsTab
                        $PoShEasyWin.Refresh()

                        $script:JobsStarted = $true
                        $CompileResults     = $false
                        #"Results not compiled, they are stored within the 'Results By Endpoints' directory." | Out-File "$script:CollectedDataTimeStampDirectory\$((($Command.Name) -split ' -- ')[1]) - $($Command.Type).txt"

                        Start-Job -Name "PoSh-EasyWin: $((($CommandName) -split ' -- ')[1]) - $script:CommandType - $($TargetComputer)" -ScriptBlock {
                            param($plink_ssh_client,$TargetComputer,$Username,$Password,$CommandCommand)
                            # Available priority values: Low, BelowNormal, Normal, AboveNormal, High, RealTime
                            [System.Threading.Thread]::CurrentThread.Priority = 'High'
                            ([System.Diagnostics.Process]::GetCurrentProcess()).PriorityClass = 'High'

                            return echo 'y' | & $plink_ssh_client -ssh $TargetComputer -batch -l $Username -pw "$Password" -batch "$CommandCommand"

                        } -InitializationScript $null -ArgumentList @($plink_ssh_client,$TargetComputer,$Username,$Password,$Command.Command)

                        # WORKS, but windows stays open # iex "$kitty_ssh_client -ssh $TargetComputer -l $Username -pw '$Password' -fullscreen -cmd '$($Command.Command)' -log '$($script:IndividualHostResults)\$CollectionName\$CollectionName - $($Command.Type) -2 $TargetComputer.txt'"
                        # WORKS in a serial fashion # & echo "`n`r" | $plink_ssh_client -ssh $TargetComputer -l $Username -pw "$Password" "$($Command.Command)"  | Out-File "$($script:IndividualHostResults)\$CollectionName\$CollectionName - $($Command.Type) - $TargetComputer.txt"
                        
                        $script:ProgressBarEndpointsProgressBar.Value += 1
                    }
                    else {
                        $script:JobsStarted = $true
                        $CompileResults     = $true
                        Start-Job -Name "PoSh-EasyWin: $((($CommandName) -split ' -- ')[1]) - $script:CommandType - $($TargetComputer)" -ScriptBlock {
                            param($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential)
                            # Available priority values: Low, BelowNormal, Normal, AboveNormal, High, RealTime
                            [System.Threading.Thread]::CurrentThread.Priority = 'High'
                            ([System.Diagnostics.Process]::GetCurrentProcess()).PriorityClass = 'High'

                            # Runs all other commands an saves them locally as a .txt file
                            Invoke-Expression -Command $CommandString | Out-File $OutputFilePath -Force
                        } -InitializationScript $null -ArgumentList @($OutputFileFileType, $CollectionSavedDirectory, $CommandName, $script:CommandType, $TargetComputer, $CommandString, $PsExecPath, $script:Credential, $UseCredential)
                    }
                }

            Create-LogEntry -LogFile $LogFile -NoTargetComputer -Message "$(($CommandString).Trim())"
        }
    }
    Invoke-Command -ScriptBlock ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$ExecutionStartTime,$CollectionName,$CollectionSavedDirectory)

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
Command:
===========================================================================
$script:commandstring

"@

    #$script:JobsStarted is used to track if jobs are being used ($true), jobs don't start when using psexec ($false)
    if ( $script:JobsStarted -eq $true ) {
        if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Monitor Jobs') {
            if ( $script:CommandType -eq "(SMB) CMD" ) {
                # This modification to Monitor-Jobs whole purpose is to obtain data from legacy systems that don't support PowerShell Commands and WinRM
                # The -JobsExportFiles $fasle switch prevents the Monitor-Jobs functions from saving the results from PowerShell Jobs
                # This is because PSExec for some reason won't work within PowerShell Jobs, so they are executed with Start-Process rather than Start-Jobs
                # That said, the PSExec commands are currently not monitored, but the Monitor-Jobs function is used to created the buttons to quickly access the data
                # Also various other button settings are set when each Results Pane created
                # The -txt switch ...............
                Monitor-Jobs -CollectionName $CollectionName -MonitorMode -SMITH -SmithScript ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$ExecutionStartTime,$CollectionName,$CollectionSavedDirectory) -InputValues $InputValues -DisableReRun -JobsExportFiles 'false' -txt
            }
            elseif ( $script:CommandType -eq "(SMB) PoSh" -or $script:CommandType -eq "(SMB) WMI" ) {
                # Similar to the above reasoning with -JobExportFiles $false
                # The intent here differs, as this is designed to query systems that support PowerShell commands have SMB available when WinRM and WMI/RPC are NOT
                # Since it uses PSExec, the Monitor-Jobs doesn't need to out results
                Monitor-Jobs -CollectionName $CollectionName -MonitorMode -SMITH -SmithScript ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$ExecutionStartTime,$CollectionName,$CollectionSavedDirectory) -InputValues $InputValues -DisableReRun -JobsExportFiles 'false'
            }
            elseif ($script:CommandType -eq "(SSH) Linux") {
                Monitor-Jobs -CollectionName $CollectionName -MonitorMode -SMITH -SmithScript ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$ExecutionStartTime,$CollectionName,$CollectionSavedDirectory) -InputValues $InputValues -DisableReRun -JobsExportFiles 'true' -txt
            }
            else {
                Monitor-Jobs -CollectionName $CollectionName -MonitorMode -SMITH -SmithScript ${function:MonitorJobScriptBlock} -ArgumentList @($script:ComputerList,$ExecutionStartTime,$CollectionName,$CollectionSavedDirectory) -InputValues $InputValues -DisableReRun -JobsExportFiles 'true'
            }
        }
        elseif ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Individual Execution') {
            Monitor-Jobs -CollectionName $CollectionName
            Post-MonitorJobs -CollectionName $CollectionName -ExecutionStartTime $ExecutionStartTime
        }
    }

    
    # Increments the overall progress bar
    $CompletedCommandQueries++
    $script:ProgressBarQueriesProgressBar.Value = $CompletedCommandQueries

    # This allows the Endpoint progress bar to appear completed momentarily
    $script:ProgressBarEndpointsProgressBar.Maximum = 1
    $script:ProgressBarEndpointsProgressBar.Value = 1
    #Start-Sleep -Milliseconds 250

    $CollectionCommandEndTime  = Get-Date
    $CollectionCommandDiffTime = New-TimeSpan -Start $ExecutionStartTime -End $CollectionCommandEndTime
    $ResultsListBox.Items.RemoveAt(0)
    $ResultsListBox.Items.Insert(0,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss')) [$CollectionCommandDiffTime]  $($Command.Name)")

    
    # Removes any files have are empty
    foreach ($file in (Get-ChildItem $script:CollectedDataTimeStampDirectory)) {
        if ($File.length -eq 0) {
            Remove-Item $File -Force
        }
    }
}

