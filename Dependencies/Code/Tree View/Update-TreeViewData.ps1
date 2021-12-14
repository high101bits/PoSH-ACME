function Update-TreeViewData {
    param(
        $TreeView,
        [switch]$Commands,
        [switch]$Accounts,
        [switch]$Endpoint
    )
    #Previously known as: Conduct-NodeAction

    if ($Commands) {
        $script:TreeeViewCommandsCount = 0 
        $InformationTabControl.SelectedTab = $Section3QueryExplorationTabPage

        # Resets the SMB and RPC command count each time
        $script:RpcCommandCount   = 0
        $script:SmbCommandCount   = 0
        $script:WinRMCommandCount = 0
    }
    elseif ($Accounts) { 
        $script:TreeeViewAccountsCount = 0 
        $InformationTabControl.SelectedTab = $Section3AccountDataTab
    }
    elseif ($Endpoint) { 
        $script:TreeeViewEndpointCount = 0 
        $InformationTabControl.SelectedTab = $Section3HostDataTab
    }
    else {
        $InformationTabControl.SelectedTab = $Section3ResultsTab
    }

    $EntryQueryHistoryChecked = 0

    # This will return data on hosts selected/highlight, but not necessarily checked
    [System.Windows.Forms.TreeNodeCollection]$AllNodes = $TreeView
    foreach ($root in $AllNodes) {
    #     $EntryNodeCheckedCountforRoot = 0

    #     # if ($Commands) { if ($root.Text -match 'Search Results') { $EnsureViisible = $root } }
    #     # if ($Accounts) { if ($root.Text -match 'All Accounts')  { $EnsureViisible = $root } }
    #     # if ($Endpoint) { if ($root.Text -match 'All Endpoints')  { $EnsureViisible = $root } }

        if ($root.Checked) {
            $Root.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
            $Root.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
            #$Root.Expand()
            foreach ($Category in $root.Nodes) {
                #$Category.Expand()
                $Category.checked = $true
                $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                foreach ($Entry in $Category.nodes) {
                    if ($Commands) { $script:TreeeViewCommandsCount++ }
                    if ($Accounts) { $script:TreeeViewAccountsCount++ }
                    if ($Endpoint) { $script:TreeeViewEndpointCount++ }
                    $Entry.Checked   = $True
                    $Entry.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Entry.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                }
            }
        }

        if ($root.isselected) {
            $script:rootSelected     = $root
            $script:CategorySelected = $null
            $script:EntrySelected    = $null

            $script:HostQueryTreeViewSelected              = ""
            $Section3QueryExplorationName.Text             = "N/A"
            $Section3QueryExplorationTypeTextBox.Text      = "N/A"
            $Section3QueryExplorationWinRMPoShTextBox.Text = "N/A"
            $Section3QueryExplorationWinRMWMITextBox.Text  = "N/A"
            $Section3QueryExplorationRPCPoShTextBox.Text   = "N/A"
            $Section3QueryExplorationRPCWMITextBox.Text    = "N/A"
        }

        foreach ($Category in $root.Nodes) {
            $EntryNodeCheckedCountforCategory = 0

            if ($Commands){
                if ($Category.Checked) {
                    #$MainLeftTabControl.SelectedTab = $Section1SearchTab

                    #    $Category.Expand()
                    if ($Category.Text -match '[\[(]WinRM[)\]]' ) {
                        $script:WinRMCommandCount++
                    }
                    if ($Category.Text -match '[\[(]rpc[)\]]' ) {
                        $script:RpcCommandCount++
                        if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Session Based') {
                            [system.media.systemsounds]::Exclamation.play()
                            $StatusListBox.Items.Clear()
                            $StatusListBox.Items.Add("Collection Mode Changed to: Individual Execution")
                            #Removed For Testing#$ResultsListBox.Items.Clear()
                            $ResultsListBox.Items.Add("The collection mode '$($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem)' does not support the RPC and SMB protocols and has been changed to")
                            $ResultsListBox.Items.Add("'Monitor Jobs' which supports RPC, SMB, and WinRM - but may be slower and noisier on the network.")
                            $script:CommandTreeViewQueryMethodSelectionComboBox.SelectedIndex = 0 #'Monitor Jobs'
                            $EventLogRPCRadioButton.checked         = $true
                            $ExternalProgramsRPCRadioButton.checked = $true
                        }
                    }
                    if ($Category.Text -match '[\[(]smb[)\]]' ) {
                        $script:SmbCommandCount++
                        if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Session Based') {
                            # This brings specific tabs to the forefront/front view

                            [system.media.systemsounds]::Exclamation.play()
                            $StatusListBox.Items.Clear()
                            $StatusListBox.Items.Add("Collection Mode Changed to: Individual Execution")
                            #Removed For Testing#$ResultsListBox.Items.Clear()
                            $ResultsListBox.Items.Add("The collection mode '$($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem)' does not support the RPC and SMB protocols and has been changed to")
                            $ResultsListBox.Items.Add("'Monitor Jobs' which supports RPC, SMB, and WinRM - but may be slower and noisier on the network.")
                            $script:CommandTreeViewQueryMethodSelectionComboBox.SelectedIndex = 0 #'Monitor Jobs'
                        }
                    }

                    $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                    $Root.NodeFont      = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Root.ForeColor     = [System.Drawing.Color]::FromArgb(0,0,0,224)

                    foreach ($Entry in $Category.nodes) {
                        if ($Commands) { $script:TreeeViewCommandsCount++ }
                        if ($Accounts) { $script:TreeeViewAccountsCount++ }
                        if ($Endpoint) { $script:TreeeViewEndpointCount++ }

                        if ($Entry.Text -match '[\[(]WinRM[)\]]' ) {
                            $script:WinRMCommandCount++
                        }
                        if ($Entry.Text -match '[\[(]rpc[)\]]') {
                            $script:RpcCommandCount++
                            if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Session Based') {
                                [system.media.systemsounds]::Exclamation.play()
                                $StatusListBox.Items.Clear()
                                $StatusListBox.Items.Add("Collection Mode Changed to: Individual Execution")
                                #Removed For Testing#$ResultsListBox.Items.Clear()
                                $ResultsListBox.Items.Add("The collection mode '$($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem)' does not support the RPC and SMB protocols and has been changed to")
                                $ResultsListBox.Items.Add("'Monitor Jobs' which supports RPC, SMB, and WinRM - but may be slower and noisier on the network.")
                                $script:CommandTreeViewQueryMethodSelectionComboBox.SelectedIndex = 0 #'Monitor Jobs'
                                $EventLogRPCRadioButton.checked         = $true
                                $ExternalProgramsRPCRadioButton.checked = $true
                            }
                        }
                        if ($Entry.Text -match '[\[(]smb[)\]]') {
                            $script:SmbCommandCount++
                            if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Session Based') {
                                [system.media.systemsounds]::Exclamation.play()
                                $StatusListBox.Items.Clear()
                                $StatusListBox.Items.Add("Collection Mode Changed to: Individual Execution")
                                #Removed For Testing#$ResultsListBox.Items.Clear()
                                $ResultsListBox.Items.Add("The collection mode '$($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem)' does not support the RPC and SMB protocols and has been changed to")
                                $ResultsListBox.Items.Add("'Monitor Jobs' which supports RPC, SMB, and WinRM - but may be slower and noisier on the network.")
                                $script:CommandTreeViewQueryMethodSelectionComboBox.SelectedIndex = 0 #'Monitor Jobs'
                            }
                        }

                        $EntryNodeCheckedCountforCategory++
                        $EntryNodeCheckedCountforRoot++
                        $Entry.Checked   = $True
                        $Entry.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                        $Entry.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                    }
                    if ($root.text -match 'Custom Group Commands' -or $root.text -match 'User Added Commands') {
                        $EntryQueryHistoryChecked++
                        $Section1TreeViewCommandsTab.Controls.Add($CommandsTreeViewRemoveCommandButton)
                        $CommandsTreeViewRemoveCommandButton.bringtofront()
                    }
                }
                elseif (!($Category.checked)) {
                    foreach ($Entry in $Category.nodes) {
                        if ($Entry.checked) {
                            # Currently used to support cmdkey /delete:$script:EntryChecked to clear out credentials when using Remote Desktop
                            $script:EntryChecked = $entry.text

                            if ($Entry.Text -match '[\[(]WinRM[)\]]' ) {
                                $script:WinRMCommandCount++
                            }
                            if ($Entry.Text -match '[\[(]rpc[)\]]') {
                                $script:RpcCommandCount++
                                if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Session Based') {
                                    [system.media.systemsounds]::Exclamation.play()
                                    $StatusListBox.Items.Clear()
                                    $StatusListBox.Items.Add("Collection Mode Changed to: Individual Execution")
                                    #Removed For Testing#$ResultsListBox.Items.Clear()
                                    $ResultsListBox.Items.Add("The collection mode '$($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem)' does not support the RPC and SMB protocols and has been changed to")
                                    $ResultsListBox.Items.Add("'Monitor Jobs' which supports RPC, SMB, and WinRM - but may be slower and noisier on the network.")
                                    $script:CommandTreeViewQueryMethodSelectionComboBox.SelectedIndex = 0 #'Monitor Jobs'
                                    $EventLogRPCRadioButton.checked         = $true
                                    $ExternalProgramsRPCRadioButton.checked = $true
                                }
                            }
                            if ($Entry.Text -match '[\[(]smb[)\]]') {
                                $script:SmbCommandCount++
                                if ($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem -eq 'Session Based') {
                                    [system.media.systemsounds]::Exclamation.play()
                                    $StatusListBox.Items.Clear()
                                    $StatusListBox.Items.Add("Collection Mode Changed to: Individual Execution")
                                    #Removed For Testing#$ResultsListBox.Items.Clear()
                                    $ResultsListBox.Items.Add("The collection mode '$($script:CommandTreeViewQueryMethodSelectionComboBox.SelectedItem)' does not support the RPC and SMB protocols and has been changed to")
                                    $ResultsListBox.Items.Add("'Monitor Jobs' which supports RPC, SMB, and WinRM - but may be slower and noisier on the network.")
                                    $script:CommandTreeViewQueryMethodSelectionComboBox.SelectedIndex = 0 #'Monitor Jobs'
                                }
                            }

                            # if ($Commands) { $script:TreeeViewCommandsCount++ }
                            # if ($Accounts) { $script:TreeeViewAccountsCount++ }
                            # if ($Endpoint) { $script:TreeeViewEndpointCount++ }
                            $EntryNodeCheckedCountforCategory++
                            $EntryNodeCheckedCountforRoot++
                            $Entry.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Entry.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                        }
                        elseif (-not $Entry.checked) {
                            if ($CategoryCheck -eq $False) {$Category.Checked = $False}
                            $Entry.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Entry.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
                        }    
                    }
                    if ($EntryQueryHistoryChecked -eq 0) {
                        $Section1TreeViewCommandsTab.Controls.Remove($CommandsTreeViewRemoveCommandButton)
                    }
                }
                if ($Category.isselected) {
                    $script:rootSelected      = $null
                    $script:CategorySelected  = $Category
                    $script:EntrySelected     = $null
        
                    $script:HostQueryTreeViewSelected = ""
                    #$StatusListBox.Items.clear()
                    #$StatusListBox.Items.Add("Category:  $($Category.Text)")
                    ##Removed For Testing#$ResultsListBox.Items.Clear()
                    #$ResultsListBox.Items.Add("- Checkbox This Node to Execute All Commands Within")

                    $Section3QueryExplorationNameTextBox.Text = ''
                    $Section3QueryExplorationName.Text = ''
                    $Section3QueryExplorationTypeTextBox.Text = ''
                    $Section3QueryExplorationWinRMPoShTextBox.Text = ''
                    $Section3QueryExplorationWinRMWMITextBox.Text = ''
                    $Section3QueryExplorationRPCPoShTextBox.Text = ''
                    $Section3QueryExplorationRPCWMITextBox.Text = ''
                    $Section3QueryExplorationWinRMCmdTextBox.Text = ''
                    $Section3QueryExplorationSmbPoshTextBox.Text = ''
                    $Section3QueryExplorationSmbWmiTextBox.Text = ''
                    $Section3QueryExplorationSmbCmdTextBox.Text = ''
                    $Section3QueryExplorationSshLinuxTextBox.Text = ''
                    $Section3QueryExplorationPropertiesPoshTextBox.Text = ''
                    $Section3QueryExplorationPropertiesWMITextBox.Text = ''
                    $Section3QueryExplorationWinRSWmicTextBox.Text = ''
                    $Section3QueryExplorationWinRSCmdTextBox.Text = ''
                    $Section3QueryExplorationTagWordsTextBox.Text = ''
                    $Section3QueryExplorationDescriptionRichTextbox.Text = ''
                }
            }

            foreach ($Entry in $Category.nodes) {
                $EntryNodesWithinCategory++

                if ($Commands) {
                    if ($Entry.isselected) {
                        $script:rootSelected     = $null
                        $script:CategorySelected = $Category
                        $script:EntrySelected    = $Entry

                        if ($root.text -match 'Endpoint Commands') {
                            $NodeCommand = $script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }
                            $Section3QueryExplorationNameTextBox.Text            = $NodeCommand.Name
                            $Section3QueryExplorationTagWordsTextBox.Text        = $NodeCommand.Type
                            $Section3QueryExplorationWinRMPoShTextBox.Text       = $NodeCommand.Command_WinRM_PoSh
                            $Section3QueryExplorationWinRMWMITextBox.Text        = $NodeCommand.Command_WinRM_WMI
                            $Section3QueryExplorationWinRMCmdTextBox.Text        = $NodeCommand.Command_WinRM_Cmd
                            $Section3QueryExplorationRPCPoShTextBox.Text         = $NodeCommand.Command_RPC_PoSh
                            $Section3QueryExplorationRPCWMITextBox.Text          = $NodeCommand.Command_RPC_WMI
                            $Section3QueryExplorationPropertiesPoshTextBox.Text  = $NodeCommand.Properties_PoSh
                            $Section3QueryExplorationPropertiesWMITextBox.Text   = $NodeCommand.Properties_WMI
                            $Section3QueryExplorationWinRSWmicTextBox.Text       = $NodeCommand.Command_WinRS_WMIC
                            $Section3QueryExplorationWinRSCmdTextBox.Text        = $NodeCommand.Command_WinRS_CMD                       
                            $Section3QueryExplorationSmbPoshTextBox.Text         = $NodeCommand.Command_SMB_PoSh
                            $Section3QueryExplorationSmbWmiTextBox.Text          = $NodeCommand.Command_SMB_WMI
                            $Section3QueryExplorationSmbCmdTextBox.Text          = $NodeCommand.Command_SMB_Cmd
                            $Section3QueryExplorationSshLinuxTextBox.Text        = $NodeCommand.Command_Linux
                            $Section3QueryExplorationDescriptionRichTextbox.Text = $NodeCommand.Description
                        }
                        elseif ($root.text -match 'Active Directory Commands') {
                            $NodeCommand = $script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }
                            $Section3QueryExplorationNameTextBox.Text            = $NodeCommand.Name
                            $Section3QueryExplorationTagWordsTextBox.Text        = $NodeCommand.Type
                            $Section3QueryExplorationWinRMPoShTextBox.Text       = $NodeCommand.Command_WinRM_PoSh
                            $Section3QueryExplorationWinRMWMITextBox.Text        = $NodeCommand.Command_WinRM_WMI
                            $Section3QueryExplorationWinRMCmdTextBox.Text        = $NodeCommand.Command_WinRM_Cmd
                            $Section3QueryExplorationRPCPoShTextBox.Text         = $NodeCommand.Command_RPC_PoSh
                            $Section3QueryExplorationRPCWMITextBox.Text          = $NodeCommand.Command_RPC_WMI
                            $Section3QueryExplorationPropertiesPoshTextBox.Text  = $NodeCommand.Properties_PoSh
                            $Section3QueryExplorationPropertiesWMITextBox.Text   = $NodeCommand.Properties_WMI
                            $Section3QueryExplorationWinRSWmicTextBox.Text       = $NodeCommand.Command_WinRS_WMIC
                            $Section3QueryExplorationWinRSCmdTextBox.Text        = $NodeCommand.Command_WinRS_CMD
                            $Section3QueryExplorationSmbPoshTextBox.Text         = $NodeCommand.Command_SMB_PoSh
                            $Section3QueryExplorationSmbWmiTextBox.Text          = $NodeCommand.Command_SMB_WMI
                            $Section3QueryExplorationSmbCmdTextBox.Text          = $NodeCommand.Command_SMB_Cmd
                            $Section3QueryExplorationSshLinuxTextBox.Text        = $NodeCommand.Command_Linux
                            $Section3QueryExplorationDescriptionRichTextbox.Text = $NodeCommand.Description
                        }
                        elseif ($root.text -match 'Search Results'){
                            $NodeCommand = $script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }

                            if ($NodeCommand.Name) {
                                $Section3QueryExplorationNameTextBox.Text            = $NodeCommand.Name
                                $Section3QueryExplorationTagWordsTextBox.Text        = $NodeCommand.Type
                                $Section3QueryExplorationWinRMPoShTextBox.Text       = $NodeCommand.Command_WinRM_PoSh
                                $Section3QueryExplorationWinRMWMITextBox.Text        = $NodeCommand.Command_WinRM_WMI
                                $Section3QueryExplorationWinRMCmdTextBox.Text        = $NodeCommand.Command_WinRM_Cmd
                                $Section3QueryExplorationRPCPoShTextBox.Text         = $NodeCommand.Command_RPC_PoSh
                                $Section3QueryExplorationRPCWMITextBox.Text          = $NodeCommand.Command_RPC_WMI
                                $Section3QueryExplorationPropertiesPoshTextBox.Text  = $NodeCommand.Properties_PoSh
                                $Section3QueryExplorationPropertiesWMITextBox.Text   = $NodeCommand.Properties_WMI
                                $Section3QueryExplorationWinRSWmicTextBox.Text       = $NodeCommand.Command_WinRS_WMIC
                                $Section3QueryExplorationWinRSCmdTextBox.Text        = $NodeCommand.Command_WinRS_CMD
                                $Section3QueryExplorationSmbPoshTextBox.Text         = $NodeCommand.Command_SMB_PoSh
                                $Section3QueryExplorationSmbWmiTextBox.Text          = $NodeCommand.Command_SMB_WMI
                                $Section3QueryExplorationSmbCmdTextBox.Text          = $NodeCommand.Command_SMB_Cmd
                                $Section3QueryExplorationSshLinuxTextBox.Text        = $NodeCommand.Command_Linux
                                $Section3QueryExplorationDescriptionRichTextbox.Text = $NodeCommand.Description    
                            }
                            else {
                                $NodeCommand = $script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }
                                $Section3QueryExplorationNameTextBox.Text            = $NodeCommand.Name
                                $Section3QueryExplorationTagWordsTextBox.Text        = $NodeCommand.Type
                                $Section3QueryExplorationWinRMPoShTextBox.Text       = $NodeCommand.Command_WinRM_PoSh
                                $Section3QueryExplorationWinRMWMITextBox.Text        = $NodeCommand.Command_WinRM_WMI
                                $Section3QueryExplorationWinRMCmdTextBox.Text        = $NodeCommand.Command_WinRM_Cmd
                                $Section3QueryExplorationRPCPoShTextBox.Text         = $NodeCommand.Command_RPC_PoSh
                                $Section3QueryExplorationRPCWMITextBox.Text          = $NodeCommand.Command_RPC_WMI
                                $Section3QueryExplorationPropertiesPoshTextBox.Text  = $NodeCommand.Properties_PoSh
                                $Section3QueryExplorationPropertiesWMITextBox.Text   = $NodeCommand.Properties_WMI
                                $Section3QueryExplorationWinRSWmicTextBox.Text       = $NodeCommand.Command_WinRS_WMIC
                                $Section3QueryExplorationWinRSCmdTextBox.Text        = $NodeCommand.Command_WinRS_CMD
                                $Section3QueryExplorationSmbPoshTextBox.Text         = $NodeCommand.Command_SMB_PoSh
                                $Section3QueryExplorationSmbWmiTextBox.Text          = $NodeCommand.Command_SMB_WMI
                                $Section3QueryExplorationSmbCmdTextBox.Text          = $NodeCommand.Command_SMB_Cmd
                                $Section3QueryExplorationSshLinuxTextBox.Text        = $NodeCommand.Command_Linux
                                $Section3QueryExplorationDescriptionRichTextbox.Text = $NodeCommand.Description
                            }
                        }

                        if ($Category.text -match 'PowerShell Scripts'){
                            # Replaces the edit checkbox and save button with View Script button
                            $Section3QueryExplorationTabPage.Controls.Remove($Section3QueryExplorationEditCheckBox)
                            $Section3QueryExplorationTabPage.Controls.Remove($Section3QueryExplorationSaveButton)
                            $Section3QueryExplorationTabPage.Controls.Add($Section3QueryExplorationViewScriptButton)
                        }
                        else {
                            # Replaces the View Script button with the edit checkbox and save button
                            $Section3QueryExplorationTabPage.Controls.Add($Section3QueryExplorationEditCheckBox)
                            $Section3QueryExplorationTabPage.Controls.Add($Section3QueryExplorationSaveButton)
                            $Section3QueryExplorationTabPage.Controls.Remove($Section3QueryExplorationViewScriptButton)
                        }                      
                    }

                    if ($Entry.checked -and $root.text -match 'User Added Commands') {
                        $EntryQueryHistoryChecked++
                        $Section1TreeViewCommandsTab.Controls.Add($CommandsTreeViewRemoveCommandButton)
                        $CommandsTreeViewRemoveCommandButton.bringtofront()
                    }
                    else { 
                        $EntryQueryHistoryChecked-- 
                    }
                }

                if ($Endpoint) {
                    if ($Entry.isselected) {
                        #$Entry.ImageIndex = 8
                        $script:rootSelected     = $null
                        $script:CategorySelected = $Category
                        $script:EntrySelected    = $Entry

                        Display-ContextMenuForComputerTreeNode -ClickedOnNode

                        $script:HostQueryTreeViewSelected = $Entry.Text

                        if ($root.text -match 'All Endpoints') {
                            $script:NodeEndpoint = $script:ComputerTreeViewData | Where-Object {$_.Name -eq $Entry.Text}
                            
                            $script:Section3EndpointDataIconPictureBox.Image        = [System.Drawing.Image]::FromFile($($EndpointTreeviewImageHashTable["$($script:NodeEndpoint.ImageIndex)"]))
                            $script:Section3HostDataNameTextBox.Text                = $script:NodeEndpoint.Name
                            $Section3HostDataOUTextBox.Text                         = $script:NodeEndpoint.CanonicalName
                            $Section3EndpointDataCreatedTextBox.Text                = $script:NodeEndpoint.Created
                            $Section3EndpointDataModifiedTextBox.Text               = $script:NodeEndpoint.Modified
                            $Section3EndpointDataLastLogonDateTextBox.Text          = $script:NodeEndpoint.LastLogonDate
                            $Section3HostDataIPTextBox.Text                         = $script:NodeEndpoint.IPv4Address
                            $Section3HostDataMACTextBox.Text                        = $script:NodeEndpoint.MACAddress
                            $Section3EndpointDataEnabledTextBox.Text                = $script:NodeEndpoint.Enabled
                            $Section3EndpointDataisCriticalSystemObjectTextBox.Text = $script:NodeEndpoint.isCriticalSystemObject
                            $Section3EndpointDataSIDTextBox.Text                    = $script:NodeEndpoint.SID
                            $Section3EndpointDataOperatingSystemTextBox.Text        = $script:NodeEndpoint.OperatingSystem

                            $Section3EndpointDataOperatingSystemHotfixComboBox.ForeColor = "Black"
                                $Section3EndpointDataOperatingSystemHotfixComboBox.Items.Clear()
                                $OSHotfixList = $null
                                $OSHotfixList = $(($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).OperatingSystemHotfix).split("`n") | Sort-Object
                                ForEach ($Hotfix in $OSHotfixList) { 
                                    $Section3EndpointDataOperatingSystemHotfixComboBox.Items.Add($Hotfix) 
                                }
                            $Section3EndpointDataOperatingSystemHotfixComboBox.Text = "- Select Dropdown [$(if ($OSHotfixList -ne $null) {$OSHotfixList.count} else {0})] OS Hotfixes"

                            $Section3EndpointDataOperatingSystemServicePackComboBox.ForeColor = "Black"
                                $Section3EndpointDataOperatingSystemServicePackComboBox.Items.Clear()
                                $OSServicePackList = $null
                                $OSServicePackList = $(($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).OperatingSystemServicePack).split("`n") | Sort-Object
                                ForEach ($ServicePack in $OSServicePackList) { 
                                    $Section3EndpointDataOperatingSystemServicePackComboBox.Items.Add($ServicePack) 
                                }
                            $Section3EndpointDataOperatingSystemServicePackComboBox.Text = "- Select Dropdown [$(if ($OSServicePackList -ne $null) {$OSServicePackList.count} else {0})] OS Service Packs"

                            $Section3EndpointDataMemberOfComboBox.ForeColor = "Black"
                                $Section3EndpointDataMemberOfComboBox.Items.Clear()
                                $MemberOfList = $null
                                $MemberOfList = $(($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).MemberOf).split("`n") | Sort-Object
                                ForEach ($Group in $MemberOfList) {
                                    $Section3EndpointDataMemberOfComboBox.Items.Add($Group) 
                                }
                            $Section3EndpointDataMemberOfComboBox.Text              = "- Select Dropdown [$(if ($MemberOfList -ne $null) {$MemberOfList.count} else {0})] Groups"
                            $Section3EndpointDataLockedOutTextBox.Text              = $script:NodeEndpoint.LockedOut
                            $Section3EndpointDataLogonCountTextBox.Text             = $script:NodeEndpoint.LogonCount

                            $Section3EndpointDataPortScanComboBox.ForeColor = "Black"
                                $Section3EndpointDataPortScanComboBox.Items.Clear()
                                $PortScanList = $null
                                $PortScanList = $(($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).PortScan).split(",") | Sort-Object
                                ForEach ($Port in $PortScanList) { 
                                    $Section3EndpointDataPortScanComboBox.Items.Add($Port) 
                                }
                            $Section3EndpointDataPortScanComboBox.Text              = " $(if ($PortScanList -ne $null) {$PortScanList.count} else {0}) Ports"

                            $Section3HostDataSelectionComboBox.Text                 = "Host Data - Selection"
                            $Section3HostDataSelectionDateTimeComboBox.Text         = "Host Data - Date & Time"

                            $script:Section3HostDataNotesSaveCheck = $Section3HostDataNotesRichTextBox.Text = $script:NodeEndpoint.Notes
                        }
                    }
                }
                if ($Accounts) {
                    if ($Entry.isselected) {
                        $script:rootSelected      = $null
                        $script:CategorySelected  = $Category
                        $script:EntrySelected     = $Entry

                        Display-ContextMenuForAccountsTreeNode -ClickedOnNode
                        $script:Section3AccountDataNotesRichTextBox.ForeColor = 'Black'

                        # $script:HostQueryTreeViewSelected = $Entry.Text

                        if ($root.text -match 'All Accounts') {
                            $script:NodeAccount = $script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }

                            $script:Section3AccountDataIconPictureBox.Image         = [System.Drawing.Image]::FromFile($($AccountsTreeviewImageHashTable["$($script:NodeAccount.ImageIndex)"]))
                            $script:Section3AccountDataNameTextBox.Text             = $script:NodeAccount.Name
                            $Section3AccountDataEnabledTextBox.Text                 = $script:NodeAccount.Enabled
                            $Section3AccountDataOUTextBox.Text                      = $script:NodeAccount.CanonicalName
                            $Section3AccountDataLockedOutTextBox.Text               = $script:NodeAccount.LockedOut
                            $Section3AccountDataSmartCardLogonRequiredTextBox.Text  = $script:NodeAccount.SmartCardLogonRequired
                            $Section3AccountDataCreatedTextBox.Text                 = $script:NodeAccount.Created
                            $Section3AccountDataModifiedTextBox.Text                = $script:NodeAccount.Modified
                            $Section3AccountDataLastLogonDateTextBox.Text           = $script:NodeAccount.LastLogonDate
                            $Section3AccountDataLastBadPasswordAttemptTextBox.Text  = $script:NodeAccount.LastBadPasswordAttempt
                            $Section3AccountDataBadLogonCountTextBox.Text           = $script:NodeAccount.BadLogonCount
                            $Section3AccountDataPasswordExpiredTextBox.Text         = $script:NodeAccount.PasswordExpired
                            $Section3AccountDataPasswordNeverExpiresTextBox.Text    = $script:NodeAccount.PasswordNeverExpires
                            $Section3AccountDataPasswordNotRequiredTextBox.Text     = $script:NodeAccount.PasswordNotRequired
                            $Section3AccountDataMemberOfComboBox.ForeColor          = "Black"
                                $Section3AccountDataMemberOfComboBox.Items.Clear()
                                $MemberOfList = $null
                                $MemberOfList = $(($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like $_.Name}).MemberOf).split("`n") | Sort-Object
                                ForEach ($Group in $MemberOfList) { 
                                    $Section3AccountDataMemberOfComboBox.Items.Add($Group) 
                                }
                            $Section3AccountDataMemberOfComboBox.Text               = "- Select Dropdown [$(if ($MemberOfList -ne $null) {$MemberOfList.count} else {0})] Groups"
                            $Section3AccountDataSIDTextBox.Text                     = $script:NodeAccount.SID
                            $Section3AccountDataScriptPathTextBox.Text              = $script:NodeAccount.ScriptPath
                            $Section3AccountDataHomeDriveTextBox.Text               = $script:NodeAccount.HomeDrive
                            $script:Section3AccountDataNotesRichTextBox.Text        = $script:NodeAccount.Notes
                        }
                    }
                }

                if ($entry.checked) {
                    if ($Commands) { $script:TreeeViewCommandsCount++ }
                    if ($Accounts) { $script:TreeeViewAccountsCount++ }
                    if ($Endpoint) { $script:TreeeViewEndpointCount++ }
                    $EntryNodeCheckedCountforCategory++
                    $EntryNodeCheckedCountforRoot++
                    $Entry.NodeFont     = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Entry.ForeColor    = [System.Drawing.Color]::FromArgb(0,0,0,224)
                    $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                    $Root.NodeFont      = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Root.ForeColor     = [System.Drawing.Color]::FromArgb(0,0,0,224)
                }
                if (-not $entry.checked) {
                    $Entry.NodeFont     = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Entry.ForeColor    = [System.Drawing.Color]::FromArgb(0,0,0,0)
                }
            }
            if ($EntryNodeCheckedCountforCategory -gt 0) {
                $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
            }
            else {
                $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
            }
            if ($EntryNodeCheckedCountforRoot -gt 0) {
                $Root.NodeFont      = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                $Root.ForeColor     = [System.Drawing.Color]::FromArgb(0,0,0,224)
            }
            else {
                $Root.NodeFont      = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                $Root.ForeColor     = [System.Drawing.Color]::FromArgb(0,0,0,0)
          }
        }
    }
    #$EnsureViisible.EnsureVisible()


    # Note: If adding new checkboxes to other areas, make sure also add it to the script handler
    if ($Commands) {
        # Removes prevous query count from overall count, needed to maintain accurate count
        $script:SectionQueryCount -= $script:PreviousQueryCount
        $SectionQueryTempCount = 0
        # Counts queries checked
        [System.Windows.Forms.TreeNodeCollection]$AllNodes = $TreeView
        foreach ($root in $AllNodes) {
            foreach ($Category in $root.Nodes) {
                foreach ($Entry in $Category.nodes) {
                    if ($Entry.checked) {
                        $SectionQueryTempCount += 1
                    }
                }
            }
        }
        # Tracks previous count and tallies up new query total
        $script:PreviousQueryCount = $SectionQueryTempCount
        $script:SectionQueryCount += $script:PreviousQueryCount


        # List of all checkboxes - used to check if they're checkboxed and managing their color and checked state 
        $script:AllCheckBoxesList = @(
            $CustomQueryScriptBlockCheckBox,

            $AccountsCurrentlyLoggedInConsoleCheckbox,
            $AccountsCurrentlyLoggedInPSSessionCheckbox,
            $AccountActivityCheckbox,

            $EventLogsEventIDsManualEntryCheckbox,
            $EventLogsQuickPickSelectionCheckbox,
            $EventLogNameEVTXLogNameSelectionCheckbox,

            $FileSearchFileSearchCheckbox,            
            $FileSearchDirectoryListingCheckbox,
            $FileSearchAlternateDataStreamCheckbox,

            $ProcessLiveSearchNameCheckbox,
            $ProcessLiveSearchCommandlineCheckbox,
            $ProcessLiveSearchParentNameCheckbox,
            $ProcessLiveSearchOwnerSIDCheckbox,
            $ProcessLiveSearchServiceInfoCheckbox,
            $ProcessLiveSearchNetworkConnectionsCheckbox,
            $ProcessLiveSearchHashesSignerCertsCheckbox,
            $ProcessLiveSearchCompanyProductCheckbox,

            $ProcessSysmonSearchFilePathCheckbox,
            $ProcessSysmonSearchCommandlineCheckbox,
            $ProcessSysmonSearchParentFilePathCheckbox,
            $ProcessSysmonSearchParentCommandlineCheckbox,
            $ProcessSysmonSearchRuleNameCheckbox,
            $ProcessSysmonSearchUserAccountIdCheckbox,
            $ProcessSysmonSearchHashesCheckbox,
            $ProcessSysmonSearchCompanyProductCheckbox,

            $NetworkEndpointPacketCaptureCheckBox,

            $NetworkLiveSearchRemoteIPAddressCheckbox,
            $NetworkLiveSearchRemotePortCheckbox,
            $NetworkLiveSearchLocalPortCheckbox,
            $NetworkLiveSearchCommandLineCheckbox
            $NetworkLiveSearchExecutablePathCheckbox,
            $NetworkLiveSearchProcessCheckbox,
            $NetworkLiveSearchDNSCacheCheckbox,

            $NetworkSysmonSearchSourceIPAddressCheckbox,
            $NetworkSysmonSearchSourcePortCheckbox,
            $NetworkSysmonSearchDestinationIPAddressCheckbox,
            $NetworkSysmonSearchDestinationPortCheckbox,
            $NetworkSysmonSearchAccountCheckbox,
            $NetworkSysmonSearchExecutablePathCheckbox,

            $ExeScriptUserSpecifiedExecutableAndScriptCheckbox,

            $SysinternalsSysmonCheckbox,
            $SysinternalsProcessMonitorCheckbox,

            $RegistrySearchCheckbox
        )
        
        foreach ($CheckBox in $script:AllCheckBoxesList) {
            if ($CheckBox.checked -eq $true) { $script:TreeeViewCommandsCount++ }
        }
    }

    # Updates the color of the button if there is at least one query and endpoint selected
    if ($script:TreeeViewCommandsCount -gt 0 -and $script:TreeeViewEndpointCount -gt 0) {
        $script:ComputerListExecuteButton.Enabled   = $true
        $script:ComputerListExecuteButton.forecolor = 'Black'
        $script:ComputerListExecuteButton.backcolor = 'lightgreen'
    }
    else {
        $script:ComputerListExecuteButton.Enabled   = $false
        Apply-CommonButtonSettings -Button $script:ComputerListExecuteButton
    }
    $StatisticsRefreshButton.PerformClick()

    # Updates the color of the button if there is at least one endpoint selected
    if ($script:TreeeViewEndpointCount -gt 0) {
        $ActionsTabProcessKillerButton.forecolor = 'Black'
        $ActionsTabProcessKillerButton.backcolor = 'lightgreen'

        $ActionsTabServiceKillerButton.forecolor = 'Black'
        $ActionsTabServiceKillerButton.backcolor = 'lightgreen'

        $ActionsTabAccountLogoutButton.forecolor = 'Black'
        $ActionsTabAccountLogoutButton.backcolor = 'lightgreen'

        $ActionsTabSelectNetworkConnectionsToKillButton.forecolor = 'Black'
        $ActionsTabSelectNetworkConnectionsToKillButton.backcolor = 'lightgreen'

        $ActionsTabQuarantineEndpointsButton.forecolor = 'Black'
        $ActionsTabQuarantineEndpointsButton.backcolor = 'lightgreen'
    }
    else {
        Apply-CommonButtonSettings -Button $ActionsTabProcessKillerButton
        Apply-CommonButtonSettings -Button $ActionsTabServiceKillerButton
        Apply-CommonButtonSettings -Button $ActionsTabAccountLogoutButton
        Apply-CommonButtonSettings -Button $ActionsTabSelectNetworkConnectionsToKillButton
        Apply-CommonButtonSettings -Button $ActionsTabQuarantineEndpointsButton
    }

    script:Minimize-MonitorJobsTab
    Check-IfScanExecutionReady
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUH86cwG7swmu8mWH+V8CQFI2d
# jm2gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQU0xYBOhfSXoFRuApkfMD23E4aiVAwDQYJKoZI
# hvcNAQEBBQAEggEATH9Hx+Lgpmaud5L04KJRPdN4q/M+MsBCZkBLfHB7SF7H6CA6
# 6s3e9xKeXFruYTQcg6rJ2FsyZI6xaAwf1Q8RmjfmKDSaO68hTzLwfPMZd7nk24S9
# fFt/fEFClS54ymhru/ibwBAWoq5tqaJItDAsXcoAXi9mX03yuEX8epRhOdBSguuC
# BrwH3eZx/oo1djQjce9mgxePUFjr/uY914tWqYbIZ09avOava05lnH9FkQo96m58
# Gi+vaQuFE3+v+h40xXwfDUHplD5VZNCCrcoVLT76CnyyQMwErUf1UP2irWQcjdvA
# US9FBVlz15G7Hs4YiTz8Uo2YbXghEmqle7Uezg==
# SIG # End signature block
