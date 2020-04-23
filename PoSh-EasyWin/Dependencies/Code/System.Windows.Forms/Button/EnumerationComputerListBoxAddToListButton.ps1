$EnumerationComputerListBoxAddToListButtonAdd_Click = {
    $StatusListBox.Items.Clear()
    $StatusListBox.Items.Add("Enumeration:  Added $($EnumerationComputerListBox.SelectedItems.Count) IPs")
    $ResultsListBox.Items.Clear()
    foreach ($Selected in $EnumerationComputerListBox.SelectedItems) {      
        if ($script:ComputerTreeViewData.Name -contains $Selected) {
            Message-HostAlreadyExists -Message "Port Scan Import:  Warning"
        }
        else {
            if ($ComputerTreeNodeOSHostnameRadioButton.Checked) {
                Add-ComputerTreeNode -RootNode $script:TreeNodeComputerList -Category 'Unknown' -Entry $Selected -ToolTip $Computer.IPv4Address
                $ResultsListBox.Items.Add("$($Selected) has been added to the Unknown category")
            }
            elseif ($ComputerTreeNodeOUHostnameRadioButton.Checked) {
                $CanonicalName = $($($Computer.CanonicalName) -replace $Computer.Name,"" -replace $Computer.CanonicalName.split('/')[0],"").TrimEnd("/")
                Add-ComputerTreeNode -RootNode $script:TreeNodeComputerList -Category '/Unknown' -Entry $Selected -ToolTip $Computer.IPv4Address
                $ResultsListBox.Items.Add("$($Selected) has been added to /Unknown category")
            }
            $ComputerTreeNodeAddHostnameIP = New-Object PSObject -Property @{ 
                Name            = $Selected
                OperatingSystem = 'Unknown'
                CanonicalName   = '/Unknown'
                IPv4Address     = $Selected
            }
            $script:ComputerTreeViewData += $ComputerTreeNodeAddHostnameIP
        }
    }
    $script:ComputerTreeView.ExpandAll()
    Populate-ComputerTreeNodeDefaultData
    AutoSave-HostData
}