$ImportEndpointDataFromCsvButtonAdd_Click = {
    $ComputerAndAccountTreeViewTabControl.SelectedTab = $ComputerTreeviewTab
    $InformationTabControl.SelectedTab = $Section3ResultsTab

    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $ComputerTreeNodeImportCsvOpenFileDialog                  = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Title            = "Import .csv Data"
        InitialDirectory = "$PoShHome"
        filter           = "CSV (*.csv)| *.csv|Excel (*.xlsx)| *.xlsx|Excel (*.xls)| *.xls|All files (*.*)|*.*"
        ShowHelp         = $true
    }
    $ComputerTreeNodeImportCsvOpenFileDialog.ShowDialog() | Out-Null
    $ComputerTreeNodeImportCsv = Import-Csv $($ComputerTreeNodeImportCsvOpenFileDialog.filename) | Select-Object -Property Name, IPv4Address, MACAddress, OperatingSystem, CanonicalName | Sort-Object -Property CanonicalName

    $StatusListBox.Items.Clear()
    #Removed For Testing#
    $ResultsListBox.Items.Clear()

    # Imports data
    foreach ($Computer in $ComputerTreeNodeImportCsv) {
        # Checks if data already exists
        if ($script:ComputerTreeViewData.Name -contains $Computer.Name) {
            Message-NodeAlreadyExists -Endpoint -Message "Import .CSV:  Warning" -Computer $Computer.Name -ResultsListBoxMessage
        }
        else {
            $ComputerAndAccountTreeViewTabControl.SelectedTab = $ComputerTreeviewTab
            $script:ComputerTreeNodeComboBox.SelectedItem = 'CanonicalName'

            $CanonicalName = $($($Computer.CanonicalName) -replace $Computer.Name,"" -replace $Computer.CanonicalName.split('/')[0],"").TrimEnd("/")
            if ($Computer.CanonicalName -eq "") { AddTreeNodeTo-TreeViewData -Endpoint -RootNode $script:TreeNodeComputerList -Category '/Unknown' -Entry $Computer.Name -ToolTip 'No ToolTip Data' -IPv4Address $Computer.IPv4Address }
            else { AddTreeNodeTo-TreeViewData -Endpoint -RootNode $script:TreeNodeComputerList -Category $CanonicalName -Entry $Computer.Name -ToolTip 'No ToolTip Data' -IPv4Address $Computer.IPv4Address }

            $script:ComputerTreeViewData += $Computer

            $script:ComputerTreeView.Nodes.Clear()
            Initialize-TreeViewData -Endpoint
            UpdateState-TreeViewData -Endpoint -NoMessage
            Normalize-TreeViewData -Endpoint
            Foreach($Computer in $script:ComputerTreeViewData) { AddTreeNodeTo-TreeViewData -Endpoint -RootNode $script:TreeNodeComputerList -Category $Computer.CanonicalName -Entry $Computer.Name -ToolTip 'No ToolTip Data' -IPv4Address $Computer.IPv4Address }
            $script:ComputerTreeView.ExpandAll()
        }
    }
    Save-TreeViewData -Endpoint
}


$ImportEndpointDataFromCsvButtonAdd_MouseHover = {
    Show-ToolTip -Title "Import From CSV File" -Icon "Info" -Message @"
+  Imports data from a selected Comma Separated Value file
+  This file can be easily generated with the following command:
     - Get-ADComputer -Filter * -Properties Name,OperatingSystem,CanonicalName,IPv4Address,MACAddress | Export-Csv "Domain Computers.csv"
+  This file should be formatted with the following headers, though the import script should populate default missing data:
     - Name
     - OperatingSystem
     - CanonicalName
     - IPv4Address
     - MACAddress
     - Notes
"@
}





