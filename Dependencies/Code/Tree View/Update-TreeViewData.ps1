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

    # Resets the SMB and RPC command count each time
    if ($Commands) {
        $script:RpcCommandCount   = 0
        $script:SmbCommandCount   = 0
        $script:WinRMCommandCount = 0
    }

    # This will return data on hosts selected/highlight, but not necessarily checked
    [System.Windows.Forms.TreeNodeCollection]$AllNodes = $TreeView
    foreach ($root in $AllNodes) {
        $EntryNodeCheckedCountforRoot = 0

        #if ($Commands) { if ($root.Text -match 'Search Results') { $EnsureViisible = $root } }
        #if ($Accounts) { if ($root.Text -match 'All Accounts')  { $EnsureViisible = $root } }
        #if ($Endpoint) { if ($root.Text -match 'All Endpoints')  { $EnsureViisible = $root } }

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
                    if ($Commands) { $script:TreeeViewCommandsCount += 1 }
                    if ($Accounts) { $script:TreeeViewAccountsCount += 1 }
                    if ($Endpoint) { $script:TreeeViewEndpointCount += 1 }
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
                    #$MainLeftTabControl.SelectedTab = $Section1CollectionsTab

                    #    $Category.Expand()
                    if ($Category.Text -match '[\[(]WinRM[)\]]' ) {
                        $script:WinRMCommandCount += 10
                    }
                    if ($Category.Text -match '[\[(]rpc[)\]]' ) {
                        $script:RpcCommandCount += 1
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
                        $script:SmbCommandCount += 1
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
                        if ($Commands) { $script:TreeeViewCommandsCount += 1 }
                        if ($Accounts) { $script:TreeeViewAccountsCount += 1 }
                        if ($Endpoint) { $script:TreeeViewEndpointCount += 1 }

                        if ($Entry.Text -match '[\[(]WinRM[)\]]' ) {
                            $script:WinRMCommandCount += 1
                        }
                        if ($Entry.Text -match '[\[(]rpc[)\]]') {
                            $script:RpcCommandCount += 1
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
                            $script:SmbCommandCount += 1
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

                        $EntryNodeCheckedCountforCategory += 1
                        $EntryNodeCheckedCountforRoot     += 1
                        $Entry.Checked   = $True
                        $Entry.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                        $Entry.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                    }
                    if ($root.text -match 'Custom Group Commands') {
                        $EntryQueryHistoryChecked++
                        $Section1CommandsTab.Controls.Add($CommandsTreeViewCustomGroupCommandsRemovalButton)
                        $CommandsTreeViewCustomGroupCommandsRemovalButton.bringtofront()
                    }
                }
                elseif (!($Category.checked)) {
                    foreach ($Entry in $Category.nodes) {
                        if ($Entry.checked) {
                            # Currently used to support cmdkey /delete:$script:EntryChecked to clear out credentials when using Remote Desktop
                            $script:EntryChecked = $entry.text

                            if ($Entry.Text -match '[\[(]WinRM[)\]]' ) {
                                $script:WinRMCommandCount += 1
                            }
                            if ($Entry.Text -match '[\[(]rpc[)\]]') {
                                $script:RpcCommandCount += 1
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
                                $script:SmbCommandCount += 1
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


                            if ($Commands) { $script:TreeeViewCommandsCount += 1 }
                            if ($Accounts) { $script:TreeeViewAccountsCount += 1 }
                            if ($Endpoint) { $script:TreeeViewEndpointCount += 1 }
                            $EntryNodeCheckedCountforCategory += 1
                            $EntryNodeCheckedCountforRoot     += 1
                            $Entry.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Entry.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                        }
                        elseif (!($Entry.checked)) {
                            if ($CategoryCheck -eq $False) {$Category.Checked = $False}
                            $Entry.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Entry.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
                        }
                    }
                    if ($EntryQueryHistoryChecked -eq 0) {
                        $Section1CommandsTab.Controls.Remove($CommandsTreeViewCustomGroupCommandsRemovalButton)
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
                $EntryNodesWithinCategory += 1

                if ($Endpoint) {
                    if ($Entry.isselected) {
                        $script:rootSelected     = $null
                        $script:CategorySelected = $Category
                        $script:EntrySelected    = $Entry

                        Display-ContextMenuForComputerTreeNode -ClickedOnNode
                        $Section3HostDataIPTextBox.ForeColor        = 'Black'
                        $Section3HostDataMACTextBox.ForeColor       = 'Black'
                        $Section3HostDataNotesRichTextBox.ForeColor = 'Black'

                        $script:HostQueryTreeViewSelected = $Entry.Text

                        if ($root.text -match 'Endpoint Commands') {
                            $Section3QueryExplorationNameTextBox.Text            = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Name
                            $Section3QueryExplorationTagWordsTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Type
                            $Section3QueryExplorationWinRMPoShTextBox.Text       = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_PoSh
                            $Section3QueryExplorationWinRMWMITextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_WMI
                            $Section3QueryExplorationWinRMCmdTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_Cmd
                            $Section3QueryExplorationRPCPoShTextBox.Text         = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_PoSh
                            $Section3QueryExplorationRPCWMITextBox.Text          = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_WMI
                            $Section3QueryExplorationPropertiesPoshTextBox.Text  = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_PoSh
                            $Section3QueryExplorationPropertiesWMITextBox.Text   = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_WMI
                            $Section3QueryExplorationWinRSWmicTextBox.Text       = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_WMIC
                            $Section3QueryExplorationWinRSCmdTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_CMD                       
                            $Section3QueryExplorationSmbPoshTextBox.Text         = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_PoSh
                            $Section3QueryExplorationSmbWmiTextBox.Text          = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_WMI
                            $Section3QueryExplorationSmbCmdTextBox.Text          = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_Cmd
                            $Section3QueryExplorationSshLinuxTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_Linux
                            $Section3QueryExplorationDescriptionRichTextbox.Text = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Description
                        }
                        elseif ($root.text -match 'Active Directory Commands') {
                            $Section3QueryExplorationNameTextBox.Text            = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Name
                            $Section3QueryExplorationTagWordsTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Type
                            $Section3QueryExplorationWinRMPoShTextBox.Text       = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_PoSh
                            $Section3QueryExplorationWinRMWMITextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_WMI
                            $Section3QueryExplorationWinRMCmdTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_Cmd
                            $Section3QueryExplorationRPCPoShTextBox.Text         = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_PoSh
                            $Section3QueryExplorationRPCWMITextBox.Text          = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_WMI
                            $Section3QueryExplorationPropertiesPoshTextBox.Text  = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_PoSh
                            $Section3QueryExplorationPropertiesWMITextBox.Text   = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_WMI
                            $Section3QueryExplorationWinRSWmicTextBox.Text       = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_WMIC
                            $Section3QueryExplorationWinRSCmdTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_CMD
                            $Section3QueryExplorationSmbPoshTextBox.Text         = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_PoSh
                            $Section3QueryExplorationSmbWmiTextBox.Text          = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_WMI
                            $Section3QueryExplorationSmbCmdTextBox.Text          = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_Cmd
                            $Section3QueryExplorationSshLinuxTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_Linux
                            $Section3QueryExplorationDescriptionRichTextbox.Text = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Description
                        }
                        elseif ($root.text -match 'Search Results'){
                            if ($($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Name) {
                                $Section3QueryExplorationNameTextBox.Text            = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Name
                                $Section3QueryExplorationTagWordsTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Type
                                $Section3QueryExplorationWinRMPoShTextBox.Text       = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_PoSh
                                $Section3QueryExplorationWinRMWMITextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_WMI
                                $Section3QueryExplorationWinRMCmdTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_Cmd
                                $Section3QueryExplorationRPCPoShTextBox.Text         = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_PoSh
                                $Section3QueryExplorationRPCWMITextBox.Text          = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_WMI
                                $Section3QueryExplorationPropertiesPoshTextBox.Text  = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_PoSh
                                $Section3QueryExplorationPropertiesWMITextBox.Text   = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_WMI
                                $Section3QueryExplorationWinRSWmicTextBox.Text       = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_WMIC
                                $Section3QueryExplorationWinRSCmdTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_CMD
                                $Section3QueryExplorationSmbPoshTextBox.Text         = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_PoSh
                                $Section3QueryExplorationSmbWmiTextBox.Text          = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_WMI
                                $Section3QueryExplorationSmbCmdTextBox.Text          = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_Cmd
                                $Section3QueryExplorationSshLinuxTextBox.Text        = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_Linux
                                $Section3QueryExplorationDescriptionRichTextbox.Text = $($script:AllEndpointCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Description    
                            }
                            else {
                                $Section3QueryExplorationNameTextBox.Text            = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Name
                                $Section3QueryExplorationTagWordsTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Type
                                $Section3QueryExplorationWinRMPoShTextBox.Text       = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_PoSh
                                $Section3QueryExplorationWinRMWMITextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_WMI
                                $Section3QueryExplorationWinRMCmdTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRM_Cmd
                                $Section3QueryExplorationRPCPoShTextBox.Text         = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_PoSh
                                $Section3QueryExplorationRPCWMITextBox.Text          = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_RPC_WMI
                                $Section3QueryExplorationPropertiesPoshTextBox.Text  = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_PoSh
                                $Section3QueryExplorationPropertiesWMITextBox.Text   = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Properties_WMI
                                $Section3QueryExplorationWinRSWmicTextBox.Text       = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_WMIC
                                $Section3QueryExplorationWinRSCmdTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_WinRS_CMD
                                $Section3QueryExplorationSmbPoshTextBox.Text         = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_PoSh
                                $Section3QueryExplorationSmbWmiTextBox.Text          = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_WMI
                                $Section3QueryExplorationSmbCmdTextBox.Text          = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_SMB_Cmd
                                $Section3QueryExplorationSshLinuxTextBox.Text        = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Command_Linux
                                $Section3QueryExplorationDescriptionRichTextbox.Text = $($script:AllActiveDirectoryCommands | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Description
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

                        foreach ($Entry in $Category.nodes) {
                            if ($entry.checked) {
                                if ($Commands) { $script:TreeeViewCommandsCount += 1 }
                                if ($Accounts) { $script:TreeeViewAccountsCount += 1 }
                                if ($Endpoint) { $script:TreeeViewEndpointCount += 1 }
                                $EntryNodeCheckedCountforCategory += 1
                                $EntryNodeCheckedCountforRoot     += 1
                                $Entry.NodeFont     = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                                $Entry.ForeColor    = [System.Drawing.Color]::FromArgb(0,0,0,224)
                                $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                                $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                                $Root.NodeFont      = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                                $Root.ForeColor     = [System.Drawing.Color]::FromArgb(0,0,0,224)
                            }
                            if (!($entry.checked)) {
                                $Entry.NodeFont     = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                                $Entry.ForeColor    = [System.Drawing.Color]::FromArgb(0,0,0,0)
                            }
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
                            $script:Section3AccountDataNameTextBox.Text             = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Name
                            $Section3AccountDataEnabledTextBox.Text                 = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Enabled
                            $Section3AccountDataOUTextBox.Text                      = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).CanonicalName
                            $Section3AccountDataLockedOutTextBox.Text               = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).LockedOut
                            $Section3AccountDataSmartCardLogonRequiredTextBox.Text  = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).SmartCardLogonRequired
                            $Section3AccountDataCreatedTextBox.Text                 = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Created
                            $Section3AccountDataModifiedTextBox.Text                = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Modified
                            $Section3AccountDataLastLogonDateTextBox.Text           = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).LastLogonDate
                            $Section3AccountDataLastBadPasswordAttemptTextBox.Text  = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).LastBadPasswordAttempt
                            $Section3AccountDataBadLogonCountTextBox.Text           = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).BadLogonCount
                            $Section3AccountDataPasswordExpiredTextBox.Text         = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).PasswordExpired
                            $Section3AccountDataPasswordNeverExpiresTextBox.Text    = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).PasswordNeverExpires
                            $Section3AccountDataPasswordNotRequiredTextBox.Text     = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).PasswordNotRequired
                            $Section3AccountDataMemberOfComboBox.ForeColor          = "Black"
                                $Section3AccountDataMemberOfComboBox.Items.Clear()
                                $script:MemberOfList = $(($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like $_.Name}).MemberOf).split("`n") | Sort-Object
                                ForEach ($Group in $script:MemberOfList) { 
                                    $Section3AccountDataMemberOfComboBox.Items.Add($Group) 
                                }
                            $Section3AccountDataMemberOfComboBox.Text               = "- Select Dropdown [$(if ($script:MemberOfList -ne $null) {$script:MemberOfList.count} else {0})] Groups"
                            $Section3AccountDataSIDTextBox.Text                     = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).SID
                            $Section3AccountDataScriptPathTextBox.Text              = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).ScriptPath
                            $Section3AccountDataHomeDriveTextBox.Text               = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).HomeDrive
                            $script:Section3AccountDataNotesRichTextBox.Text        = $($script:AccountsTreeViewData | Where-Object {$($Entry.Text) -like "*$($_.Name)" }).Notes
                        }
                    }
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
        if ($CustomQueryScriptBlockCheckBox.checked)                    { $script:TreeeViewCommandsCount++ }
        if ($RegistrySearchCheckbox.checked)                            { $script:TreeeViewCommandsCount++ }
        if ($AccountsCurrentlyLoggedInConsoleCheckbox.checked)          { $script:TreeeViewCommandsCount++ }
        if ($AccountsCurrentlyLoggedInPSSessionCheckbox.checked)        { $script:TreeeViewCommandsCount++ }
        if ($AccountActivityCheckbox.checked)                           { $script:TreeeViewCommandsCount++ }
        if ($EventLogsEventIDsManualEntryCheckbox.Checked)              { $script:TreeeViewCommandsCount++ }
        if ($EventLogsEventIDsToMonitorCheckbox.Checked)                { $script:TreeeViewCommandsCount++ }
        if ($EventLogsQuickPickSelectionCheckbox.Checked)               { $script:TreeeViewCommandsCount++ }
        if ($NetworkEndpointPacketCaptureCheckBox.Checked)              { $script:TreeeViewCommandsCount++ }
        if ($NetworkConnectionSearchRemoteIPAddressCheckbox.checked)    { $script:TreeeViewCommandsCount++ }
        if ($NetworkConnectionSearchRemotePortCheckbox.checked)         { $script:TreeeViewCommandsCount++ }
        if ($NetworkConnectionSearchLocalPortCheckbox.checked)          { $script:TreeeViewCommandsCount++ }
        if ($NetworkConnectionSearchProcessCheckbox.checked)            { $script:TreeeViewCommandsCount++ }
        if ($NetworkConnectionSearchDNSCacheCheckbox.checked)           { $script:TreeeViewCommandsCount++ }
        if ($NetworkConnectionSearchCommandLineCheckbox.checked)        { $script:TreeeViewCommandsCount++ }
        if ($NetworkConnectionSearchExecutablePathCheckbox.checked)     { $script:TreeeViewCommandsCount++ }
        if ($FileSearchDirectoryListingCheckbox.Checked)                { $script:TreeeViewCommandsCount++ }
        if ($FileSearchFileSearchCheckbox.Checked)                      { $script:TreeeViewCommandsCount++ }
        if ($FileSearchAlternateDataStreamCheckbox.Checked)             { $script:TreeeViewCommandsCount++ }
        if ($SysinternalsSysmonCheckbox.Checked)                        { $script:TreeeViewCommandsCount++ }
        if ($SysinternalsAutorunsCheckbox.Checked)                      { $script:TreeeViewCommandsCount++ }
        if ($SysinternalsProcessMonitorCheckbox.Checked)                { $script:TreeeViewCommandsCount++ }
        if ($ExeScriptUserSpecifiedExecutableAndScriptCheckbox.checked) { $script:TreeeViewCommandsCount++ }
    }

    # Updates the color of the button if there is at least one query and endpoint selected
    Generate-ComputerList
    if (($script:TreeeViewCommandsCount -gt 0 -or $script:TreeeViewEndpointCount -gt 0) -and $script:ComputerList.count -gt 0) {
        $script:ComputerListExecuteButton.Enabled   = $true
        $script:ComputerListExecuteButton.forecolor = 'Black'
        $script:ComputerListExecuteButton.backcolor = 'lightgreen'
    }
    else {
        $script:ComputerListExecuteButton.Enabled   = $false
        CommonButtonSettings -Button $script:ComputerListExecuteButton
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
        CommonButtonSettings -Button $ActionsTabProcessKillerButton
        CommonButtonSettings -Button $ActionsTabServiceKillerButton
        CommonButtonSettings -Button $ActionsTabAccountLogoutButton
        CommonButtonSettings -Button $ActionsTabSelectNetworkConnectionsToKillButton
        CommonButtonSettings -Button $ActionsTabQuarantineEndpointsButton
    }

    script:Minimize-MonitorJobsTab
    Check-IfScanExecutionReady

}

