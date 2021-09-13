function AddHost-ComputerTreeNode {
    if (($ComputerTreeNodePopupAddTextBox.Text -eq "Enter a hostname/IP") -or ($ComputerTreeNodePopupOSComboBox.Text -eq "Select an Operating System (or type in a new one)") -or ($ComputerTreeNodePopupOUComboBox.Text -eq "Select an Organizational Unit / Canonical Name (or type a new one)")) {
        [system.media.systemsounds]::Exclamation.play()
        $StatusListBox.Items.Clear()
        $StatusListBox.Items.Add("Add Hostname/IP:  Error")
        [System.Windows.MessageBox]::Show('Enter a suitable name:
- Cannot be blank
- Cannot already exists
- Cannot be the default value ','Error')
    }
    elseif ($script:ComputerTreeViewData.Name -contains $ComputerTreeNodePopupAddTextBox.Text) {
        Message-NodeAlreadyExists -Endpoint -Message "Add Hostname/IP:  Error" -Computer $ComputerTreeNodePopupAddTextBox.Text
    }
    else {
        $StatusListBox.Items.Clear()
        $StatusListBox.Items.Add("Added Selection:  $($ComputerTreeNodePopupAddTextBox.Text)")

        $ComputerAndAccountTreeViewTabControl.SelectedTab = $ComputerTreeviewTab
        $script:ComputerTreeNodeComboBox.SelectedItem = 'CanonicalName'

        AddTreeNodeTo-TreeViewData -Endpoint -RootNode $script:TreeNodeComputerList -Category $ComputerTreeNodePopupOUComboBox.SelectedItem -Entry $ComputerTreeNodePopupAddTextBox.Text #-ToolTip "No Unique Data Available"

        $ResultsListBox.Items.Clear()
        $ResultsListBox.Items.Add("$($ComputerTreeNodePopupAddTextBox.Text) has been added to $($ComputerTreeNodePopupOUComboBox.Text)")

        $ComputerTreeNodeAddHostnameIP = New-Object PSObject -Property @{
            Name            = $ComputerTreeNodePopupAddTextBox.Text
            OperatingSystem = $ComputerTreeNodePopupOSComboBox.Text
            CanonicalName   = $ComputerTreeNodePopupOUComboBox.Text
            IPv4Address     = "No IP Available"
        }
        $script:ComputerTreeViewData += $ComputerTreeNodeAddHostnameIP
        #$script:ComputerTreeView.ExpandAll()
        $ComputerTreeNodePopup.close()
        Save-TreeViewData -Endpoint
        #UpdateState-TreeViewData -Endpoint -NoMessage
    }
}

